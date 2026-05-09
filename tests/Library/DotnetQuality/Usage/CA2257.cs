using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2257
{
    /// <summary>
    /// The example.
    /// </summary>
    [DynamicInterfaceCastableImplementation]
    private interface IExample
    {
        /// <summary>
        /// The bad method.
        /// </summary>
        void BadMethod();

        /// <summary>
        /// The good method.
        /// </summary>
        static void GoodMethod()
        {
        }
    }
}
