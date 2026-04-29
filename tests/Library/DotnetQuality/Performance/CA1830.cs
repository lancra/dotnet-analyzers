using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1830
{
    public static void Method(StringBuilder builder, int value)
        => builder.Append("Value ToString():")
        .Append(value.ToString())
        .Append(",Value:")
        .Append(value);
}
