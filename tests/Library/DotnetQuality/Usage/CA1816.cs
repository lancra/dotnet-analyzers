namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA1816
{
    public class Class : IDisposable
    {
        public static void Other()
            => GC.SuppressFinalize("foo");

        public void Dispose()
            => Dispose(disposing: true);

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
            }
        }
    }

    public sealed class OtherClass : Class
    {
    }
}
