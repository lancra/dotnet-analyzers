using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1863
{
    private const string Constant = "Format one value: {0}";

    public static void Method()
    {
        _ = string.Format(Constant, 42);

        var builder = new StringBuilder();
        builder.AppendFormat(Constant, 42);
    }
}
