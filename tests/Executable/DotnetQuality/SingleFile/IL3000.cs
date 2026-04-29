namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.SingleFile;

internal static class IL3000
{
    public static string GetLocation()
        => System.Reflection.Assembly.GetExecutingAssembly().Location;
}
