using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1060:Move pinvokes to native methods class",
    Justification = "Deviates from rule ID naming standard.")]
internal sealed class CA2101
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Source Generation",
        "SYSLIB1054: Use LibraryImportAttribute instead of DllImportAttribute to generate p/invoke marshalling code at compile time.",
        Justification = "This rule only applies to DllImportAttribute.")]
    [DllImport("advapi32.dll", CharSet = CharSet.Auto)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    internal static extern int RegCreateKey(IntPtr key, string subKey, out IntPtr result);
}
