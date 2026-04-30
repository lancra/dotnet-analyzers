namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2014
{
    public static void Method()
    {
        for (var i = 0; i < 100; i++)
        {
            Span<int> buffer = stackalloc int[100];
            buffer[0] = i;
        }
    }
}
