namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1030
{
    private readonly List<Action> _clickHandlers = [];

    public void AddOnClick(Action handler)
        => _clickHandlers.Add(handler);
}
