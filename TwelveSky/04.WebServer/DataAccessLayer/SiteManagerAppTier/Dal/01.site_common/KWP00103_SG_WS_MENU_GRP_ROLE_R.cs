using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00103_SG_WS_MENU_GRP_ROLE_R {
		public int pAuthGroup;
		public int pMenuNo;
		public string oMenuName;
		public int oMenuGroup;
		public string oGroupName;
		public string oExecUrl;
		public string oNoteText;
		public bool oIsUsed;
		public bool oIsRead;
		public bool oIsWrite;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAuthGroup"	, SqlDbType.Int).Value = pAuthGroup;
				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@oMenuGroup"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oGroupName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oMenuName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oExecUrl"		, SqlDbType.VarChar, 120).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNoteText"	, SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsUsed"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsRead"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsWrite"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oMenuGroup	= ParameterConvert.ToInt(vCmd.Parameters["@oMenuGroup"].Value);
				oGroupName	= ParameterConvert.ToString(vCmd.Parameters["@oGroupName"].Value);
				oMenuName	= ParameterConvert.ToString(vCmd.Parameters["@oMenuName"].Value);
				oExecUrl	= ParameterConvert.ToString(vCmd.Parameters["@oExecUrl"].Value);
				oNoteText	= ParameterConvert.ToString(vCmd.Parameters["@oNoteText"].Value);
				oIsUsed		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsUsed"].Value);
				oIsRead		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsRead"].Value);
				oIsWrite	= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsWrite"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
