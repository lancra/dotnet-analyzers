using System.Buffers;
using System.Collections.Concurrent;
using System.Collections.Immutable;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Diagnostics.Tracing;
using System.Formats.Asn1;
using System.Globalization;
using System.IO.Compression;
using System.Net;
using System.Net.Sockets;
using System.Numerics;
using System.Reflection.Emit;
using System.Reflection.Metadata;
using System.Reflection.PortableExecutable;
using System.Runtime.InteropServices;
using System.Runtime.Loader;
using System.Runtime.Serialization;
using System.Runtime.Versioning;
using System.Security.AccessControl;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Security.Principal;
using System.Text;
using System.Text.Json;
using System.Threading.Channels;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1506
{
    [SupportedOSPlatform("windows")]
    public static void TriggerExcessiveCoupling()
    {
        var list = new List<string>();
        var dict = new Dictionary<int, string>();
        var sb = new StringBuilder();
        using var client = new HttpClient();
        var fileInfo = new FileInfo("test.txt");
        var process = Process.GetCurrentProcess();
        var culture = CultureInfo.InvariantCulture;
        var asm = System.Reflection.Assembly.GetExecutingAssembly();
        using var sha = SHA256.Create();
        var xmlDoc = new XmlDocument();
        var xElem = new XElement("root");
        using var dataTable = new DataTable();
        var dbCmd = DbProviderFactories.GetFactory("System.Data.SqlClient")?.CreateCommand();
        using var socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        var ip = IPAddress.Loopback;
        var handle = GCHandle.Alloc(new object());
        var bag = new ConcurrentBag<int>();
        var immutableList = ImmutableList.Create(1, 2, 3);
        var arrayPool = ArrayPool<byte>.Shared;
        var descriptor = TypeDescriptor.GetConverter(typeof(string));
        var vector = new Vector2(1, 2);
        var serializer = new DataContractSerializer(typeof(string));
        var claim = new Claim("type", "value");
        var identity = new GenericIdentity("user");
        using var timer = new System.Timers.Timer(1000);
        using var zip = new ZipArchive(new MemoryStream(), ZipArchiveMode.Create);
        var ctx = AssemblyLoadContext.Default;
        using var eventSource = new EventSource("demo");
        Contract.Ensures(true);
        var dirSec = new DirectorySecurity();
        var policy = new Evidence();
        var jsonDoc = JsonDocument.Parse("{}");
        var jsonOpts = new JsonSerializerOptions();
        var schema = new XmlSchema();
        var xmlSerializer = new XmlSerializer(typeof(string));
        var channel = Channel.CreateUnbounded<int>();
        var asnWriter = new AsnWriter(AsnEncodingRules.DER);
        var dynMethod = new DynamicMethod("M", null, null);
        var metadataReader = MetadataReaderProvider.FromMetadataStream(new MemoryStream()).GetMetadataReader();
        using var peReader = new PEReader(new MemoryStream());

        Console.WriteLine($"{list.Count}, {dict.Count}, {sb.Length}, {client.Timeout}, {ip}, {vector}");
    }
}
