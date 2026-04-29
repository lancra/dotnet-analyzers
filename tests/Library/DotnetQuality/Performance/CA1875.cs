using System.Text.RegularExpressions;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static partial class CA1875
{
    public static int IsValidEmail(string email)
        => EmailRegex().Matches(email).Count;

    [GeneratedRegex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$")]
    private static partial Regex EmailRegex();
}
