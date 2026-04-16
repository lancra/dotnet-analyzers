function Get-RuleSet {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Id,

        [switch] $CurrentDirectory,
        [switch] $Enabled
    )
    begin {
        if ($Id -and $CurrentDirectory) {
            Write-Error "The Id and CurrentDirectory parameters are mutually exclusive. The latter will take precedence."
        }
    }
    process {
        $rootDirectoryPath = Join-Path -Path $PSScriptRoot -ChildPath '..'
        $configurationPath = Join-Path -Path $rootDirectoryPath -ChildPath 'configuration.json'
        $preferencesPath = Join-Path -Path $rootDirectoryPath -ChildPath '.preferences.json'

        if ($CurrentDirectory) {
            $callStackFrames = Get-PSCallStack
            if (-not $callStackFrames -or -not $callStackFrames -is [array] -or $callStackFrames.Length -le 1) {
                throw "Unable to find the executing script from the current call stack."
            }

            $callingPath = $callStackFrames[1].ScriptName
            $callingDirectory = [System.IO.Path]::GetDirectoryName($callingPath)
            $Id = ([uri]$callingDirectory).Segments[-1]
        }

        $preferencesSpecification = Get-Content -Path $preferencesPath |
            ConvertFrom-Json
        $preferences = $preferencesSpecification.PSObject.Properties |
            Where-Object { -not $Id -or $_.Name -eq $Id } |
            ForEach-Object {
                [pscustomobject]@{
                    Id = $_.Name
                    Enabled = $_.Value.enabled
                    Properties = $_.Value.properties
                }
            }

        $categoryProperties = @(
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'IndexUri'; Expression = { $_.indexUri ?? $_.ruleSetIndexUri } }
        )
        $ruleSetProperties = @(
            @{ Name = 'Id'; Expression = { $_.id } },
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'IndexUri'; Expression = { $_.indexUri }},
            @{ Name = 'HelpUriFormat'; Expression = { $_.helpUriFormat } },
            @{
                Name = 'Categories'
                Expression = {
                    $ruleSet = $_
                    $ruleSet.categories |
                        ForEach-Object {
                            $_ |
                                Add-Member -MemberType NoteProperty -Name 'ruleSetIndexUri' -Value $ruleSet.IndexUri
                        }

                    $ruleSet.categories |
                        Select-Object -Property $categoryProperties
                }
            },
            @{
                Name = 'Enabled'
                Expression = {
                    $preferences |
                        Where-Object -Property Id -EQ $_.id |
                        Select-Object -ExpandProperty Enabled
                }
            },
            @{
                Name = 'Properties'
                Expression = {
                    $preferences |
                        Where-Object -Property Id -EQ $_.id |
                        Select-Object -ExpandProperty Properties
                }
            }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Select-Object -Property $ruleSetProperties |
            Where-Object { -not $Enabled -or $_.Enabled -eq $true } |
            Where-Object { -not $Id -or $_.Id -eq $Id }
    }
}
