namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5367
{
    [Serializable]
    public sealed unsafe class Test
    {
        private int* _pointer;

        public int* Point()
            => _pointer;

        public void Set(int* pointer)
            => _pointer = pointer;
    }
}
