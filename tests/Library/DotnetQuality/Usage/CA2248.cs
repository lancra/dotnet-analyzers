namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2248
{
    [Flags]
    public enum MyEnum
    {
        A,
        B,
    }

    [Flags]
    public enum OtherEnum
    {
        A,
    }

    public static void Method(MyEnum m)
    {
        m.HasFlag(OtherEnum.A);
        m.HasFlag(MyEnum.A);
    }
}
