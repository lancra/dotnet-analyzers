using System.Collections.Immutable;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2009
{
    public static void Method()
    {
        ImmutableArray<int> array = default;
        _ = array.ToImmutableArray();

        ImmutableList<int> list = [];
        _ = list.ToImmutableList();

        ImmutableHashSet<int> hashSet = [];
        _ = hashSet.ToImmutableHashSet();

        ImmutableSortedSet<int> sortedSet = [];
        _ = sortedSet.ToImmutableSortedSet();

        ImmutableDictionary<int, int> dictionary = [];
        _ = dictionary.ToImmutableDictionary();

        var sortedDictionary = ImmutableSortedDictionary<int, int>.Empty;
        _ = sortedDictionary.ToImmutableSortedDictionary();
    }
}
