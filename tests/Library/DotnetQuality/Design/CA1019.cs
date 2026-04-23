namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

[AttributeUsage(AttributeTargets.Class)]
internal sealed class CA1019(string someStringData) : Attribute
{
    public string Data { get; } = someStringData;
}
