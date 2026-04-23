namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1070
{
    public virtual event EventHandler ThresholdReached = new(OnThresholdReached);

    public static void OnThresholdReached(object? sender, EventArgs e)
    {
    }
}
