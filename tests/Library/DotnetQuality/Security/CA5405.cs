using Microsoft.IdentityModel.Tokens;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5405
{
    public static void Method()
    {
        TokenValidationParameters parameters = new()
        {
            AudienceValidator = (audiences, token, tvp) => true,
        };
    }
}
