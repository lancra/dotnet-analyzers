using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal static class CA1031
{
    private const string Message = "Test";

    public static void Test()
    {
        try
        {
            Debug.WriteLine(Message);
        }
        catch (Exception ex)
        {
            Log(ex);
        }
    }

    private static void Log(Exception exception)
        => Debug.WriteLine(exception.Message);
}
