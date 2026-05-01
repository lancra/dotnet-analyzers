namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1034:Nested types should not be visible",
    Justification = "Multiple public types are required to surface this rule.")]
public static class CA2119
{
    /// <summary>
    /// An interface.
    /// </summary>
    internal interface IInterface
    {
        /// <summary>
        /// A method.
        /// </summary>
        /// <returns><c>true</c> if true; otherwise, <c>false</c></returns>
        bool Check();
    }

    public class Class : IInterface
    {
        public virtual bool Check()
            => true;
    }

    private sealed class OtherClass : Class
    {
    }
}
