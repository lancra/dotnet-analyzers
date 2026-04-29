// DISABLED: Microsoft has not yet shipped this analyzer as of 2026-04-29.
//           See: https://github.com/dotnet/sdk/blob/main/src/Microsoft.CodeAnalysis.NetAnalyzers/src/Microsoft.CodeAnalysis.NetAnalyzers/AnalyzerReleases.Unshipped.md
namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1877
{
    public static string GetFilePath(string folder, string subfolder, string fileName)
    {
        var targetDirectory = Path.Combine(folder, subfolder);
        return Path.Combine(targetDirectory, fileName);
    }

    public static string GetLogPath(string baseDirectory, string date, string category)
        => Path.Join(Path.Join(baseDirectory, date), category);
}
