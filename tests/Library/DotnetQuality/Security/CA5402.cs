using System.Runtime.Versioning;
using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5402
{
    [SupportedOSPlatform("windows")]
    public static void Method()
    {
        using AesCng aes = new();

        if (RandomNumberGenerator.GetInt32(6) == 4)
        {
            aes.IV = [];
        }

        aes.CreateEncryptor();
    }
}
