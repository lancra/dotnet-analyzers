using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

internal sealed class CA1419(nint invalidHandleValue, bool ownsHandle) : SafeHandle(invalidHandleValue, ownsHandle)
{
    private CA1419()
        : this(0, false)
    {
    }

    public override bool IsInvalid
        => false;

    protected override bool ReleaseHandle()
        => true;
}
