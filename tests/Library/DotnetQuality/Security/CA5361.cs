namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5361
{
    public static void Method()
        => AppContext.SetSwitch("Switch.System.Net.DontEnableSchUseStrongCrypto", true);
}
