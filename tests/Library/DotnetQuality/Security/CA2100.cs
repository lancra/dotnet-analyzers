using Microsoft.Data.SqlClient;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2100
{
    public static object Method(string connection, string name, string password)
    {
        using SqlConnection sqlConnection = new(connection);
        using SqlCommand sqlCommand = new()
        {
            Connection = sqlConnection,
        };

        sqlCommand.CommandText = "SELECT AccountNumber FROM Users " +
            "WHERE Username='" + name +
            "' AND Password='" + password + "'";

        sqlConnection.Open();
        var accountNumber = sqlCommand.ExecuteScalar();
        sqlConnection.Close();
        return accountNumber;
    }
}
