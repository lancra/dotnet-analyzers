using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2256
{
    /// <summary>
    /// The parent.
    /// </summary>
    private interface IParent
    {
        /// <summary>
        /// The parent method.
        /// </summary>
        void ParentMethod();
    }

    /// <summary>
    /// The child.
    /// </summary>
    [DynamicInterfaceCastableImplementation]
    private interface IChild : IParent
    {
        /// <summary>
        /// The child method.
        /// </summary>
        static void ChildMethod()
        {
        }
    }
}
