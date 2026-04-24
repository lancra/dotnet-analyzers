namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal sealed class CA1513
{
    private bool _disposed;

    public void Method()
    {
        if (_disposed)
        {
            throw new ObjectDisposedException(GetType().Name);
        }

        _disposed = true;
    }
}
