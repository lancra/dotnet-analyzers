using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[assembly: DisableRuntimeMarshalling]

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.Interoperability;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1060:Move pinvokes to native methods class",
    Justification = "Deviates from rule ID naming standard.")]
internal static class CA1420
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Source Generation",
        "SYSLIB1054: Use LibraryImportAttribute instead of DllImportAttribute to generate p/invoke marshalling code at compile time.",
        Justification = "This rule only applies to DllImportAttribute.")]
    [DllImport("NativeLibrary", SetLastError = true)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    public static extern void MyMethod();
}
