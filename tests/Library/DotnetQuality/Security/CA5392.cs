using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5392
{
    internal static class NativeMethods
    {
        [DllImport("The3rdAssembly.dll", CharSet = CharSet.Unicode)]
#pragma warning disable SYSLIB1054 // Required to surface CA5392.
        public static extern int MessageBox(IntPtr hWnd, string text, string caption, uint type);
#pragma warning restore SYSLIB1054 // Use 'LibraryImportAttribute' instead of 'DllImportAttribute' to generate P/Invoke marshalling code at compile time
    }
}
