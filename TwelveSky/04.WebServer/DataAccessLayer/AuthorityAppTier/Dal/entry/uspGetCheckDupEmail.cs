using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspGetCheckDupEmail {
		public long pAccountNo;
		public string pEmail;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetCheckDupEmail", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@pEmail"		, SqlDbType.VarChar, 50).Value = pEmail;
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
