using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2235
{
    [Serializable]
    private sealed class InputDevices
    {
        private readonly Mouse _opticalMouse;

        public InputDevices()
            => _opticalMouse = new(5, "optical");

        public void Write()
            => Debug.WriteLine(_opticalMouse.ToString());
    }

    private sealed class Mouse(int numberOfButtons, string scanType)
    {
        public int NumberOfButtons { get; } = numberOfButtons;

        public string ScanType { get; } = scanType;
    }
}
