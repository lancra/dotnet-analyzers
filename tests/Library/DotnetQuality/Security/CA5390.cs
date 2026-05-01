using System.Security.Cryptography;
using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5390
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA5401:Do not use CreateEncryptor with non-default IV",
        Justification = "Required to surface CA5390.")]
    public static void Method(byte[] iv)
    {
#pragma warning disable SYSLIB0007 // Required to surface CA5390.
        using var algorithm = SymmetricAlgorithm.Create();
#pragma warning restore SYSLIB0007 // Type or member is obsolete

        var keyOne = Convert.FromBase64String("AAAAAaazaoensuth");
        algorithm.CreateEncryptor(keyOne, iv);

        var keyTwo = Encoding.ASCII.GetBytes("AAAAAaazaoensuth");
        algorithm.CreateEncryptor(keyTwo, iv);
    }
}
