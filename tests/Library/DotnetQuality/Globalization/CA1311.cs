namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1311
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Globalization",
        "CA1304:Specify CultureInfo",
        Justification = "These rules duplicate coverage but still provide separate value propositions.")]
    public static string Normalize(string text)
        => text.ToUpper();
}
