using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00107_SG_WS_ADMIN_INFO_U {
		public int pAdminNo;
		public string pAdminName;
		public string pPassword;
		public int pAuthGroup;
		public int pDeptNo;
		public bool pIsUsed;
		public string pNoteText;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00107_SG_WS_ADMIN_INFO_U", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@pAdminName"	, SqlDbType.NVarChar, 20).Value = pAdminName;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 32).Value = pPassword;
				vCmd.Parameters.Add("@pAuthGroup"	, SqlDbType.Int).Value = pAuthGroup;
				vCmd.Parameters.Add("@pDeptNo"		, SqlDbType.Int).Value = pDeptNo;
				vCmd.Parameters.Add("@pIsUsed"		, SqlDbType.Bit).Value = pIsUsed;
				vCmd.Parameters.Add("@pNoteText"	, SqlDbType.NVarChar, 30).Value = pNoteText;
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
