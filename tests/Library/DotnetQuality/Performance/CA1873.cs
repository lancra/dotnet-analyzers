using Microsoft.Extensions.Logging;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1873
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1848:Use the LoggerMessage delegates",
        Justification = "This diagnostic only surfaces on direct ILogger usages.")]
    public static void Method(ILogger logger, int[] data)
    {
        logger.LogDebug("Processing {Items} items", string.Join(", ", data));
        logger.LogTrace("Data: {Data}", new { Count = data.Length, Items = data, });
    }
}
