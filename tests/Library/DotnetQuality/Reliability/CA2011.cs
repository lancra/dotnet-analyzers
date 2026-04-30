namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal sealed class CA2011(int p)
{
    private readonly int _p = p;

    public int P
    {
        get => _p;
        set => P = value;
    }
}
