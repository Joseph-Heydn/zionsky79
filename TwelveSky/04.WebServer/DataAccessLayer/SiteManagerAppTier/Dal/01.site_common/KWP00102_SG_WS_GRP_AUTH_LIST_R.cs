using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00102_SG_WS_GRP_AUTH_LIST_R {
		public short pSiteGroup;
		public int pCommGroup;
		public int oReturnNo;

		public DataSet fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pSiteGroup"	, SqlDbType.SmallInt).Value = pSiteGroup;
				vCmd.Parameters.Add("@pCommGroup"	, SqlDbType.Int).Value = pCommGroup;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(dsResult);
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return dsResult;
		}
	}
}
