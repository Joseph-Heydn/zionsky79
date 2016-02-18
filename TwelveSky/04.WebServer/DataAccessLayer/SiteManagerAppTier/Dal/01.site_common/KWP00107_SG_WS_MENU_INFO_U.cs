using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00107_SG_WS_MENU_INFO_U {
		public int pMenuNo;
		public string pMenuName;
		public string pExecUrl;
		public int pGroupOld;
		public int pGroupNew;
		public bool pIsUsed;
		public int pSeqNoOld;
		public int pSeqNoNew;
		public string pNoteText;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00107_SG_WS_MENU_INFO_U", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"	, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pMenuName", SqlDbType.NVarChar, 20).Value = pMenuName;
				vCmd.Parameters.Add("@pExecUrl"	, SqlDbType.VarChar, 120).Value = pExecUrl;
				vCmd.Parameters.Add("@pGroupOld", SqlDbType.Int).Value = pGroupOld;
				vCmd.Parameters.Add("@pGroupNew", SqlDbType.Int).Value = pGroupNew;
				vCmd.Parameters.Add("@pIsUsed"	, SqlDbType.Bit).Value = pIsUsed;
				vCmd.Parameters.Add("@pSeqNoOld", SqlDbType.Int).Value = pSeqNoOld;
				vCmd.Parameters.Add("@pSeqNoNew", SqlDbType.Int).Value = pSeqNoNew;
				vCmd.Parameters.Add("@pNoteText", SqlDbType.NVarChar, 50).Value = pNoteText;
				vCmd.Parameters.Add("@pHostIp"	, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@oReturnNo", SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
