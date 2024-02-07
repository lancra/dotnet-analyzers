function Switch-Environment {
    [CmdletBinding()]
    param ()
    begin {
        $environmentSource = "$PSScriptRoot/../.env"
        $environmentCache = "$PSScriptRoot/../artifacts/cache.env"

        $substitutions = @{
            'ROOT' = "$($PSScriptRoot -replace '\\', '/')/.."
        }

        function Get-EnvironmentVariable {
            [CmdletBinding()]
            [OutputType([hashtable])]
            param (
                [Parameter(Mandatory)]
                [string]$Value
            )
            process {
                $equalsIndex = $Value.IndexOf('=')
                if ($equalsIndex -eq -1) {
                    throw "An environment variable is misconfigured, expected 'KEY=VALUE', actual '$Value'."
                }

                $key = $Value.Substring(0, $equalsIndex)
                $value = $Value.Substring($equalsIndex + 1)

                $substitutionIdentifierIndex = $value.IndexOf('$')
                while ($substitutionIdentifierIndex -ne -1) {
                    $value = Invoke-Substitution -Text $value -Position $substitutionIdentifierIndex
                    $substitutionIdentifierIndex = $value.IndexOf('$')
                }

                @{ 'Key' = $key; 'Value' = $value }
            }
        }

        function Invoke-Substitution {
            [CmdletBinding()]
            [OutputType([string])]
            param (
                [Parameter(Mandatory)]
                [string]$Text,
                [Parameter(Mandatory)]
                [int]$Position
            )
            process {
                $endPosition = $Text.IndexOf('}')
                if ($value[$Position + 1] -ne '{' -or $endPosition -eq -1) {
                    throw "An environment variable substitution is misconfigured, expected '`${TOKEN}'."
                }

                $keyLength = $endPosition - $Position - 2
                $key = $value.Substring($Position + 2, $keyLength)
                $value = $substitutions[$key]
                if ($null -eq $value) {
                    throw "The substitution key $key has not been configured."
                }

                $leftText = $Position -gt 0 ? $Text.Substring(0, $Position) : ''
                $rightText = $endPosition -ne $Text.Length - 1 ? $Text.Substring($endPosition + 1, $Text.Length - $endPosition - 1) : ''
                $leftText + $value + $rightText
            }
        }
    }
    process {
        $hasCache = Test-Path -Path $environmentCache
        $cacheBuilder = [System.Text.StringBuilder]::new()

        $sourceVariables = Get-Content -Path $environmentSource |
            Where-Object { $_ } |
            ForEach-Object { Get-EnvironmentVariable -Value $_ }
        $cacheVariables = $hasCache `
            ? (Get-Content -Path $environmentCache |
                Where-Object { $_ } |
                ForEach-Object { Get-EnvironmentVariable -Value $_ }) `
            : @()

        $sourceVariables |
            ForEach-Object {
                $value = $_['Value']
                if ($hasCache) {
                    $cacheVariable = $cacheVariables |
                        Where-Object -Property Key -EQ $_['Key'] |
                        Select-Object -First 1
                    $value = $cacheVariable ? $cacheVariable['Value'] : $null
                } else {
                    $originalValue = [Environment]::GetEnvironmentVariable($_['Key'], [System.EnvironmentVariableTarget]::Process)
                    if ($originalValue) {
                        [void]$cacheBuilder.AppendLine("$($_['Key'])=$originalValue")
                    }
                }

                [Environment]::SetEnvironmentVariable($_['Key'], $value, [System.EnvironmentVariableTarget]::Process)
            }

        $hasCache `
            ? (Remove-Item -Path $environmentCache) `
            : (Set-Content -Path $environmentCache -Value $cacheBuilder.ToString())
    }
}
