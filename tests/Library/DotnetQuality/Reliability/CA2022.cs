namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2022
{
    public static void Method(Stream stream, byte[] buffer)
        => stream.Read(buffer, 0, buffer.Length);
}
