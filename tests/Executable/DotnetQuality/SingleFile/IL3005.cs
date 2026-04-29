using System.Diagnostics.CodeAnalysis;
using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.SingleFile;

internal static class IL3005
{
    [RequiresAssemblyFiles]
    [UnmanagedCallersOnly(EntryPoint = "foo")]
    public static void Method()
    {
    }
}
