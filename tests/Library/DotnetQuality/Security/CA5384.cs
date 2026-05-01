using System.Runtime.Versioning;
using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5384
{
    [SupportedOSPlatform("windows")]
    public static DSACng Method()
        => new();
}
