using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00104_SG_WS_GRP_SITE_INFO_R {
		public short pSiteGroup;
		public string oGroupName;
		public string oNoteText;
		public bool oIsUsed;
		public int oGroupCnt;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00104_SG_WS_GRP_SITE_INFO_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pSiteGroup"	, SqlDbType.SmallInt).Value = pSiteGroup;
				vCmd.Parameters.Add("@oGroupName"	, SqlDbType.NVarChar, 20).Value = oGroupName;
				vCmd.Parameters.Add("@oNoteText"	, SqlDbType.NVarChar, 50).Value = oNoteText;
				vCmd.Parameters.Add("@oIsUsed"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oGroupCnt"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oGroupName	= ParameterConvert.ToString(vCmd.Parameters["@oGroupName"].Value);
				oNoteText	= ParameterConvert.ToString(vCmd.Parameters["@oNoteText"].Value);
				oIsUsed		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsUsed"].Value);
				oGroupCnt	= ParameterConvert.ToInt(vCmd.Parameters["@oGroupCnt"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
