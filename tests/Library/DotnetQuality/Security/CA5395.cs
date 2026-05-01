using Microsoft.AspNetCore.Mvc;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5395
{
    [ValidateAntiForgeryToken]
    public sealed class BlahController : Controller
    {
    }

    public sealed class ExampleController : Controller
    {
        public IActionResult ExampleAction()
            => Ok();
    }
}
