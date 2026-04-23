using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Source Generation",
    "SYSLIB1054: Use LibraryImportAttribute instead of DllImportAttribute to generate p/invoke marshalling code at compile time.",
    Justification = "This rule only applies to DllImportAttribute.")]
internal sealed class CA1060
{
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    internal static extern bool RemoveDirectory(string name);
}
