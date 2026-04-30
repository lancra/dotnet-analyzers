namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2013
{
    public static bool Method(int one, int two)
        => ReferenceEquals(one, two);
}
