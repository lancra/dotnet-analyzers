using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5373
{
    public static void Method(Rfc2898DeriveBytes bytes, string algname, string alghashname, int keySize, byte[] rgbIV)
#pragma warning disable SYSLIB0033 // Required to surface CA5373.
        => bytes.CryptDeriveKey(algname, alghashname, keySize, rgbIV);
#pragma warning restore SYSLIB0033 // Type or member is obsolete
}
