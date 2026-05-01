using System.IO.Compression;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5389
{
    public static void Method(ZipArchiveEntry entry)
    {
        entry.ExtractToFile(entry.FullName);
        using var readFile = File.Open(entry.FullName, FileMode.Open);
        using var writeFile = File.OpenWrite(entry.FullName);
        using var createFile = File.Create(entry.FullName);
        using var stream = new FileStream(entry.FullName, FileMode.Open);
        var file = new FileInfo(entry.FullName);
    }
}
