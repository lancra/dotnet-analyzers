using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2249
{
    public static void Method()
    {
        var str = "My text";
        bool found;

        found = str.IndexOf('x', StringComparison.Ordinal) == -1;
        Debug.WriteLine(found);
        found = str.IndexOf('x', StringComparison.Ordinal) >= 0;
        Debug.WriteLine(found);

        found = str.IndexOf("text") == -1;
        Debug.WriteLine(found);
        found = str.IndexOf("text") >= 0;
        Debug.WriteLine(found);

        found = str.IndexOf('x', StringComparison.Ordinal) == -1;
        Debug.WriteLine(found);
        found = str.IndexOf('x', StringComparison.Ordinal) >= 0;
        Debug.WriteLine(found);

        found = str.IndexOf("text", StringComparison.Ordinal) == -1;
        Debug.WriteLine(found);
        found = str.IndexOf("text", StringComparison.Ordinal) >= 0;
        Debug.WriteLine(found);

        found = str.IndexOf('x', StringComparison.OrdinalIgnoreCase) == -1;
        Debug.WriteLine(found);
        found = str.IndexOf('x', StringComparison.CurrentCulture) >= 0;
        Debug.WriteLine(found);

        found = str.IndexOf("text", StringComparison.InvariantCultureIgnoreCase) == -1;
        Debug.WriteLine(found);
        found = str.IndexOf("text", StringComparison.InvariantCulture) >= 0;
        Debug.WriteLine(found);

        var index = str.IndexOf("text");
        if (index == -1)
        {
            Debug.WriteLine("'text' Not found.");
        }
    }
}
