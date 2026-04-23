namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1307
{
    public static int GetIndex(string text)
        => text.IndexOf('.');
}
