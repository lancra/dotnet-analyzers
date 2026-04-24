namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1511
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Usage",
        "EX001:Exception should include a message",
        Justification = "This rule appears to only fire when an empty message is provided.")]
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "StyleCop.CSharp.ReadabilityRules",
        "SA1122:Use string.Empty for empty strings",
        Justification = "This rule appears to only fire when an empty message is provided.")]
    public static void Method(string arg)
    {
        if (string.IsNullOrEmpty(arg))
        {
            throw new ArgumentException("", nameof(arg));
        }
    }
}
