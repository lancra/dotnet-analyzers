using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2025
{
    public static Task MethodAsync()
    {
        using var disposable = new DisposableThing();
        return DoSomethingInternalAsync(disposable);
    }

    public static async Task DoThingsAsync()
    {
        var disposable = new DisposableThing();
        var task = DoSomethingInternalAsync(disposable);
        disposable.Dispose();
        await task.ConfigureAwait(false);
    }

    private static Task DoSomethingInternalAsync(DisposableThing disposable)
    {
        Debug.WriteLine(disposable.ToString());
        return Task.CompletedTask;
    }

    private sealed class DisposableThing : IDisposable
    {
        public void Dispose()
        {
            Dispose(disposing: true);
            GC.SuppressFinalize(this);
        }

        private static void Dispose(bool disposing)
        {
            if (disposing)
            {
                Debug.WriteLine("Disposing.");
            }
        }
    }
}
