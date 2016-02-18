using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00102_SG_WS_MENU_LIST_R {
		public short pSiteGroup;
		public int pMenuGroup;
		public byte pLangNo;
		public byte pFilterNo;
		public string pFilterText;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00102_SG_WS_MENU_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pSiteGroup"	, SqlDbType.SmallInt).Value = pSiteGroup;
				vCmd.Parameters.Add("@pMenuGroup"	, SqlDbType.Int).Value = pMenuGroup;
				vCmd.Parameters.Add("@pLangNo"		, SqlDbType.TinyInt).Value = pLangNo;
				vCmd.Parameters.Add("@pFilterNo"	, SqlDbType.TinyInt).Value = pFilterNo;
				vCmd.Parameters.Add("@pFilterText"	, SqlDbType.NVarChar, 20).Value = pFilterText;
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
