using System.Diagnostics;
using System.Runtime.Versioning;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2252
{
    public static void Method()
        => Execute();

    [RequiresPreviewFeatures]
    private static void Execute()
        => Debug.WriteLine("test");
}
