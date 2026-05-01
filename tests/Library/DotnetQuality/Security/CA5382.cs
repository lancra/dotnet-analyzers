using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Internal;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5382
{
    public static void Method()
    {
        CookieOptions options = new()
        {
            Secure = false,
        };

        ResponseCookies cookies = new(default, default);
        cookies.Append("key", "value", options);
    }
}
