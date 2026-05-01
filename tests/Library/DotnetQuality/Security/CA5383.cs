using System.Security.Cryptography;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Internal;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5383
{
    public static void Method()
    {
        CookieOptions options = new();

        if (RandomNumberGenerator.GetInt32(6) == 4)
        {
            options.Secure = true;
        }

        ResponseCookies cookies = new(default, default);
        cookies.Append("key", "value", options);
    }
}
