using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal readonly struct CA2260 : IParsable<DateOnly>
{
    public static DateOnly Parse(string s, IFormatProvider? provider)
        => new(2025, 1, 1);

    public static bool TryParse([NotNullWhen(true)] string? s, IFormatProvider? provider, [MaybeNullWhen(false)] out DateOnly result)
    {
        ArgumentException.ThrowIfNullOrEmpty(s);
        result = Parse(s, provider);
        return true;
    }
}
