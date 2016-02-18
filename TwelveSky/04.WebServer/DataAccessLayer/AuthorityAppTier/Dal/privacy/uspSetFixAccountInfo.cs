using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.AuthorityAppTier.Dal {
	public class uspSetFixAccountInfo {
		public long pAccountNo;
		public string pNickName;
		public string pExts;
		public DateTime pBirthDay = Convert.ToDateTime("1900-01-01");
		public bool pIsEmail = false;
		public bool pIsPhoto = false;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetFixAccountInfo", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.BigInt).Value = pAccountNo;
				vCmd.Parameters.Add("@pNickName"	, SqlDbType.NVarChar, 20).Value = pNickName;
				vCmd.Parameters.Add("@pExts"		, SqlDbType.Char, 3).Value = pExts;
				vCmd.Parameters.Add("@pBirthDay"	, SqlDbType.SmallDateTime).Value = pBirthDay;
				vCmd.Parameters.Add("@pIsEmail"		, SqlDbType.Bit).Value = pIsEmail;
				vCmd.Parameters.Add("@pIsPhoto"		, SqlDbType.Bit).Value = pIsPhoto;
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
