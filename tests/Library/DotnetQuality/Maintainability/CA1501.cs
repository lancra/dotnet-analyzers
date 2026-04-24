namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

public static class CA1501
{
    private class BaseClass
    {
    }

    private class FirstDerivedClass : BaseClass
    {
    }

    private class SecondDerivedClass : FirstDerivedClass
    {
    }

    private class ThirdDerivedClass : SecondDerivedClass
    {
    }

    private class FourthDerivedClass : ThirdDerivedClass
    {
    }

    private class FifthDerivedClass : FourthDerivedClass
    {
    }

    private sealed class SixthDerivedClass : FifthDerivedClass
    {
    }
}
