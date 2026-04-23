using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.Interoperability;

internal static class CA1421
{
    public static nint Test()
        => Marshal.OffsetOf<ValueType>("Field");

    private struct ValueType(int field)
    {
        public int Field = field;
    }
}
