namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal enum CA1069
{
    None = 0,
    Field1 = 1,
    AnotherField1 = Field1,
    Field2 = 2,
    Field3 = 2,
}
