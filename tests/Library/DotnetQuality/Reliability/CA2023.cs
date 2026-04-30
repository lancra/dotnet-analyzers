using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2023
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "This diagnostic only surfaces on direct ILogger usages.")]
    public static void Method(ILogger logger)
    {
        var name = "name";
        var value = "value";

        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation("Processing {Name with value {Value}", name, value);
            logger.LogInformation("Processing Name} with value {Value}", name, value);
        }
    }
}
