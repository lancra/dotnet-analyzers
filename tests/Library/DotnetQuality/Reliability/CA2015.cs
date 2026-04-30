using System.Buffers;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal sealed class CA2015(MemoryManager<int> memoryManager) : MemoryManager<int>
{
    private readonly MemoryManager<int> _memoryManager = memoryManager;

    ~CA2015()
        => Dispose(false);

    public override Span<int> GetSpan() => _memoryManager.GetSpan();

    public override MemoryHandle Pin(int elementIndex = 0) => _memoryManager.Pin(elementIndex);

    public override void Unpin() => _memoryManager.Unpin();

    protected override void Dispose(bool disposing) => (_memoryManager as CA2015)?.Dispose(disposing);
}
