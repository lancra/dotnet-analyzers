namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2018
{
    public static void Method()
    {
        int[] source = [1, 2, 3, 4];
        int[] target = [0, 0, 0, 0];

        Buffer.BlockCopy(source, 0, target, 0, source.Length);
    }
}
