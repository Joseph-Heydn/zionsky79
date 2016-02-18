using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00103_SG_WS_ADMIN_LOGIN_R {
		public string pAdminId;
		public string pPassword;
		public int oAdminNo;
		public int oAuthGroup;
		public int oDeptNo;
		public int oReturnNo;
		public string oAdminName;
		public DateTime oConnTime;

		public int fnGetResultInfo(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00103_SG_WS_ADMIN_LOGIN_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAdminId"		, SqlDbType.VarChar, 20).Value		= pAdminId;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 64).Value			= pPassword;
				vCmd.Parameters.Add("@oAdminNo"		, SqlDbType.Int).Direction			= ParameterDirection.Output;
				vCmd.Parameters.Add("@oAdminName"	, SqlDbType.NVarChar, 20).Direction	= ParameterDirection.Output;
				vCmd.Parameters.Add("@oAuthGroup"	, SqlDbType.Int).Direction			= ParameterDirection.Output;
				vCmd.Parameters.Add("@oDeptNo"		, SqlDbType.Int).Direction			= ParameterDirection.Output;
				vCmd.Parameters.Add("@oConnTime"	, SqlDbType.DateTime).Direction		= ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction			= ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(dsResult);
				vConn.Close();

				oAdminNo	= ParameterConvert.ToInt(vCmd.Parameters["@oAdminNo"].Value);
				oAdminName	= ParameterConvert.ToString(vCmd.Parameters["@oAdminName"].Value);
				oAuthGroup	= ParameterConvert.ToInt(vCmd.Parameters["@oAuthGroup"].Value);
				oDeptNo		= ParameterConvert.ToInt(vCmd.Parameters["@oDeptNo"].Value);
				oConnTime	= ParameterConvert.ToDateTime(vCmd.Parameters["@oConnTime"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
