using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspGetReplyList {
		public long pWriteNo;
		public byte pPageSize;
		public int pJumpSize;
		public int pCheckNext;
		public long pLastCommtNo;
		public int oBlockCnt;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet oResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetReplyList", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pWriteNo"		, SqlDbType.BigInt).Value = pWriteNo;
				vCmd.Parameters.Add("@pPageSize"	, SqlDbType.TinyInt).Value = pPageSize;
				vCmd.Parameters.Add("@pJumpSize"	, SqlDbType.Int).Value = pJumpSize;
				vCmd.Parameters.Add("@pCheckNext"	, SqlDbType.Int).Value = pCheckNext;
				vCmd.Parameters.Add("@pLastCommtNo"	, SqlDbType.BigInt).Value = pLastCommtNo;
				vCmd.Parameters.Add("@oBlockCnt"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(oResult);
				vConn.Close();

				oBlockCnt = ParameterConvert.ToInt(vCmd.Parameters["@oBlockCnt"].Value);
				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oResult.Tables[0];
		}
	}
}
