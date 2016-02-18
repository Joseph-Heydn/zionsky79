using System;
using System.Data;
using System.Data.Common;
using System.Configuration;

public class connect {
	private static ConnectionStringSettings Settings(string pDataBase) {
		ConnectionStringSettings oSettings = ConfigurationManager.ConnectionStrings[pDataBase];

		if ( oSettings == null ) {
			throw new ConfigurationErrorsException($"[ERROR] {pDataBase} DB 가 존재하지 않습니다!");
		}

		return oSettings;
	}

	public static DbProviderFactory Factory(string pDataBase) {
		return DbProviderFactories.GetFactory(Settings(pDataBase).ProviderName);
	}

	public static DbConnection CreateConnection(string pDataBase) {
		try {
			DbConnection oConn = Factory(pDataBase).CreateConnection();

			if ( oConn != null ) {
				oConn.ConnectionString = Settings(pDataBase).ConnectionString;
				oConn.Open();

				return oConn;
			}
		} catch ( Exception ex ) {
			throw new DataException($"Unable to connect to {Settings(pDataBase).Name} database.", ex);
		}

		return null;
	}

	public static void CreateParameter(DbCommand pCmd, string pParam, object pValue) {
		DbParameter vParam = pCmd.CreateParameter();
		vParam.ParameterName = pParam;

		if ( pValue is string ) {
			pValue = string.IsNullOrEmpty((string) pValue) ? DBNull.Value : pValue;
		}
		vParam.Value = pValue;
		pCmd.Parameters.Add(vParam);
	}
}
