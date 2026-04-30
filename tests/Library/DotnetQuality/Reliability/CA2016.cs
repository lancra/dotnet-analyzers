using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2016
{
    public static void MethodWithDefault(CancellationToken cancellationToken = default)
        => Debug.WriteLine(cancellationToken.ToString());

    public static void MethodWithOverload()
    {
    }

    public static void MethodWithOverload(CancellationToken cancellationToken)
        => Debug.WriteLine(cancellationToken.ToString());

    public static void Method(CancellationToken cancellationToken)
    {
        MethodWithDefault();
        MethodWithOverload();

        Debug.WriteLine(cancellationToken.ToString());
    }
}
