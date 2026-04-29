using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.SingleFile;

internal static class IL3002
{
    [RequiresAssemblyFiles("Use 'MethodFriendlyToSingleFile' instead", Url = "http://help/assemblyfiles")]
    public static void MethodWithAssemblyFilesUsage()
    {
    }

    public static void Method()
        => MethodWithAssemblyFilesUsage();
}
