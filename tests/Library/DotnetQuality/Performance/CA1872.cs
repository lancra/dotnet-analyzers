using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1872
{
    private static readonly byte[] Data = Encoding.ASCII.GetBytes("Hello World");

    public static string Encode()
        => BitConverter.ToString(Data)
        .Replace("-", string.Empty, StringComparison.OrdinalIgnoreCase);

    public static string EncodeToUpper()
        => BitConverter.ToString(Data)
        .Replace("-", string.Empty, StringComparison.OrdinalIgnoreCase)
        .ToUpperInvariant();
}
