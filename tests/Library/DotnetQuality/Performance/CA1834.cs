using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1834
{
    public static void Method(StringBuilder builder)
        => builder.Append("a");
}
