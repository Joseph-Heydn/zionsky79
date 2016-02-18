using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspGetLoginAccountInfo {
		public string pAccountId;
		public string pPassword;
		public byte oPublisher;
		public long oAccountNo;
		public string oNickName;
		public string oEmail;
		public byte oStatus;
		public byte oBlockType;
		public bool oIsCertify;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetLoginAccountInfo", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountId"	, SqlDbType.VarChar, 50).Value = pAccountId;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char, 32).Value = pPassword;
				vCmd.Parameters.Add("@oPublisher"	, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAccountNo"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oBlockType"	, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNickName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oEmail"		, SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oStatus"		, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsCertify"	, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oPublisher	= ParameterConvert.ToByte(vCmd.Parameters["@oPublisher"].Value);
				oAccountNo	= ParameterConvert.ToLong(vCmd.Parameters["@oAccountNo"].Value);
				oBlockType	= ParameterConvert.ToByte(vCmd.Parameters["@oBlockType"].Value);
				oNickName	= ParameterConvert.ToString(vCmd.Parameters["@oNickName"].Value);
				oEmail		= ParameterConvert.ToString(vCmd.Parameters["@oEmail"].Value);
				oStatus		= ParameterConvert.ToByte(vCmd.Parameters["@oStatus"].Value);
				oIsCertify	= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsCertify"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
