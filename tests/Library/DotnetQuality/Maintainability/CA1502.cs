using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1502
{
    public static void Test(DayOfWeek day, bool reverse, bool capital)
    {
        if (reverse && capital)
        {
            switch (day)
            {
                case DayOfWeek.Monday:
                    Debug.WriteLine("MONDAY IS TODAY!");
                    break;
                case DayOfWeek.Tuesday:
                    Debug.WriteLine("TUESDAY IS TODAY!");
                    break;
                case DayOfWeek.Wednesday:
                    Debug.WriteLine("WEDNESDAY IS TODAY!");
                    break;
                case DayOfWeek.Thursday:
                    Debug.WriteLine("THURSDAY IS TODAY!");
                    break;
                case DayOfWeek.Friday:
                    Debug.WriteLine("FRIDAY IS TODAY!");
                    break;
                case DayOfWeek.Saturday:
                    Debug.WriteLine("SATURDAY IS TODAY!");
                    break;
                case DayOfWeek.Sunday:
                    Debug.WriteLine("SUNDAY IS TODAY!");
                    break;
                default:
                    break;
            }
        }
        else if (reverse)
        {
            switch (day)
            {
                case DayOfWeek.Monday:
                    Debug.WriteLine("Monday is Today!");
                    break;
                case DayOfWeek.Tuesday:
                    Debug.WriteLine("Tuesday is Today!");
                    break;
                case DayOfWeek.Wednesday:
                    Debug.WriteLine("Wednesday is Today!");
                    break;
                case DayOfWeek.Thursday:
                    Debug.WriteLine("Thursday is Today!");
                    break;
                case DayOfWeek.Friday:
                    Debug.WriteLine("Friday is Today!");
                    break;
                case DayOfWeek.Saturday:
                    Debug.WriteLine("Saturday is Today!");
                    break;
                case DayOfWeek.Sunday:
                    Debug.WriteLine("Sunday is Today!");
                    break;
                default:
                    break;
            }
        }
        else if (capital)
        {
            switch (day)
            {
                case DayOfWeek.Monday:
                    Debug.WriteLine("TODAY IS MONDAY!");
                    break;
                case DayOfWeek.Tuesday:
                    Debug.WriteLine("TODAY IS TUESDAY!");
                    break;
                case DayOfWeek.Wednesday:
                    Debug.WriteLine("TODAY IS WEDNESDAY!");
                    break;
                case DayOfWeek.Thursday:
                    Debug.WriteLine("TODAY IS THURSDAY!");
                    break;
                case DayOfWeek.Friday:
                    Debug.WriteLine("TODAY IS FRIDAY!");
                    break;
                case DayOfWeek.Saturday:
                    Debug.WriteLine("TODAY IS SATURDAY!");
                    break;
                case DayOfWeek.Sunday:
                    Debug.WriteLine("TODAY IS SUNDAY!");
                    break;
                default:
                    break;
            }
        }
        else
        {
            switch (day)
            {
                case DayOfWeek.Monday:
                    Debug.WriteLine("Today is Monday!");
                    break;
                case DayOfWeek.Tuesday:
                    Debug.WriteLine("Today is Tuesday!");
                    break;
                case DayOfWeek.Wednesday:
                    Debug.WriteLine("Today is Wednesday!");
                    break;
                case DayOfWeek.Thursday:
                    Debug.WriteLine("Today is Thursday!");
                    break;
                case DayOfWeek.Friday:
                    Debug.WriteLine("Today is Friday!");
                    break;
                case DayOfWeek.Saturday:
                    Debug.WriteLine("Today is Saturday!");
                    break;
                case DayOfWeek.Sunday:
                    Debug.WriteLine("Today is Sunday!");
                    break;
                default:
                    break;
            }
        }
    }
}
