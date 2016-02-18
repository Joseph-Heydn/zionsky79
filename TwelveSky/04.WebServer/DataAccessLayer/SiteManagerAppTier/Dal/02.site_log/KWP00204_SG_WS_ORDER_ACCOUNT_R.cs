using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00204_SG_WS_ORDER_ACCOUNT_R {
		public int pServerNo;
		public string pOrderNo;
		public int pStartDate;
		public int pFinishDate;
		public long oPlayerNo;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pServerNo"	, SqlDbType.Int).Value = pServerNo;
				vCmd.Parameters.Add("@pOrderNo"		, SqlDbType.VarChar, 64).Value = pOrderNo;
				vCmd.Parameters.Add("@pStartDate"	, SqlDbType.Int).Value = pStartDate;
				vCmd.Parameters.Add("@pFinishDate"	, SqlDbType.Int).Value = pFinishDate;
				vCmd.Parameters.Add("@oPlayerNo"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oPlayerNo	= ParameterConvert.ToInt64(vCmd.Parameters["@oPlayerNo"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
