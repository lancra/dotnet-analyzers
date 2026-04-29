using System.Collections.Immutable;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1868
{
    public static void Method(ISet<string> set)
    {
        if (!set.Contains("foo"))
        {
            set.Add("foo");
        }
    }

    public static void Method(ICollection<string> collection)
    {
        if (collection.Contains("foo"))
        {
            collection.Remove("foo");
        }
    }

    public static void Method(IImmutableSet<string> set)
    {
        if (!set.Contains("foo"))
        {
            set.Add("foo");
        }

        if (set.Contains("bar"))
        {
            set.Remove("bar");
        }
    }
}
