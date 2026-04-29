using System.Text.RegularExpressions;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static partial class CA1874
{
    public static bool IsValidEmail(string email)
        => EmailRegex().Match(email).Success;

    [GeneratedRegex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$")]
    private static partial Regex EmailRegex();
}
