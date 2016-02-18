using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00102_SG_WS_ADMIN_LIST_R {
		public int pAuthGroup;
		public int pCommGroup;
		public long pAdminNo;
		public byte pFilterNo;
		public string pFilterText;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00102_SG_WS_ADMIN_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAuthGroup"	, SqlDbType.Int).Value = pAuthGroup;
				vCmd.Parameters.Add("@pCommGroup"	, SqlDbType.Int).Value = pCommGroup;
				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@pFilterNo"	, SqlDbType.TinyInt).Value = pFilterNo;
				vCmd.Parameters.Add("@pFilterText"	, SqlDbType.VarChar, 20).Value = pFilterText;
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
