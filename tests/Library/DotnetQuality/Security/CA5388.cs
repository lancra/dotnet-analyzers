using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5388
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA5379:Ensure Key Derivation Function algorithm is sufficiently strong",
        Justification = "Required to surface CA5388.")]
    public static void Method()
    {
        var iterations = 100;

        if (RandomNumberGenerator.GetInt32(6) == 4)
        {
            iterations = 100_000;
        }

#pragma warning disable SYSLIB0060 // Required to surface CA5388.
        using var bytes = new Rfc2898DeriveBytes("password", [], iterations);
#pragma warning restore SYSLIB0060 // Type or member is obsolete
        bytes.GetBytes(42);
    }
}
