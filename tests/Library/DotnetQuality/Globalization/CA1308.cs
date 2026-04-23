using System.Globalization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1308
{
    public static string Normalize(string text)
        => text.ToLower(CultureInfo.InvariantCulture);
}
