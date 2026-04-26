using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1034:Nested types should not be visible",
    Justification = "Multiple public types are required to surface this rule across various scenarios.")]
public static class CA1715
{
    /// <summary>
    /// This is an interface.
    /// </summary>
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "StyleCop.CSharp.NamingRules",
        "SA1302:Interface names should begin with I",
        Justification = "The rules cover the same scenario but at different scopes.")]
    public interface AnInterface
    {
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "StyleCop.CSharp.NamingRules",
        "SA1314:Type parameter names should begin with T",
        Justification = "The rules cover the same scenario but at different scopes.")]
    public static void Method<Parameter>()
        => Debug.WriteLine(nameof(Parameter));
}
