using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1850
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA5350:Do Not Use Weak Cryptographic Algorithms",
        Justification = "This algorithm is required to verify all instances of this diagnostic.")]
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA5351:Do Not Use Broken Cryptographic Algorithms",
        Justification = "This algorithm is required to verify all instances of this diagnostic.")]
    public static void Method(byte[] buffer)
    {
        using var md5 = MD5.Create();
        _ = md5.ComputeHash(buffer);

        using var sha1 = SHA1.Create();
        _ = sha1.ComputeHash(buffer);

        using var sha256 = SHA256.Create();
        _ = sha256.ComputeHash(buffer);

        using var sha384 = SHA384.Create();
        _ = sha384.ComputeHash(buffer);

        using var sha512 = SHA512.Create();
        _ = sha512.ComputeHash(buffer);
    }
}
