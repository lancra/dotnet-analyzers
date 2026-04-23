namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Naming",
    "EX023:Exception class name must end with 'Exception'",
    Justification = "Deviates from rule ID naming standard.")]
internal sealed class CA1064 : Exception
{
    public CA1064(string message)
        : base(message)
    {
    }

    public CA1064(string message, Exception innerException)
        : base(message, innerException)
    {
    }
}
