using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_ACTION_LOG_C {
		public int pGameNo;
		public long pAccountNo;
		public int pMenuNo;
		public int pResult;
		public string pProcedure;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_ACTION_LOG_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pGameNo"		, SqlDbType.Int).Value = pGameNo;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.Int).Value = pAccountNo;
				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pResult"		, SqlDbType.Int).Value = pResult;
				vCmd.Parameters.Add("@pProcedure"	, SqlDbType.VarChar, 80).Value = pProcedure;
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
