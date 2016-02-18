using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuditAppTier.Dal {
	public class uspGetDashBoard {
		public string pInstence;
		public DateTime pStartDay;
		public int oReturnNo;

		public DataSet fnGetResultSet(string pConnString) {
			DataSet dsResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetDashBoard", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pInstence", SqlDbType.NVarChar, 800).Value = pInstence;
				vCmd.Parameters.Add("@pStartDay", SqlDbType.DateTime).Value = pStartDay;
				vCmd.Parameters.Add("@oReturnNo", SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(dsResult);
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return dsResult;
		}
	}
}
