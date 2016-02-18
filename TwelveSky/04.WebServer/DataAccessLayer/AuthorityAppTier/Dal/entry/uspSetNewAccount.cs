using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspSetNewAccount {
		public string pAccountId;
		public string pPassword;
		public string pNickName;
		public string pEmail;
		public string pHostIp;
		public bool pEmailAgree = false;
		public long oAccountNo;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetNewAccount", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountId"	, SqlDbType.VarChar, 50).Value = pAccountId;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 32).Value = pPassword;
				vCmd.Parameters.Add("@pNickName"	, SqlDbType.NVarChar, 20).Value = pNickName;
				vCmd.Parameters.Add("@pEmail"		, SqlDbType.VarChar, 50).Value = pEmail;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@pEmailAgree"	, SqlDbType.Bit).Value = pEmailAgree;
				vCmd.Parameters.Add("@oAccountNo"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oAccountNo	= ParameterConvert.ToLong(vCmd.Parameters["@oAccountNo"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
