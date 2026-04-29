using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1833
{
    public static void Method(byte[] array)
    {
        Span<byte> sliceOne = array[0..2];
        Memory<byte> sliceTwo = array[5..8];
        Debug.WriteLine(sliceOne.ToString());
        Debug.WriteLine(sliceTwo.ToString());
    }
}
