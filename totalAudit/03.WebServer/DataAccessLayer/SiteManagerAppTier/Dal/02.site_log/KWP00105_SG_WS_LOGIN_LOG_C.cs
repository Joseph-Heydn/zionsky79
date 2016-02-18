using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_LOGIN_LOG_C {
		public int pGameNo;
		public string pAccountId;
		public int pResult;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_LOGIN_LOG_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutDefault
				};

				vCmd.Parameters.Add("@pGameNo"		, SqlDbType.Int).Value = pGameNo;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.VarChar).Value = pAccountId;
				vCmd.Parameters.Add("@pResult"		, SqlDbType.TinyInt).Value = pResult;
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
