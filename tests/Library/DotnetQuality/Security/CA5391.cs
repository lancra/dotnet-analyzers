using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5391
{
    public sealed class ExampleController : Controller
    {
        [HttpDelete]
        public IActionResult ExampleAction(string actionName)
        {
            Debug.WriteLine(actionName);
            return Ok();
        }

        [HttpDelete]
        [ValidateAntiForgeryToken]
        public IActionResult AnotherAction(string actionName)
        {
            Debug.WriteLine(actionName);
            return Ok();
        }
    }
}
