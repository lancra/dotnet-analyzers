namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5378
{
    public static void Method()
        => AppContext.SetSwitch("Switch.System.ServiceModel.DisableUsingServicePointManagerSecurityProtocols", true);
}
