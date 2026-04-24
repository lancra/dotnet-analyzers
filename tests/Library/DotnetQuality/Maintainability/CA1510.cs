namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1510
{
    public static void Method(string arg)
    {
        if (arg is null)
        {
            throw new ArgumentNullException(nameof(arg));
        }
    }
}
