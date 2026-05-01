using System.Diagnostics;
using System.Runtime.ExceptionServices;
using System.Security;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2153
{
#pragma warning disable SYSLIB0032 // This attribute is required for CA2153.
    [HandleProcessCorruptedStateExceptions]
#pragma warning restore SYSLIB0032 // Type or member is obsolete
    [SecurityCritical]
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Design",
        "CA1031:Do not catch general exception types",
        Justification = "This is required to surface CA2153.")]
    public static void Method()
    {
        try
        {
            Debug.WriteLine("foo");
        }
        catch (Exception e)
        {
            Debug.WriteLine(e.Message);
        }
    }
}
