using System.Collections.Immutable;
using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1829
{
    public static void Method()
    {
        int[] array = [];
        ImmutableArray<int> immutableArray = default;
        ICollection<int> genericCollection = [];
        IReadOnlyCollection<int> readOnlyCollection = [];

        if (array.Count() == 0 ||
            immutableArray.Count() == 0 ||
            genericCollection.Count() == 0 ||
            readOnlyCollection.Count() == 0)
        {
            Debug.WriteLine("empty");
        }
    }
}
