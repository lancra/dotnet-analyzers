using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal sealed unsafe class CA2020
{
    private IntPtr _intPointer;
    private long _longValue;

    public void Method()
    {
        checked
        {
            var result = _intPointer + 2;
            Debug.WriteLine(result);

            result = _intPointer - 2;
            Debug.WriteLine(result);

            var voidPointer = (void*)_intPointer;

            result = (IntPtr)voidPointer;
            Debug.WriteLine(result);
        }

        _intPointer = (IntPtr)_longValue;
        var a = (int)_intPointer;
        Debug.WriteLine(a);

        _longValue = 42L;
    }
}
