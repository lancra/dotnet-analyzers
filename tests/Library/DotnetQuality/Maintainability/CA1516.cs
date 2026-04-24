using System.Runtime.Intrinsics;
using System.Runtime.Intrinsics.Arm;
using System.Runtime.Intrinsics.Wasm;
using System.Runtime.Intrinsics.X86;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1516
{
    public static Vector128<byte> M1(Vector128<byte> x, Vector128<byte> y)
        => AdvSimd.Add(x, y);

    public static Vector128<byte> M2(Vector128<byte> x, Vector128<byte> y)
        => Sse2.Add(x, y);

    public static Vector128<byte> M3(Vector128<byte> x, Vector128<byte> y)
        => PackedSimd.Add(x, y);
}
