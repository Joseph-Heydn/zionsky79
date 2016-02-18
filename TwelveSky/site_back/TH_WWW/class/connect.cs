using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.Common;

public class connect
{
    private static ConnectionStringSettings Settings(string DBName)
    {
        ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings[DBName];
        if (settings == null)
        {
            throw new ConfigurationErrorsException(
                "[ERROR] " + DBName + " DB 가 존재하지 않습니다!");
        }
        return settings;
    }

    public static DbProviderFactory Factory(string DBName)
    {
        return DbProviderFactories.GetFactory(Settings(DBName).ProviderName);
    }

    public static DbConnection CreateConnection(string DBName)
    {
        try
        {
            DbConnection connection = Factory(DBName).CreateConnection();
            connection.ConnectionString = Settings(DBName).ConnectionString;
            connection.Open();
            return connection;
        }
        catch (Exception ex)
        {
            throw new DataException(String.Format("Unable to connect to {0} database.", Settings(DBName).Name), ex);
        }
    }

    public static void CreateParameter(DbCommand command, string parameterName, object value)
    {
        DbParameter param = command.CreateParameter();
        param.ParameterName = parameterName;
        if (value is String)
        {
            value = String.IsNullOrEmpty(value as String) ? DBNull.Value : value;
        }
        param.Value = value;
        command.Parameters.Add(param);
    }
}
