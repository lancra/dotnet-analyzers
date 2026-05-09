namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2215
{
    public class TypeA : IDisposable
    {
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
            }
        }
    }

    public sealed class TypeB : TypeA
    {
        protected override void Dispose(bool disposing)
        {
            if (!disposing)
            {
            }
        }
    }
}
