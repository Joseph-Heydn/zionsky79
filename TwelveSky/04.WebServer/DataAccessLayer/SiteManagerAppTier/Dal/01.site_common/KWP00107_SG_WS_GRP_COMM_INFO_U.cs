using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00107_SG_WS_GRP_COMM_INFO_U {
		public int pCommGroup;
		public string pCommName;
		public string pNoteText;
		public bool pIsUsed;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00107_SG_WS_GRP_COMM_INFO_U", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pCommGroup"	, SqlDbType.Int).Value = pCommGroup;
				vCmd.Parameters.Add("@pCommName"	, SqlDbType.NVarChar, 20).Value = pCommName;
				vCmd.Parameters.Add("@pNoteText"	, SqlDbType.NVarChar, 50).Value = pNoteText;
				vCmd.Parameters.Add("@pIsUsed"		, SqlDbType.Bit).Value = pIsUsed;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar, 15).Value = pHostIp;
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
