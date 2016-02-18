using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00205_SG_WS_GOODS_LOG_C {
		public int pServerNo;
		public long pPlayerNo;
		public long pPublisher;
		public long pMailNo;
		public string pNickName;
		public string pAction;
		public string pValueOld;
		public string pValueNew;
		public string pHostIp;
		public int pAdminNo;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00205_SG_WS_GOODS_LOG_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pServerNo"	, SqlDbType.SmallInt).Value = pServerNo;
				vCmd.Parameters.Add("@pPlayerNo"	, SqlDbType.BigInt).Value = pPlayerNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pMailNo"		, SqlDbType.BigInt).Value = pMailNo;
				vCmd.Parameters.Add("@pNickName"	, SqlDbType.NVarChar, 16).Value = pNickName;
				vCmd.Parameters.Add("@pAction"		, SqlDbType.VarChar, 99).Value = pAction;
				vCmd.Parameters.Add("@pValueOld"	, SqlDbType.VarChar, 99).Value = pValueOld;
				vCmd.Parameters.Add("@pValueNew"	, SqlDbType.VarChar, 99).Value = pValueNew;
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
