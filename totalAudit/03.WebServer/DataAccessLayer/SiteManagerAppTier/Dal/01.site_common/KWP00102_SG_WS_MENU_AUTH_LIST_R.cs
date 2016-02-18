using System;
using System.Data;
using System.Data.SqlClient;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00102_SG_WS_MENU_AUTH_LIST_R {
		public byte pType;
		public short pSite;
		public byte pLangNo;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet oResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pType"	, SqlDbType.TinyInt).Value = pType;
				vCmd.Parameters.Add("@pSite"	, SqlDbType.SmallInt).Value = pSite;
				vCmd.Parameters.Add("@pLangNo"	, SqlDbType.TinyInt).Value = pLangNo;
				vCmd.Parameters.Add("@oReturnNo", SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(oResult);

				oReturnNo = Convert.ToInt32(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oResult.Tables[0];
		}
	}
}
