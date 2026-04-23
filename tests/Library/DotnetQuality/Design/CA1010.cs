using System.Collections;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Naming",
    "CA1710:Identifiers should have correct suffix",
    Justification = "Deviates from rule ID naming standard.")]
public class CA1010 : IEnumerable
{
    private readonly IList<string> _list = [];

    public IEnumerator GetEnumerator() => _list.GetEnumerator();
}
