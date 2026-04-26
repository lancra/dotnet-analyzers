using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

public static class CA1707
{
    [SuppressMessage(
        "StyleCop.CSharp.NamingRules",
        "SA1310:Field names should not contain underscore",
        Justification = "The rules cover the same scenario but at different scopes.")]
    public const string TEST_CONSTANT = "foo";

    public enum User_Type
    {
        Client_User = 0,
        Manager_Admin = 1,
        Super_Admin = 2,
    }

    public static void Add_User(string userName)
        => Debug.WriteLine($"{TEST_CONSTANT}\\{userName}");

    [SuppressMessage(
        "Design",
        "CA1034:Nested types should not be visible",
        Justification = "The nested type is required to surface additional diagnostics for this rule.")]
    public struct User_Model : IEquatable<User_Model>
    {
        public string User_Name { get; set; }

        public User_Type User_Type { get; set; }

        public static bool operator ==(User_Model left, User_Model right)
            => left.Equals(right);

        public static bool operator !=(User_Model left, User_Model right)
            => !(left == right);

        public override readonly bool Equals([NotNullWhen(true)] object? obj)
            => obj is not null &&
            obj is User_Model other &&
            Equals(other);

        public readonly bool Equals(User_Model other)
            => User_Name == other.User_Name &&
            User_Type == other.User_Type;

        public override readonly int GetHashCode()
            => HashCode.Combine(User_Name, User_Type);
    }
}
