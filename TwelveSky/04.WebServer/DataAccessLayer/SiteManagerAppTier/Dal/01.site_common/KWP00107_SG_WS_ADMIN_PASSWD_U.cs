using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00107_SG_WS_ADMIN_PASSWD_U {
		public long pAdminNo;
		public string pPasswdOld;
		public string pPasswdNew;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00107_SG_WS_ADMIN_PASSWD_U", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@pPasswordOld"	, SqlDbType.Char, 32).Value = pPasswdOld;
				vCmd.Parameters.Add("@pPasswordNew"	, SqlDbType.Char, 32).Value = pPasswdNew;
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
