using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_MENU_INFO_C {
		public string pMenuName;
		public string pExecUrl;
		public int pMenuGroup;
		public bool pIsUsed;
		public bool pIsView;
		public string pNoteText;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_MENU_INFO_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuName"	, SqlDbType.NVarChar, 20).Value = pMenuName;
				vCmd.Parameters.Add("@pExecUrl"		, SqlDbType.VarChar, 120).Value = pExecUrl;
				vCmd.Parameters.Add("@pMenuGroup"	, SqlDbType.Int).Value = pMenuGroup;
				vCmd.Parameters.Add("@pIsUsed"		, SqlDbType.Bit).Value = pIsUsed;
				vCmd.Parameters.Add("@pIsView"		, SqlDbType.Bit).Value = pIsView;
				vCmd.Parameters.Add("@pNoteText"	, SqlDbType.NVarChar, 50).Value = pNoteText;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
