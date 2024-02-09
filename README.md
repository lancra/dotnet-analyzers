# .NET Analyzers

Provides severity settings for .NET analyzers I've configured for personal use. Also includes any scripts/documentation used to keep
the lists up-to-date and to generate the configuration files to apply the settings to a repository.

## Rule Sets

- [.NET Code Quality](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/quality-rules)

- [.NET Code Style](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules)

- [StyleCop](https://github.com/DotNetAnalyzers/StyleCopAnalyzers/blob/master/StyleCop.Analyzers/StyleCop.Analyzers.CodeFixes/rulesets/StyleCopAnalyzersDefault.ruleset)

- [xUnit](https://xunit.net/xunit.analyzers/rules/)

## Usage

Run the build script to download rulesets, merge the results with local settings, and output configuration files.

```powershell
./build.ps1
```

The download step can be skipped by providing the associated switch.

```powershell
./build.ps1 -SkipDownload
```
