[CmdletBinding()]
param()

. "$PSScriptRoot/Get-Rule.ps1"

$ruleSet = Get-RuleSet -CurrentDirectory
$helpUriFormat = $ruleSet.HelpUriFormat

$repositoryContentsUriFormat = '/repos/elmahio/Exceptionator/contents/{0}'

$readmeFileUri = $repositoryContentsUriFormat -f 'README.md'
$readmeLines = Get-GitHubFileLine -Uri $readmeFileUri

$ruleJobs = @()
$ruleFunctionDefinition = ${function:Get-Rule}.ToString()
$ruleSetDirectoryPath = $PSScriptRoot

$rules = @()

$ruleFilesUri = $repositoryContentsUriFormat -f 'src/ExceptionAnalyzer'
& gh api $ruleFilesUri |
    ConvertFrom-Json |
    Where-Object { $_.path.EndsWith('Analyzer.cs') } |
    Where-Object { -not $_.path.EndsWith('NoopAnalyzer.cs') } |
    ForEach-Object {
        $ruleJob = Start-ThreadJob -Name $_.path -ScriptBlock {
            param(
                [string] $Uri
            )

            ${function:Get-Rule} = $using:ruleFunctionDefinition

            $getRuleArguments = @{
                Uri = $Uri
                HelpUriFormat = $using:helpUriFormat
                Directory = $using:ruleSetDirectoryPath
                ReadmeLine = $using:readmeLines
            }
            return Get-Rule @getRuleArguments
        } -ArgumentList (,$_.url)
        $ruleJobs += $ruleJob
    }

Wait-Job $ruleJobs |
    Out-Null

$ruleJobs |
    ForEach-Object {
        $rule = Receive-Job -Job $_
        $rules += $rule
        Remove-Job -Job $_
    }

New-RuleSpecification -Rule $rules
