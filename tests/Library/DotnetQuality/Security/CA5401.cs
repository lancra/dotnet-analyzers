using System.Runtime.Versioning;
using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5401
{
    [SupportedOSPlatform("windows")]
    public static void Method()
    {
        using AesCng aes = new()
        {
            IV = [],
        };
        aes.CreateEncryptor();
    }
}
