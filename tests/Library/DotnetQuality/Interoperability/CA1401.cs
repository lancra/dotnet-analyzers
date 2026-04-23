using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1060:Move pinvokes to native methods class",
    Justification = "Deviates from rule ID naming standard.")]
public static class CA1401
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Source Generation",
        "SYSLIB1054: Use LibraryImportAttribute instead of DllImportAttribute to generate p/invoke marshalling code at compile time.",
        Justification = "This rule only applies to DllImportAttribute.")]
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    public static extern bool RemoveDirectory(string name);
}
