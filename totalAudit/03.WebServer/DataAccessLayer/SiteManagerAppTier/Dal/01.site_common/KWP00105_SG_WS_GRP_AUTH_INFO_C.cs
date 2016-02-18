using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_GRP_AUTH_INFO_C {
		public int pSiteGroup;
		public string pCommName;
		public string pNoteText;
		public string pHostIp;
		public bool pIsUsed;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pSiteGroup"	, SqlDbType.SmallInt).Value = pSiteGroup;
				vCmd.Parameters.Add("@pCommName"	, SqlDbType.NVarChar, 20).Value = pCommName;
				vCmd.Parameters.Add("@pNoteText"	, SqlDbType.NVarChar, 50).Value = pNoteText;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
				vCmd.Parameters.Add("@pIsUsed"		, SqlDbType.Bit).Value = pIsUsed;
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
