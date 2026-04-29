namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1814
{
    public static readonly int[][] Jagged =
        [
            [1, 2, 3, 4],
            [5, 6, 7],
            [8],
            [9],
        ];

    public static readonly int[,] MultiDimensional =
        {
            { 1, 2, 3, 4 },
            { 5, 6, 7, 0 },
            { 8, 0, 0, 0 },
            { 9, 0, 0, 0 },
        };
}
