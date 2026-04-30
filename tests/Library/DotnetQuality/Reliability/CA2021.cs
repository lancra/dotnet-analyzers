using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2021
{
    public static void Method()
    {
        List<Food> foods = [];
        var drinksOne = Enumerable.Cast<Beverages>(foods);
        var drinksTwo = Enumerable.OfType<Beverages>(foods);

        Debug.WriteLine($"{drinksOne} {drinksTwo}");
    }

    private class Food
    {
    }

    private sealed class Bread : Food
    {
    }

    private sealed class Beverages
    {
    }
}
