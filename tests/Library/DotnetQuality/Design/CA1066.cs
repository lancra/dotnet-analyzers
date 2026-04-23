using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

internal struct CA1066
{
    public override readonly bool Equals([NotNullWhen(true)] object? obj) => base.Equals(obj);

    public override readonly int GetHashCode() => base.GetHashCode();
}
