namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Globalization;

internal static class CA1303
{
    public static void TimeMethod(int hour, int minute)
    {
        if (hour is < 0 or > 23)
        {
            Console.WriteLine("The valid range in 0 - 23.");
        }

        if (minute is < 0 or > 59)
        {
            Console.WriteLine("The valid range is 0 - 59.");
        }
    }
}
