namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public class CA1065
{
    static CA1065()
        => throw new InvalidOperationException("Invalid operation.");

    public override bool Equals(object? obj)
        => throw new InvalidOperationException("Invalid operation.");

    public override int GetHashCode()
        => throw new InvalidOperationException("Invalid operation.");

    public override string ToString()
        => throw new InvalidOperationException("Invalid operation.");
}
