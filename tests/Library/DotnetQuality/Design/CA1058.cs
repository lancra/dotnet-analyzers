namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Naming",
    "EX023:Exception class name must end with 'Exception'",
    Justification = "Deviates from rule ID naming standard.")]
public class CA1058 : ApplicationException
{
    public CA1058(string message)
        : base(message)
    {
    }

    public CA1058(string message, Exception innerException)
        : base(message, innerException)
    {
    }
}
