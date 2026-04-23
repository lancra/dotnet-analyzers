using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal sealed class CA1068
{
    public static async Task MethodAsync(CancellationToken cancellationToken, string value)
    {
        Debug.WriteLine(value);
        await Task.Delay(1, cancellationToken)
            .ConfigureAwait(false);
    }
}
