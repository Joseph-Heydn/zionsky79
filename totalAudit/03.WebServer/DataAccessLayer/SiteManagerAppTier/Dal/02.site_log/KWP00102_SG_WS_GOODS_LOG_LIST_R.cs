using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00102_SG_WS_GOODS_LOG_LIST_R {
		public int pStartDate;
		public int pFinishDate;
		public long pAccountNo;
		public long pPublisher;
		public int pAdminNo;
		public byte pAction;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pStartDate"	, SqlDbType.Int).Value = pStartDate;
				vCmd.Parameters.Add("@pFinishDate"	, SqlDbType.Int).Value = pFinishDate;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@pAction"		, SqlDbType.Int).Value = pAction;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(dsResult);
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return dsResult.Tables[0];
		}
	}
}
