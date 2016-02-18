using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00104_SG_WS_ADMIN_INFO_R {
		public int pAdminNo;
		public string oAdminName;
		public string oAdminId;
		public int oDeptNo;
		public bool oIsUsed;
		public string oNoteText;
		public int oAuthGroup;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00104_SG_WS_ADMIN_INFO_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@oAdminName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAdminId"		, SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oDeptNo"		, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsUsed"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNoteText"	, SqlDbType.NVarChar, 100).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAuthGroup"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oAdminName	= ParameterConvert.ToString(vCmd.Parameters["@oAdminName"].Value);
				oAdminId	= ParameterConvert.ToString(vCmd.Parameters["@oAdminId"].Value);
				oDeptNo		= ParameterConvert.ToInt(vCmd.Parameters["@oDeptNo"].Value);
				oIsUsed		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsUsed"].Value);
				oNoteText	= ParameterConvert.ToString(vCmd.Parameters["@oNoteText"].Value);
				oAuthGroup	= ParameterConvert.ToInt(vCmd.Parameters["@oAuthGroup"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
