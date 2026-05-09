using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2201
{
    private const string M = "Message.";

    public static void ThrowException()
        => throw new Exception(M);

    public static void ThrowApplicationException()
        => throw new ApplicationException(M);

    public static void ThrowSystemException()
        => throw new SystemException(M);

    public static void ThrowAccessViolationException()
        => throw new AccessViolationException(M);

    public static void ThrowExecutionEngineException()
#pragma warning disable CS0618 // Required to surface CA2201 across all usages.
        => throw new ExecutionEngineException(M);
#pragma warning restore CS0618 // Type or member is obsolete

    public static void ThrowIndexOutOfRangeException()
        => throw new IndexOutOfRangeException(M);

    public static void ThrowNullReferenceException()
        => throw new NullReferenceException(M);

    public static void ThrowOutOfMemoryException()
        => throw new OutOfMemoryException(M);

    public static void ThrowCOMException()
        => throw new COMException(M);

    public static void ThrowExternalException()
        => throw new ExternalException(M);

    public static void ThrowSEHException()
        => throw new SEHException(M);

    public static void ThrowStackOverflowException()
        => throw new StackOverflowException(M);
}
