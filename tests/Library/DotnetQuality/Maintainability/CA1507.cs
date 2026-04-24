using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal sealed class CA1507
{
    private readonly string _text;

    public CA1507(string text)
    {
        ArgumentException.ThrowIfNullOrEmpty(text);
        _text = text ?? throw new ArgumentNullException("text", "Text is required.");
    }

    public void Write()
        => Debug.WriteLine(_text);
}
