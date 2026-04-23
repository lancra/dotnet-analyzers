namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1002
{
    public List<string> List { get; private set; } = [];

    public List<string> GetValue(string value)
        => [.. List, value];

    public void SetValue(List<string> list)
        => List = list;
}
