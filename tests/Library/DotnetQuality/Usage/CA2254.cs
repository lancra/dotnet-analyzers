using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2254
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "CA2254 only surfaces on ILogger extension methods.")]
    public static void Method(ILogger logger, string firstName, string lastName)
    {
        if (logger.IsEnabled(LogLevel.Warning))
        {
            logger.LogWarning("Person " + firstName + " " + lastName + " encountered an issue");
            logger.LogWarning($"Person {firstName} {lastName} encountered an issue");
        }
    }
}
