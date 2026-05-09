using System.Diagnostics;
using System.Resources;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal sealed class CA2213(Stream stream, TextReader textReader, TextWriter textWriter, IResourceReader resourceReader) : IDisposable
{
    private readonly DisposableType _disposableField = new();
    private readonly Stream _stream = stream;
    private readonly TextReader _textReader = textReader;
    private readonly TextWriter _textWriter = textWriter;
    private readonly IResourceReader _resourceReader = resourceReader;

    public void Method()
    {
        Debug.WriteLine(_disposableField.ToString());
        Debug.WriteLine(_stream.ToString());
        Debug.WriteLine(_textReader.ToString());
        Debug.WriteLine(_textWriter.ToString());
        Debug.WriteLine(_resourceReader.ToString());
    }

    public void Dispose()
    {
        Dispose(disposing: true);
        GC.SuppressFinalize(this);
    }

    private static void Dispose(bool disposing)
    {
        if (disposing)
        {
            Debug.WriteLine("disposing");
        }
    }

    private sealed class DisposableType : IDisposable
    {
        public void Dispose()
        {
            Dispose(disposing: true);
            GC.SuppressFinalize(this);
        }

        private static void Dispose(bool disposing)
        {
            if (disposing)
            {
                Debug.WriteLine("disposing");
            }
        }
    }
}
