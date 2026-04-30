namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2007
{
    public static async Task MethodAsync()
    {
        var task = Task.Delay(1000);
        await task;
    }
}
