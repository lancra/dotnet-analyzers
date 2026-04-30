using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2012
{
    public static async ValueTask<int> GetNumberAsync()
    {
        await Task.Delay(100)
            .ConfigureAwait(false);
        return 42;
    }

    public static async Task MethodAsync()
    {
        var task = GetNumberAsync();
        var first = await task.ConfigureAwait(false);
        var second = await task.ConfigureAwait(false);
        Debug.WriteLine($"{first} {second}");
    }
}
