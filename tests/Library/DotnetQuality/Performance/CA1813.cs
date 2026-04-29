namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1034:Nested types should not be visible",
    Justification = "Multiple public types are required to surface this rule across various scenarios.")]
public static class CA1813
{
    [AttributeUsage(AttributeTargets.All)]
    public class TheAttribute : Attribute
    {
    }
}
