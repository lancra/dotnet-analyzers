namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1855
{
    public static void Method(Span<byte> span)
        => span.Fill(0);
}
