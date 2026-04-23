namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal sealed class CA1001
{
    private readonly Disposable _disposable;

    public CA1001()
        => _disposable = new();

    public string Test()
        => _disposable.Test();

    private sealed class Disposable : IDisposable
    {
        private readonly string _value = "foo";

        public string Test()
            => _value;

        public void Dispose()
        {
        }
    }
}
