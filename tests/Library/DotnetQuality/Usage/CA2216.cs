using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static partial class CA2216
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Design",
        "CA1060:Move pinvokes to native methods class",
        Justification = "Required to surface CA2216.")]
    public sealed partial class DisposeMissingFinalize : IDisposable
    {
        private readonly IntPtr _unmanagedResource;
        private bool _disposed;

        public DisposeMissingFinalize()
            => _unmanagedResource = AllocateUnmanagedResource();

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        [LibraryImport("native.dll")]
        [DefaultDllImportSearchPaths(DllImportSearchPath.SafeDirectories)]
        private static partial IntPtr AllocateUnmanagedResource();

        [LibraryImport("native.dll")]
        [DefaultDllImportSearchPaths(DllImportSearchPath.SafeDirectories)]
        private static partial void FreeUnmanagedResource(IntPtr p);

        private void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                FreeUnmanagedResource(_unmanagedResource);
                _disposed = true;

                // Suppress finalization of this disposed instance.
                if (disposing)
                {
                }
            }
        }
    }
}
