namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1024(string value)
{
    private readonly string _value = value;

    public string GetValue()
        => _value;
}
