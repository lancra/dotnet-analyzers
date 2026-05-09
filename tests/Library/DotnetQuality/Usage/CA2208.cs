namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2208
{
    public static void ArgumentException(string param)
        => throw new ArgumentException(nameof(param), nameof(param));

    public static void ArgumentNullException(string param)
        => throw new ArgumentNullException(nameof(param), nameof(param));
}
