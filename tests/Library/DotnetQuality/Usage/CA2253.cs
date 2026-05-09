using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2253
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "CA2253 only surfaces on ILogger extension methods.")]
    public static void Method(ILogger logger, string firstName, string lastName)
    {
        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation("Adding user with first name {0} and last name {1}", firstName, lastName);
            logger.LogInformation("Adding user with first name {FirstName} and last name {LastName}", firstName, lastName);
        }
    }
}
