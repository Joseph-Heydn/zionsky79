using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspGetFieldMenuList {
		public int pGameNo;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet oResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetFieldMenuList", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pGameNo"		, SqlDbType.Int).Value = pGameNo;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(oResult);
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oResult.Tables[0];
		}
	}
}
