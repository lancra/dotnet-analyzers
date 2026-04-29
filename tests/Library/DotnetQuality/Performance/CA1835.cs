namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1835
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Reliability",
        "CA2016:Forward the 'CancellationToken' parameter to methods",
        Justification = "Avoiding the cancellation token is required to test both overloads.")]
    public static async Task MethodAsync(Stream stream, CancellationToken cancellationToken)
    {
        var buffer = new byte[stream.Length];
        await stream.ReadAsync(buffer, 0, buffer.Length)
            .ConfigureAwait(false);
        await stream.ReadAsync(buffer, 0, buffer.Length, cancellationToken)
            .ConfigureAwait(false);
        await stream.WriteAsync(buffer, 0, buffer.Length)
            .ConfigureAwait(false);
        await stream.WriteAsync(buffer, 0, buffer.Length, cancellationToken)
            .ConfigureAwait(false);
    }
}
