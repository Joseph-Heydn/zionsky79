using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspGetArticleList {
		public int pMenuNo;
		public byte pPublisher;
		public byte pPageSize;
		public int pJumpSize;
		public int pCheckNext;
		public long pLastWriteNo;
		public byte pFilterKey;
		public string pFilterTxt;
		public int oBlockCnt;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet oResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetArticleList", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pPageSize"	, SqlDbType.TinyInt).Value = pPageSize;
				vCmd.Parameters.Add("@pJumpSize"	, SqlDbType.Int).Value = pJumpSize;
				vCmd.Parameters.Add("@pCheckNext"	, SqlDbType.Int).Value = pCheckNext;
				vCmd.Parameters.Add("@pLastWriteNo"	, SqlDbType.BigInt).Value = pLastWriteNo;
				vCmd.Parameters.Add("@pFilterKey"	, SqlDbType.TinyInt).Value = pFilterKey;
				vCmd.Parameters.Add("@pFilterTxt"	, SqlDbType.NVarChar, 30).Value = pFilterTxt;
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
