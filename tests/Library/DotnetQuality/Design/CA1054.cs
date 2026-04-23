namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1054
{
    private readonly List<string> _history = [];

    public void AddToHistory(string uriString)
        => _history.Add(uriString);
}
