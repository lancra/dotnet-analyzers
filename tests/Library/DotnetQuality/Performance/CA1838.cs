using System.Runtime.InteropServices;
using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1060:Move pinvokes to native methods class",
    Justification = "Deviates from rule ID naming standard.")]
internal sealed class CA1838
{
    [DllImport("MyLibrary", CharSet = CharSet.Unicode)]
    [DefaultDllImportSearchPaths(DllImportSearchPath.UserDirectories)]
    private static extern void Foo(StringBuilder sb, ref int length);
}
