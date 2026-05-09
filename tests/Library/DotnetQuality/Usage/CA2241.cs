using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2241
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Globalization",
        "CA1303:Do not pass literals as localized parameters",
        Justification = "Required to surface CA2241.")]
    public static void Method(string file, string errors)
    {
        Console.Write("{0}", file, errors);
        Console.Write("{0}: {1}, {2}", file, errors);
        Console.WriteLine("{0}", file, errors);
        Console.WriteLine("{0}: {1}, {2}", file, errors);
        Debug.WriteLine(string.Format("{0}", file, errors));
        Debug.WriteLine(string.Format("{0}: {1}, {2}", file, errors));
    }
}
