// DISABLED: Adding the Text.Analyzers package breaks Microsoft.CodeAnalysis.NetAnalyzers built-in rules.
//           Adding the Microsoft.CodeAnalysis.NetAnalyzers package directly breaks CA1416 and CA1422.
//           See: https://redirect.github.com/dotnet/sdk/issues/53125
namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

public static class CA1714
{
    [Flags]
    public enum Day
    {
        None = 0,
        Monday = 1,
        Tuesday = 2,
        Wednesday = 4,
        Thursday = 8,
        Friday = 16,
        Saturday = 32,
        Sunday = 64,
    }
}
