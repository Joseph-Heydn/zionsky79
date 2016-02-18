using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspGetNewFileNo {
		public byte pFileCnt;
		public string oFileNo;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetNewFileNo", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pFileCnt"	, SqlDbType.TinyInt).Value = pFileCnt;
				vCmd.Parameters.Add("@oFileNo"	, SqlDbType.VarChar, 350).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo", SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oFileNo		= ParameterConvert.ToString(vCmd.Parameters["@oFileNo"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
