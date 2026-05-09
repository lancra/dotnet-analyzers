using System.Collections;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

public sealed class CA2227
{
    private static readonly string[] Strings = ["one", "two", "three"];

    public CA2227()
        => SomeStrings = new(Strings);

    public ArrayList SomeStrings { get; set; }
}
