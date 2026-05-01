using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5387
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA5379:Ensure Key Derivation Function algorithm is sufficiently strong",
        Justification = "Required to surface CA5387.")]
    public static void Method()
    {
#pragma warning disable SYSLIB0060 // Required to surface CA5387.
        using var bytes = new Rfc2898DeriveBytes("password", []);
#pragma warning restore SYSLIB0060 // Type or member is obsolete
        bytes.GetBytes(42);
    }
}
