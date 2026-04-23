namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1309
{
    public static int Check(string one, string two)
        => string.Compare(one, two);
}
