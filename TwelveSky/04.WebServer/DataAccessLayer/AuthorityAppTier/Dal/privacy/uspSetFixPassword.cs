using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspSetFixPassword {
		public long pAccountNo;
		public string pPassword;
		public string pNewPassword;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetFixPassword", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 32).Value = pPassword;
				vCmd.Parameters.Add("@pNewPassword"	, SqlDbType.Char, 32).Value = pNewPassword;
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
