using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5351
{
    public static void Method()
    {
        using var md5 = MD5.Create();
        using var rc2 = RC2.Create();
        using var des = DES.Create();
    }
}
