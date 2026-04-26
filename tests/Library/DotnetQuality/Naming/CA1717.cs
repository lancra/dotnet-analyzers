// DISABLED: Adding the Text.Analyzers package breaks Microsoft.CodeAnalysis.NetAnalyzers built-in rules.
//           Adding the Microsoft.CodeAnalysis.NetAnalyzers package directly breaks CA1416 and CA1422.
//           See: https://redirect.github.com/dotnet/sdk/issues/53125
namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

public static class CA1717
{
    public enum Days
    {
        None = 0,
        Monday = 1,
        Tuesday = 2,
        Wednesday = 3,
        Thursday = 4,
        Friday = 5,
        Saturday = 6,
        Sunday = 7,
    }
}
