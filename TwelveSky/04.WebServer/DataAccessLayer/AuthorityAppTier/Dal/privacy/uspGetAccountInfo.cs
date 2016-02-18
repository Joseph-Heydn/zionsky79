using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspGetAccountInfo {
		public long pAccountNo;
		public string oNickName;
		public string oExts;
		public DateTime oBirthDay = Convert.ToDateTime("1900-01-01");
		public bool oIsEmail;
		public bool oIsPhoto;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetAccountInfo", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@oNickName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oExts"		, SqlDbType.Char, 3).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oBirthDay"	, SqlDbType.SmallDateTime).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsEmail"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsPhoto"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oNickName	= ParameterConvert.ToString(vCmd.Parameters["@oNickName"].Value);
				oExts		= ParameterConvert.ToString(vCmd.Parameters["@oExts"].Value);
				oBirthDay	= ParameterConvert.ToDateTime(vCmd.Parameters["@oBirthDay"].Value);
				oIsEmail	= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsEmail"].Value);
				oIsPhoto	= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsPhoto"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
