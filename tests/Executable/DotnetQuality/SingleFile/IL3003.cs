using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.SingleFile;

internal static class IL3003
{
    internal class Base
    {
        [RequiresAssemblyFiles]
        public virtual void TestMethod()
        {
        }
    }

    internal sealed class Derived : Base
    {
        public override void TestMethod()
        {
        }
    }
}
