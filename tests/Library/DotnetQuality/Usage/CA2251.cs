using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2251
{
    public static void Method(string leftValue, string rightValue)
    {
        var areEqualUsingCompare = string.Compare(leftValue, rightValue, StringComparison.OrdinalIgnoreCase) == 0;
        Debug.WriteLine(areEqualUsingCompare);
    }
}
