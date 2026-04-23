namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1304
{
    public static void BadMethod(char character)
        => Console.WriteLine(char.ToLower(character));
}
