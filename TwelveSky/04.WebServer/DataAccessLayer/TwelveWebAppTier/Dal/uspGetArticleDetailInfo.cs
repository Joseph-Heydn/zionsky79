using System;
using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.TwelveWebAppTier.Dal {
	public class uspGetArticleDetailInfo {
		public int pMenuNo;
		public byte pPublisher;
		public byte pLanguage;
		public long pWriteNo;
		public DateTime pLimitDate = Convert.ToDateTime("2015-10-01");
		public byte pFilterKey = 0;
		public string pFilterTxt = "";
		public bool pIsQnA = false;
		public bool pIsRead = false;
		public bool pIsFile = false;
		public bool pIsAround = false;

		public long oAccountNo;
		public string oWriter;
		public string oEmail;
		public string oHostIp;
		public int oViewCnt;
		public int oRecmdCnt;
		public int oAgnstCnt;
		public byte oCate1;
		public byte oCate2;
		public byte oStatus;
		public int oFolder;
		public long oMainImage;
		public string oFileExt;
		public string oSubject;
		public string oContents;
		public string oAnswers;
		public DateTime oCreateTime;
		public long oPrevWrite;
		public long oNextWrite;
		public int oReturnNo;

		public DataTable fnGetResultSet(string pConnString) {
			DataSet oResult = new DataSet();

			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.uspGetArticleDetailInfo", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@pPublisher"	, SqlDbType.TinyInt).Value = pPublisher;
				vCmd.Parameters.Add("@pLanguage"	, SqlDbType.TinyInt).Value = pLanguage;
				vCmd.Parameters.Add("@pWriteNo"		, SqlDbType.BigInt).Value = pWriteNo;
				vCmd.Parameters.Add("@pLimitDate"	, SqlDbType.DateTime).Value = pLimitDate;
				vCmd.Parameters.Add("@pFilterKey"	, SqlDbType.TinyInt).Value = pFilterKey;
				vCmd.Parameters.Add("@pFilterTxt"	, SqlDbType.NVarChar, 30).Value = pFilterTxt;
				vCmd.Parameters.Add("@pIsQnA"		, SqlDbType.Bit).Value = pIsQnA;
				vCmd.Parameters.Add("@pIsRead"		, SqlDbType.Bit).Value = pIsRead;
				vCmd.Parameters.Add("@pIsAround"	, SqlDbType.Bit).Value = pIsAround;
				vCmd.Parameters.Add("@pIsFile"		, SqlDbType.Bit).Value = pIsFile;

				vCmd.Parameters.Add("@oAccountNo"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oWriter"		, SqlDbType.NVarChar, 16).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oEmail"		, SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oHostIp"		, SqlDbType.VarChar, 15).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oViewCnt"		, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oRecmdCnt"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAgnstCnt"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oCate1"		, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oCate2"		, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oStatus"		, SqlDbType.TinyInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oFolder"		, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oMainImage"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oFileExt"		, SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oSubject"		, SqlDbType.NVarChar, 100).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oContents"	, SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oAnswers"		, SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oCreateTime"	, SqlDbType.DateTime).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oPrevWrite"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNextWrite"	, SqlDbType.BigInt).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				SqlDataAdapter adapter = new SqlDataAdapter(vCmd);
				adapter.Fill(oResult);
				vConn.Close();

				oAccountNo	= ParameterConvert.ToInt64(vCmd.Parameters["@oAccountNo"].Value);
				oWriter		= ParameterConvert.ToString(vCmd.Parameters["@oWriter"].Value);
				oEmail		= ParameterConvert.ToString(vCmd.Parameters["@oEmail"].Value);
				oHostIp		= ParameterConvert.ToString(vCmd.Parameters["@oHostIp"].Value);
				oViewCnt	= ParameterConvert.ToInt32(vCmd.Parameters["@oViewCnt"].Value);
				oRecmdCnt	= ParameterConvert.ToInt32(vCmd.Parameters["@oRecmdCnt"].Value);
				oAgnstCnt	= ParameterConvert.ToInt32(vCmd.Parameters["@oAgnstCnt"].Value);
				oCate1		= ParameterConvert.ToByte(vCmd.Parameters["@oCate1"].Value);
				oCate2		= ParameterConvert.ToByte(vCmd.Parameters["@oCate2"].Value);
				oStatus		= ParameterConvert.ToByte(vCmd.Parameters["@oStatus"].Value);
				oFolder		= ParameterConvert.ToInt32(vCmd.Parameters["@oFolder"].Value);
				oMainImage	= ParameterConvert.ToInt64(vCmd.Parameters["@oMainImage"].Value);
				oFileExt	= ParameterConvert.ToString(vCmd.Parameters["@oFileExt"].Value);
				oSubject	= ParameterConvert.ToString(vCmd.Parameters["@oSubject"].Value);
				oContents	= ParameterConvert.ToString(vCmd.Parameters["@oContents"].Value);
				oAnswers	= ParameterConvert.ToString(vCmd.Parameters["@oAnswers"].Value);
				oCreateTime	= ParameterConvert.ToDateTime(vCmd.Parameters["@oCreateTime"].Value);
				oPrevWrite	= ParameterConvert.ToInt64(vCmd.Parameters["@oPrevWrite"].Value);
				oNextWrite	= ParameterConvert.ToInt64(vCmd.Parameters["@oNextWrite"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oResult.Tables[0];
		}
	}
}
