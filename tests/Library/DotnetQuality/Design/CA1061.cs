using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal sealed class CA1061 : BaseType
{
    private readonly string _name = "Derived";

    internal void Method(string one, object two)
        => Debug.WriteLine($"{_name}:One={one},Two={two}");
}

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "StyleCop.CSharp.MaintainabilityRules",
    "SA1402:File may only contain a single type",
    Justification = "A base type is needed to trigger this rule.")]
internal class BaseType
{
    private readonly string _name = "Base";

    internal void Method(string one, string two)
        => Debug.WriteLine($"{_name}:One={one},Two={two}");
}
