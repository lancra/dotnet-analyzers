using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2024
{
    public static async Task MethodAsync(StreamReader streamReader)
    {
        while (!streamReader.EndOfStream)
        {
            var line = await streamReader.ReadLineAsync()
                .ConfigureAwait(false);
            Debug.WriteLine(line);
        }
    }
}
