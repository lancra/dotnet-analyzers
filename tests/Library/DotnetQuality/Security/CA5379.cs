using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5379
{
    public static Rfc2898DeriveBytes Method(byte[] password, byte[] salt, int iterations)
#pragma warning disable SYSLIB0060 // Required to surface CA5379.
        => new(password, salt, iterations, HashAlgorithmName.MD5);
#pragma warning restore SYSLIB0060 // Type or member is obsolete
}
