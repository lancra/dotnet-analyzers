using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5362
{
    public static void Method(ExampleClass exampleClass)
    {
        while (exampleClass is not null)
        {
            Debug.WriteLine(exampleClass.ToString());
            exampleClass = exampleClass.ExampleProperty;
        }
    }

    [Serializable]
    public sealed class ExampleClass
    {
        public ExampleClass ExampleProperty { get; set; } = new();

        public int NormalProperty { get; set; }
    }
}
