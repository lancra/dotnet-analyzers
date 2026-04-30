using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2017
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "This diagnostic only surfaces on direct ILogger usages.")]
    public static void Method(ILogger logger)
    {
        var name = "foo";
        var age = 42;

        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation("User {Name} is {Age} years old and lives in {City}", name, age);
            logger.LogError("Error occurred: {Message}", "Something went wrong", "Extra argument");
        }
    }
}
