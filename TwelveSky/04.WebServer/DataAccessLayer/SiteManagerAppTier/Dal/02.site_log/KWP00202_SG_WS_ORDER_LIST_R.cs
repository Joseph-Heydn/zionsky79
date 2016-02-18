using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00202_SG_WS_ORDER_LIST_R {
		public string pOrderNo;
		public int pStartDate;
		public int pFinishDate;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00202_SG_WS_ORDER_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pOrderNo"		, SqlDbType.VarChar, -1).Value = pOrderNo;
				vCmd.Parameters.Add("@pStartDate"	, SqlDbType.Int).Value = pStartDate;
				vCmd.Parameters.Add("@pFinishDate"	, SqlDbType.Int).Value = pFinishDate;
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
