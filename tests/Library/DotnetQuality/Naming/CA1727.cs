using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

internal sealed class CA1727(ILogger<CA1727> logger)
{
    private readonly ILogger<CA1727> _logger = logger;

    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "This rule does not trigger for LoggerMessageAttribute per dotnet/roslyn-analyzers#6051.")]
    public void Create(string firstName, string lastName)
    {
        if (_logger.IsEnabled(LogLevel.Information))
        {
            _logger.LogInformation("Creating user {firstName} {lastName}", firstName, lastName);
        }
    }
}
