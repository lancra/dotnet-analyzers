namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1021(string value)
{
    private string Value { get; } = value;

    public void Test(out string value)
        => value = Value;
}
