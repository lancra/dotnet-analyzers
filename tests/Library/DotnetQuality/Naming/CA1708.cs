namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

public class CA1708
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "StyleCop.CSharp.MaintainabilityRules",
        "SA1401:Fields should be private",
        Justification = "The rule only triggers on visible members.")]
    protected string someName = string.Empty;

    public string SomeName => someName;
}
