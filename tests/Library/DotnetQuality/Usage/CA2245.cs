namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal sealed class CA2245
{
    public CA2245(int p)
    {
        P = p;
        P = P;
    }

    public int P { get; }
}
