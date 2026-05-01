using System.Diagnostics;
using Microsoft.IdentityModel.Tokens;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5404
{
    public static void Method()
    {
        TokenValidationParameters parameters = new()
        {
            RequireExpirationTime = false,
            ValidateAudience = false,
            ValidateIssuer = false,
            ValidateLifetime = false,
        };

        Debug.WriteLine(parameters);
    }
}
