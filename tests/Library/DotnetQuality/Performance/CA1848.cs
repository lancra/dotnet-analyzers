using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1848
{
    public static void Method(ILogger logger)
        => logger.LogInformation("This is a log message");
}
