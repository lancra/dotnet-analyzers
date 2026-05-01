using System.Runtime.Versioning;
using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5385
{
    [SupportedOSPlatform("windows")]
    public static void Method()
    {
        using var rsaOne = new RSACng(2047);
#pragma warning disable SYSLIB0007 // Required to surface CA5385 across all scenarios.
        using var rsaTwo = AsymmetricAlgorithm.Create();
#pragma warning restore SYSLIB0007 // Type or member is obsolete
#pragma warning disable SYSLIB0045 // Required to surface CA5385 across all scenarios.
        using var rsaThree = AsymmetricAlgorithm.Create("RSA");
#pragma warning restore SYSLIB0045 // Type or member is obsolete
        var rsaFour = CryptoConfig.CreateFromName("RSA");
        var rsaFive = CryptoConfig.CreateFromName("RSA", 2047);
    }
}
