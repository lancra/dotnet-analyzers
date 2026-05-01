using System.Runtime.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5360
{
    [Serializable]
    public sealed class ExampleClass : IDeserializationCallback
    {
        public void OnDeserialization(object? sender)
        {
            Directory.Delete("path");
            new DirectoryInfo("path").Delete();
            File.AppendAllLines("path", []);
            File.AppendAllText("path", "contents");
            using var stream = File.AppendText("path");
            File.Copy("source", "destination");
            File.Delete("path");
            File.WriteAllBytes("path", []);
            File.WriteAllLines("path", []);
            File.WriteAllText("path", "contents");
            new FileInfo("path").Delete();

            var assembly = System.Reflection.Assembly.GetExecutingAssembly();
            assembly.GetLoadedModules();
            System.Reflection.Assembly.Load([]);
            System.Reflection.Assembly.LoadFrom("path");
            System.Reflection.Assembly.LoadFile("path");
            assembly.LoadModule("module", []);
            System.Reflection.Assembly.UnsafeLoadFrom("path");
        }
    }
}
