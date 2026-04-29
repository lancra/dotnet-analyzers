using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1839
{
    public static void Method()
    {
#pragma warning disable CS8602 // Adding the null-coalescing operator causes this rule to no longer trigger.
        var path = Process.GetCurrentProcess().MainModule.FileName;
#pragma warning restore CS8602 // Dereference of a possibly null reference.
        Debug.WriteLine(path);
    }
}
