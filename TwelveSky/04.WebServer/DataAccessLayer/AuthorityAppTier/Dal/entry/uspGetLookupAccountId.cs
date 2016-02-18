using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspGetLookupAccountId {
		public string pNickName = "";
		public string pAccountId = "";
		public string pPassword = "";
		public byte pLookupType;
		public string oSecEmail;
		public string oAccountId;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetLookupAccountId", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pNickName"	, SqlDbType.NVarChar, 20).Value = pNickName;
				vCmd.Parameters.Add("@pAccountId"	, SqlDbType.VarChar, 50).Value = pAccountId;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 32).Value = pPassword;
				vCmd.Parameters.Add("@pLookupType"	, SqlDbType.TinyInt).Value = pLookupType;
				vCmd.Parameters.Add("@oSecEmail"	, SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAccountId"	, SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oSecEmail	= ParameterConvert.ToString(vCmd.Parameters["@oSecEmail"].Value);
				oAccountId	= ParameterConvert.ToString(vCmd.Parameters["@oAccountId"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
