using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1832
{
    public static void Method(byte[] array)
    {
        ReadOnlySpan<byte> sliceOne = array[0..2];
        ReadOnlyMemory<byte> sliceTwo = array[5..8];
        Debug.WriteLine(sliceOne.ToString());
        Debug.WriteLine(sliceTwo.ToString());
    }
}
