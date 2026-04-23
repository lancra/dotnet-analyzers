namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public sealed class CA1063 : IDisposable
{
    void IDisposable.Dispose() => GC.SuppressFinalize(this);
}
