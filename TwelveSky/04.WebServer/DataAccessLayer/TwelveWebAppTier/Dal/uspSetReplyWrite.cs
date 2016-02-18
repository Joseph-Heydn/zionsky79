using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspSetReplyWrite {
		public int pMenuNo;
		public long pWriteNo;
		public byte pPublisher;
		public long pAccountNo;
		public string pAccountId;
		public string pWriter;
		public string pHostIp;
		public string pContents;
		public int oReplyCnt;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetReplyWrite", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pWriteNo"		, SqlDbType.BigInt).Value = pWriteNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@pAccountId"	, SqlDbType.VarChar, 20).Value = pAccountId;
				vCmd.Parameters.Add("@pWriter"		, SqlDbType.NVarChar, 20).Value = pWriter;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@pContents"	, SqlDbType.NVarChar, 2000).Value = pContents;
				vCmd.Parameters.Add("@oReplyCnt"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReplyCnt = ParameterConvert.ToInt(vCmd.Parameters["@oReplyCnt"].Value);
				oReturnNo = ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
