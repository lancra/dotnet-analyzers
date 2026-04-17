# .NET Analyzers

Provides severity settings for .NET analyzers I've configured for personal use. Also includes any scripts/documentation used to keep
the lists up-to-date and to generate the configuration files to apply the settings to a repository.

## Rule Sets

Name|Package
-|-
[.NET Code Quality](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/quality-rules)|![microsoft.codeanalysis.netanalyzers](https://img.shields.io/nuget/v/microsoft.codeanalysis.netanalyzers)
[.NET Code Style](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules)|![built-in](https://img.shields.io/badge/.NET-512BD4?logo=dotnet&logoColor=fff)
[Exceptionator](https://github.com/elmahio/Exceptionator/blob/main/README.md)|![theexceptionator.analyzers](https://img.shields.io/nuget/v/theexceptionator.analyzers)
[StyleCop](https://github.com/DotNetAnalyzers/StyleCopAnalyzers/blob/master/StyleCop.Analyzers/StyleCop.Analyzers.CodeFixes/rulesets/StyleCopAnalyzersDefault.ruleset)|![stylecop.analyzers.unstable](https://img.shields.io/nuget/v/stylecop.analyzers.unstable)
[TUnit](https://github.com/thomhurst/TUnit/blob/main/TUnit.Analyzers/AnalyzerReleases.Shipped.md)|![tunit](https://img.shields.io/nuget/v/tunit)
[Visual Studio Threading](https://microsoft.github.io/vs-threading/analyzers/index.html)|![microsoft.visualstudio.threading.analyzers](https://img.shields.io/nuget/v/microsoft.visualstudio.threading.analyzers)
[xUnit](https://xunit.net/xunit.analyzers/rules/)|![xunit.v3](https://img.shields.io/nuget/v/xunit.v3)

## Usage

Execution of the build script performs the following steps:

1. Update user preferences from the latest rule set configuration.
1. Download rule sets from their sources.
1. Merge rules and options with local settings.
1. Create configuration artifacts.

```powershell
./build.ps1
```

The download step can be skipped by providing the associated switch.

```powershell
./build.ps1 -SkipDownload
```

The download step can also be executed in isolation, which is useful to check for any new rules or options.

```powershell
./build.ps1 -DownloadOnly
```
