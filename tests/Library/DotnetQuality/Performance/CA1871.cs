using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1871
{
    public static void Print(int? value)
    {
        ArgumentNullException.ThrowIfNull(value);
        Debug.WriteLine(value.Value);
    }
}
