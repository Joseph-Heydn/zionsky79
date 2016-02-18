using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_ADMIN_LOG_C {
		public int pGameNo;
		public long pAdminNo;
		public int pMenuNo;
		public string pHttpGet;
		public string pHttpPost;
		public string pReferer;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_ADMIN_LOG_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pGameNo"	, SqlDbType.Int).Value = pGameNo;
				vCmd.Parameters.Add("@pAdminNo"	, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@pMenuNo"	, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pHttpGet"	, SqlDbType.VarChar, -1).Value = pHttpGet;
				vCmd.Parameters.Add("@pHttpPost", SqlDbType.VarChar, -1).Value = pHttpPost;
				vCmd.Parameters.Add("@pReferer"	, SqlDbType.VarChar, -1).Value = string.IsNullOrEmpty(pReferer) ? (object) DBNull.Value : pReferer;
				vCmd.Parameters.Add("@pHostIp"	, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@oReturnNo", SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
