namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

public class CA1721(string dateText)
{
    private readonly string _dateText = dateText;

    public DateTime Date => DateTime.Parse(_dateText);

    public string GetDate()
        => Date.ToString();
}
