using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1857
{
    /// <summary>
    /// An interface.
    /// </summary>
    /// <typeparam name="T">The type.</typeparam>
    public interface IInterface<T>
    {
        /// <summary>
        /// Produces value.
        /// </summary>
        /// <param name="operand">First operand.</param>
        /// <param name="operand2">Second operand.</param>
        /// <returns>The produced value.</returns>
        T M1(T operand, [ConstantExpected] T operand2);
    }

    public static void M1(int i)
        => M2(i);

    public static int M2([ConstantExpected] int i)
        => i;

    public static void M3()
        => M4((string)(object)20);

    public static string M4([ConstantExpected] string text)
        => text;

    public static void M5()
        => M6(5);

    public static int M6([ConstantExpected(Min = 3, Max = 4)] int i)
        => i;

    public sealed class C1 : IInterface<int>
    {
        public int M1(int operand, int operand2)
            => operand + operand2;
    }
}
