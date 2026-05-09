using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2214
{
    public class BadlyConstructedType
    {
        public BadlyConstructedType()
        {
            Debug.WriteLine("Calling base ctor.");
            DoSomething();
        }

        protected string Initialized { get; set; } = "No";

        public virtual void DoSomething()
            => Debug.WriteLine("Base DoSomething");
    }

    public sealed class DerivedType : BadlyConstructedType
    {
        public DerivedType()
        {
            Debug.WriteLine("Calling derived ctor.");
            Initialized = "Yes";
        }

        public override void DoSomething()
            => Debug.WriteLine($"Derived DoSomething is called - initialized ? {Initialized}");
    }
}
