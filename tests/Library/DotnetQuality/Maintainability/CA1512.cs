namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1512
{
    public static void Method(int arg)
    {
        if (arg is 0)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg <= 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg < 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg > 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg >= 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg == 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }

        if (arg != 42)
        {
            throw new ArgumentOutOfRangeException(nameof(arg));
        }
    }
}
