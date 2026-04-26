namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Design",
    "CA1034:Nested types should not be visible",
    Justification = "Multiple public types are required to surface this rule across various scenarios.")]
public static class CA1725
{
    /// <summary>
    /// Service for users.
    /// </summary>
    public interface IUserService
    {
        /// <summary>
        /// Get user age.
        /// </summary>
        /// <param name="id">User ID.</param>
        /// <returns>User age in years.</returns>
        int GetAge(int id);
    }

    public class UserService : IUserService
    {
        public int GetAge(int userId) => 21;
    }
}
