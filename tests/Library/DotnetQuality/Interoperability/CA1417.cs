using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1060:Move pinvokes to native methods class",
    Justification = "Deviates from rule ID naming standard.")]
internal static class CA1417
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Source Generation",
        "SYSLIB1054: Use LibraryImportAttribute instead of DllImportAttribute to generate p/invoke marshalling code at compile time.",
        Justification = "This rule only applies to DllImportAttribute.")]
    [DllImport("MyLibrary", CharSet = CharSet.Unicode)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    private static extern void Foo([Out] string s);
}
