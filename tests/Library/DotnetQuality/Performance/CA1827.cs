using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1827
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1851:Possible multiple enumerations of 'IEnumerable' collection",
        Justification = "Enumerable is required to avoid additional suppressions on collections that provide a Count property.")]
    public static void Method(IEnumerable<string> list)
    {
        Debug.WriteLine(list.Count() != 0 ? "not empty" : "empty");
        Debug.WriteLine(list.Count() == 0 ? "empty" : "not empty");
        Debug.WriteLine(list.Count() > 0 ? "not empty" : "empty");
        Debug.WriteLine(list.LongCount() != 0 ? "not empty" : "empty");
        Debug.WriteLine(list.LongCount() == 0 ? "empty" : "not empty");
        Debug.WriteLine(list.LongCount() > 0 ? "not empty" : "empty");
    }
}
