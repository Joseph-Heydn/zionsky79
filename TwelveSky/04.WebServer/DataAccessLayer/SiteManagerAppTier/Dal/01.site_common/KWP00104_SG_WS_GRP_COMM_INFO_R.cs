using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00104_SG_WS_GRP_COMM_INFO_R {
		public int pCommGroup;
		public string oCommName;
		public string oNoteText;
		public bool oIsUsed;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00104_SG_WS_GRP_COMM_INFO_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pCommGroup"	, SqlDbType.Int).Value = pCommGroup;
				vCmd.Parameters.Add("@oCommName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNoteText"	, SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsUsed"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oCommName	= ParameterConvert.ToString(vCmd.Parameters["@oCommName"].Value);
				oNoteText	= ParameterConvert.ToString(vCmd.Parameters["@oNoteText"].Value);
				oIsUsed		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsUsed"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
