[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string] $Id,

    [Parameter()]
    [ValidateScript(
        {
            $projects = Get-ChildItem -Path "$PSScriptRoot/../tests" -Directory |
                Select-Object -ExpandProperty Name
            $_ -in $projects
        },
        ErrorMessage = 'Project not found.')]
    [ArgumentCompleter(
        {
            param($commandName, $parameterName, $wordToComplete)
            $projects = Get-ChildItem -Path "$PSScriptRoot/../tests" -Directory |
                Select-Object -ExpandProperty Name
            $projects -like "$wordToComplete*"
        })]
    [string] $Project = 'Library'
)

$existingItems = Get-ChildItem -Filter "$Id.cs" -Recurse
if ($null -ne $existingItems) {
    Write-Output "Already exists."
    exit 1
}

$rule = Get-Content -Path "$PSScriptRoot/../src/data-sets/rule-settings.csv" |
    ConvertFrom-Csv |
    Where-Object -Property Id -EQ $Id

$ruleSet = Get-Content -Path "$PSScriptRoot/../configuration.json" |
    ConvertFrom-Json |
    Select-Object -ExpandProperty 'ruleSets' |
    Where-Object -Property 'name' -EQ $rule.RuleSet

$ruleSetNamespace = $ruleSet.namespace ?? $ruleSet.name
$categoryNamespace = $null
if ($rule.Category) {
    $category = $ruleSet |
        Select-Object -ExpandProperty 'categories' |
        Where-Object -Property 'name' -EQ $rule.Category
    $categoryNamespace = $category.namespace ?? $category.name
}

$projectDirectory = "$PSScriptRoot/../tests/$Project"
$targetDirectory = "$projectDirectory/$ruleSetNamespace"
New-Item -ItemType Directory -Path $targetDirectory -ErrorAction SilentlyContinue |
    Out-Null

if ($categoryNamespace) {
    $targetDirectory = "$targetDirectory/$categoryNamespace"
    New-Item -ItemType Directory -Path $targetDirectory -ErrorAction SilentlyContinue |
        Out-Null
}

$builder = [System.Text.StringBuilder]::new()

$namespaceSegment = $categoryNamespace ? "$ruleSetNamespace.$categoryNamespace" : $ruleSetNamespace
[void]$builder.AppendLine("namespace DotnetAnalyzers.SmokeTests.$Project.$namespaceSegment;")
[void]$builder.AppendLine()
[void]$builder.AppendLine("internal sealed class $Id")
[void]$builder.AppendLine('{')
[void]$builder.Append('}')

$targetPath = "$targetDirectory/$Id.cs"
Set-Content -Path $targetPath -Value ($builder.ToString())
& code $targetPath
