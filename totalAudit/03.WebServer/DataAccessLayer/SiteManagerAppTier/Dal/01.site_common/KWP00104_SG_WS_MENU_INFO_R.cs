using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00104_SG_WS_MENU_INFO_R {
		public int pMenuNo;
		public string oMenuName;
		public string oMenuUrl;
		public int oMenuGroup;
		public bool oIsUsed;
		public int oOrderBy;
		public string oNoteText;
		public int oReturnNo;

		public int fnGetResultInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00104_SG_WS_MENU_INFO_R", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pMenuNo"		, SqlDbType.Int).Value = pMenuNo;
				vCmd.Parameters.Add("@oMenuGroup"	, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oMenuName"	, SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oMenuUrl"		, SqlDbType.VarChar, 120).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oIsUsed"		, SqlDbType.Bit).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oOrderBy"		, SqlDbType.Int).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oNoteText"	, SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction = ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oMenuGroup	= ParameterConvert.ToInt(vCmd.Parameters["@oMenuGroup"].Value);
				oMenuName	= ParameterConvert.ToString(vCmd.Parameters["@oMenuName"].Value);
				oMenuUrl	= ParameterConvert.ToString(vCmd.Parameters["@oMenuUrl"].Value);
				oIsUsed		= ParameterConvert.ToBoolean(vCmd.Parameters["@oIsUsed"].Value);
				oOrderBy	= ParameterConvert.ToInt(vCmd.Parameters["@oOrderBy"].Value);
				oNoteText	= ParameterConvert.ToString(vCmd.Parameters["@oNoteText"].Value);
				oReturnNo	= ParameterConvert.ToInt(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
