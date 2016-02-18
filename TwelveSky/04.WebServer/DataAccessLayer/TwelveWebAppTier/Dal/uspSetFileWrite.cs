using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspSetFileWrite {
		public int pMenuNo;
		public long pWriteNo;
		public string pFileName;
		public string pSaveName;
		public string pFileExts;
		public string pFileSize;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetFileWrite", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pWriteNo"		, SqlDbType.BigInt).Value = pWriteNo;
				vCmd.Parameters.Add("@pFileName"	, SqlDbType.NVarChar, 1000).Value = pFileName;
				vCmd.Parameters.Add("@pSaveName"	, SqlDbType.VarChar, 1000).Value = pSaveName;
				vCmd.Parameters.Add("@pFileExts"	, SqlDbType.VarChar, 500).Value = pFileExts;
				vCmd.Parameters.Add("@pFileSize"	, SqlDbType.VarChar, 1000).Value = pFileSize;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
