using System.Data;
using System.Data.SqlClient;

using Field.Framework.Data;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00107_SG_WS_GRP_COMM_SEQ_U {
		public short pSiteGroup;
		public int pCommGroup;
		public int pSeqNoOld;
		public int pSeqNoNew;
		public int oReturnNo;

		public int fnSetModifyInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pSiteGroup"	, SqlDbType.SmallInt).Value = pSiteGroup;
				vCmd.Parameters.Add("@pCommGroup"	, SqlDbType.Int).Value = pCommGroup;
				vCmd.Parameters.Add("@pSeqNoOld"	, SqlDbType.SmallInt).Value = pSeqNoOld;
				vCmd.Parameters.Add("@pSeqNoNew"	, SqlDbType.SmallInt).Value = pSeqNoNew;
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
