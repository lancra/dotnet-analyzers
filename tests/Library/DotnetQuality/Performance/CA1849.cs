namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1849
{
    public static Task MethodAsync(FileStream stream)
    {
        stream.ReadExactly([], 2, 3);
        return Task.CompletedTask;
    }
}
