using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspSetArticleWrite {
		public int pGameNo;
		public int pMenuNo;
		public byte pPublisher;
		public byte pLanguage;
		public byte pCate1 = 0;
		public byte pCate2 = 0;
		public string pSubject;
		public string pSummary;
		public long pAccountNo;
		public string pAccountId;
		public string pWriter;
		public string pEmail;
		public bool pAgree;
		public long pMainImage;
		public string pFileExt;
		public string pExtLink;
		public string pHostIp;
		public string pContents;
		public long oWriteNo;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspSetArticleWrite", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pGameNo"		, SqlDbType.Int).Value = pGameNo;
				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pLanguage"	, SqlDbType.TinyInt).Value = pLanguage;
				vCmd.Parameters.Add("@pCate1"		, SqlDbType.TinyInt).Value = pCate1;
				vCmd.Parameters.Add("@pCate2"		, SqlDbType.TinyInt).Value = pCate2;
				vCmd.Parameters.Add("@pAccountNo"	, SqlDbType.Int).Value = pAccountNo;
				vCmd.Parameters.Add("@pAccountId"	, SqlDbType.VarChar, 30).Value = pAccountId;
				vCmd.Parameters.Add("@pWriter"		, SqlDbType.NVarChar, 20).Value = pWriter;
				vCmd.Parameters.Add("@pEmail"		, SqlDbType.VarChar, 50).Value = pEmail;
				vCmd.Parameters.Add("@pAgree"		, SqlDbType.Bit).Value = pAgree;
				vCmd.Parameters.Add("@pMainImage"	, SqlDbType.BigInt).Value = pMainImage;
				vCmd.Parameters.Add("@pFileExt"		, SqlDbType.Char, 3).Value = pFileExt;
				vCmd.Parameters.Add("@pExtLink"		, SqlDbType.VarChar, 100).Value = pExtLink;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@pSubject"		, SqlDbType.NVarChar, 100).Value = pSubject;
				vCmd.Parameters.Add("@pSummary"		, SqlDbType.NVarChar, 300).Value = pSummary;
				vCmd.Parameters.Add("@pContents"	, SqlDbType.NVarChar, -1).Value = pContents;
				vCmd.Parameters.Add("@oWriteNo"		, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oWriteNo	= ParameterConvert.ToInt64(vCmd.Parameters["@oWriteNo"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
