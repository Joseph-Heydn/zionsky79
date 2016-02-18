using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspSetReplyDelete {
		public int pMenuNo;
		public long pWriteNo;
		public byte pPublisher;
		public long pCommtNo;
		public long pAccountNo;
		public short oReplyCnt;
		public int oReturnNo;

		public int fnSetDeleteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetReplyDelete", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pWriteNo"		, SqlDbType.BigInt).Value = pWriteNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pCommtNo"		, SqlDbType.BigInt).Value = pCommtNo;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@oReplyCnt"	, SqlDbType.SmallInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReplyCnt = ParameterConvert.ToInt16(vCmd.Parameters["@oReplyCnt"].Value);
				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
