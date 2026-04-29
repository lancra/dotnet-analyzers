namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.SingleFile;

internal static class IL3001
{
    public static IReadOnlyCollection<FileStream> GetLocation()
        => System.Reflection.Assembly.GetExecutingAssembly().GetFiles();
}
