namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1844(Stream stream) : Stream
{
    private readonly Stream _stream = stream;

    public override bool CanRead => _stream.CanRead;

    public override bool CanSeek => _stream.CanSeek;

    public override bool CanWrite => _stream.CanWrite;

    public override long Length => _stream.Length;

    public override long Position { get => _stream.Position; set => _stream.Position = value; }

    public override void Flush() => _stream.Flush();

    public override int Read(byte[] buffer, int offset, int count) => _stream.Read(buffer, offset, count);

    public override long Seek(long offset, SeekOrigin origin) => _stream.Seek(offset, origin);

    public override void SetLength(long value) => _stream.SetLength(value);

    public override void Write(byte[] buffer, int offset, int count) => _stream.Write(buffer, offset, count);

    public override async Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
        => await _stream.ReadAsync(buffer.AsMemory(offset, count), cancellationToken)
        .ConfigureAwait(false);

    public override async Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
        => await _stream.WriteAsync(buffer.AsMemory(offset, count), cancellationToken)
        .ConfigureAwait(false);

    protected override void Dispose(bool disposing)
    {
        if (disposing)
        {
            _stream?.Dispose();
        }

        base.Dispose(disposing);
    }
}
