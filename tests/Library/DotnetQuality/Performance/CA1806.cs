using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1806
{
    public static void PrintTitle(string title)
    {
        ArgumentException.ThrowIfNullOrEmpty(title);
        title.Trim();
        Debug.WriteLine(title);
    }

    public static void PrintItem()
    {
        var item = new Item();
        new Item();
        Debug.WriteLine(item);
    }

    private sealed class Item
    {
    }
}
