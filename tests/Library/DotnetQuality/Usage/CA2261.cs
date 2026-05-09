namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2261
{
    public static Task Method()
    {
        Task<int> task = new(() => 1);
        task.ConfigureAwait(ConfigureAwaitOptions.SuppressThrowing);
        return task;
    }
}
