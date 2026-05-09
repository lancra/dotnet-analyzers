using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2250
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Usage",
        "EX001:Exception should include a message",
        Justification = "Adding a message causes CA2250 to no longer fire.")]
    public static void Method(CancellationToken cancellationToken)
    {
        if (cancellationToken.IsCancellationRequested)
        {
            throw new OperationCanceledException();
        }

        if (cancellationToken.IsCancellationRequested)
        {
            throw new OperationCanceledException();
        }
        else
        {
            Debug.WriteLine("test");
        }
    }
}
