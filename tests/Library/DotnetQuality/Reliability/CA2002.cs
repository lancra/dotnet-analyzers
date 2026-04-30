using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal sealed class CA2002
{
    public void Method(OutOfMemoryException outOfMemory, StackOverflowException stackOverflow)
    {
        lock (this)
        {
            Debug.WriteLine("In this lock.");
        }

        lock ("foo")
        {
            Debug.WriteLine("In string lock.");
        }

        lock (new int[] { 1, })
        {
            Debug.WriteLine("In Integer array lock.");
        }

        lock (outOfMemory)
        {
            Debug.WriteLine("In OutOfMemoryException lock.");
        }

        lock (stackOverflow)
        {
            Debug.WriteLine("In StackOverflowException lock.");
        }
    }
}
