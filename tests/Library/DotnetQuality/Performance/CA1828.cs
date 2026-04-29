using System.Diagnostics;
using Microsoft.EntityFrameworkCore;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1828
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Reliability",
        "CA2007:Consider calling ConfigureAwait on the awaited task",
        Justification = "Adding ConfigureAwait results in this rule not being triggered.")]
    public static async Task MethodAsync(IQueryable<string> list)
    {
        Debug.WriteLine(await list.CountAsync() != 0 ? "not empty" : "empty");
        Debug.WriteLine(await list.CountAsync() == 0 ? "empty" : "not empty");
        Debug.WriteLine(await list.CountAsync() > 0 ? "not empty" : "empty");
        Debug.WriteLine(await list.LongCountAsync() != 0 ? "not empty" : "empty");
        Debug.WriteLine(await list.LongCountAsync() == 0 ? "empty" : "not empty");
        Debug.WriteLine(await list.LongCountAsync() > 0 ? "not empty" : "empty");
    }
}
