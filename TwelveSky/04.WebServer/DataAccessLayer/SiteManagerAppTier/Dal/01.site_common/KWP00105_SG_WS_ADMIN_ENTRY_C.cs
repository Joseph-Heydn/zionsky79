using System;
using System.Data;
using System.Data.SqlClient;

namespace Field.SiteManagerAppTier.Dal {
	public class KWP00105_SG_WS_ADMIN_ENTRY_C {
		public int pDeptNo;
		public string pAdminId;
		public string pPassword;
		public string pAdminName;
		public string pNoteText;
		public string pHostIp;
		public int oReturnNo;

		public int fnSetWriteInfo(string pConnString) {
			using ( SqlConnection vConn = new SqlConnection(pConnString) ) {
				SqlCommand vCmd = new SqlCommand("dbo.KWP00105_SG_WS_ADMIN_ENTRY_C", vConn)
				{	CommandType		= CommandType.StoredProcedure
				,	CommandTimeout	= DTO_ConfigValues.EnvTime.cmdTimeOutBasic
				};

				vCmd.Parameters.Add("@pAdminId"		, SqlDbType.VarChar	, 20).Value	= pAdminId;
				vCmd.Parameters.Add("@pPassword"	, SqlDbType.Char	, 32).Value	= pPassword;
				vCmd.Parameters.Add("@pAdminName"	, SqlDbType.NVarChar, 20).Value	= pAdminName;
				vCmd.Parameters.Add("@pDeptNo"		, SqlDbType.Int).Value			= pDeptNo;
				vCmd.Parameters.Add("@pNoteText"	, SqlDbType.NVarChar, 30).Value	= pNoteText;
				vCmd.Parameters.Add("@pHostIp"		, SqlDbType.VarChar	, 15).Value	= pHostIp;
				vCmd.Parameters.Add("@oReturnNo"	, SqlDbType.Int).Direction		= ParameterDirection.Output;

				vConn.Open();
				vCmd.ExecuteNonQuery();
				vConn.Close();

				oReturnNo = Convert.ToInt32(vCmd.Parameters["@oReturnNo"].Value);
			}

			return oReturnNo;
		}
	}
}
