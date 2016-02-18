using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00205_SG_WS_RECOVERY_LOG_C {
		public int pServerNo;
		public long pPlayerNo;
		public short pPublisher;
		public string pNickName;
		public long pAction;
		public long pCreateNo;
		public long pDeleteNo;
		public long pObjectNo;
		public long pObjectKey;
		public string pHostIp;
		public int pAdminNo;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00205_SG_WS_RECOVERY_LOG_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pServerNo"	, SqlDbType.SmallInt).Value = pServerNo;
				vCmd.Parameters.Add("@pPlayerNo"	, SqlDbType.BigInt).Value = pPlayerNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.BigInt).Value = pPublisher;
				vCmd.Parameters.Add("@pNickName"	, SqlDbType.NVarChar, 12).Value = pNickName;
				vCmd.Parameters.Add("@pAction"		, SqlDbType.Int).Value = pAction;
				vCmd.Parameters.Add("@pCreateNo"	, SqlDbType.Int).Value = pCreateNo;
				vCmd.Parameters.Add("@pDeleteNo"	, SqlDbType.Int).Value = pDeleteNo;
				vCmd.Parameters.Add("@pObjectNo"	, SqlDbType.BigInt).Value = pObjectNo;
				vCmd.Parameters.Add("@pObjectKey"	, SqlDbType.Int).Value = pObjectKey;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@pAdminNo"		, SqlDbType.Int).Value = pAdminNo;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
