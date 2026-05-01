namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5394
{
    public static int Method()
    {
        Random random = new();
        return random.Next(6);
    }
}
