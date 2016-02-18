using System.Web;

using Field.SiteManagerAppTier.Dal;

public class WebLog {
	public class WriteLog {
		private static readonly string gConnStr = ConnString.fnGetName("SiteManager");

		// 페이지 접근 내역을 기록합니다.
		public static bool fnWebLogWrite(HttpRequest pRequest, int pGameNo, long pAccountNo, int pMenuNo) {
			try {
				KWP00105_SG_WS_ADMIN_LOG_C oDTO = new KWP00105_SG_WS_ADMIN_LOG_C
				{	pGameNo		= pGameNo
				,	pAdminNo	= pAccountNo
				,	pMenuNo		= pMenuNo
				,	pHttpGet	= fnPageInfo(pRequest, 0)
				,	pHttpPost	= fnPageInfo(pRequest, 1)
				,	pReferer	= pRequest.ServerVariables["HTTP_REFERER"]
				,	pHostIp		= pRequest.ServerVariables["REMOTE_ADDR"]
				};
				int oReturnNo = oDTO.fnSetWriteInfo(gConnStr);

				return oReturnNo == 0;
			} catch {
				return false;
			}
		}

		// 프로시저 실행 로그
		public static bool fnActionLogWrite(string pHostIp, int pGameNo, long pAccountNo, int pMenuNo, int pResult, string pProcedure) {
			try {
				KWP00105_SG_WS_ACTION_LOG_C oDTO = new KWP00105_SG_WS_ACTION_LOG_C
				{	pGameNo		= pGameNo
				,	pAccountNo	= pAccountNo
				,	pMenuNo		= pMenuNo
				,	pResult		= pResult
				,	pProcedure	= pProcedure
				,	pHostIp		= pHostIp
				};
				int oReturnNo = oDTO.fnSetWriteInfo(gConnStr);

				return oReturnNo == 0;
			} catch {
				return false;
			}
		}

		// 불필요한 인자 삭제
		private static string fnPageInfo(HttpRequest pRequest, byte pType) {
			string oPageInfo = "";
			string vRequested = pType == 0 ? pRequest.QueryString.ToString() : pRequest.Form.ToString();
			string[] vParams = fnReplaceString(vRequested).Split('&');

			if ( vParams.Length <= 1 || vRequested == "" ) {
				return "";
			}


			foreach ( string vParam in vParams ) {
				string[] vTmp = vParam.Split('=');

				if ( vTmp.Length <= 1 || vParam == "" ) {
					continue;
				}
				if ( vTmp[0].StartsWith("ctl") || vTmp[0].StartsWith("__") ) {
					continue;
				}
				if ( vTmp[1] == "" ) {
					continue;
				}
				switch ( vTmp[0] ) {
					case "txtSubject":
					case "txtContents":
					case "txtComment":
						continue;
				}


				oPageInfo += $"{vParam}&";
			}

			return string.IsNullOrEmpty(oPageInfo) ? "" : oPageInfo.Substring(0, oPageInfo.Length-1);
		}

		// 로그인 기록
		public static bool fnWebLoginWrite(int pGameNo, string pAccountId, byte pAuth) {
			try {
				uspSetNewWebLogin oDTO = new uspSetNewWebLogin
				{	pGameNo		= pGameNo
				,	pAccountId	= pAccountId
				,	pAuth		= pAuth
				};
				int o_return_no = oDTO.SetWriteInfo(gConnStr);

				return o_return_no == 0;
			} catch {
				return false;
			}
		}

		// 불필요한 문자열 삭제
		private static string fnReplaceString(string pString) {
			return	pString.Replace("ctl00%24"			, "").
							Replace("uMenuTable%24"		, "").
							Replace("contents%24"		, "").
							Replace("ContentPlaceHolder", "").
							Replace("%241%24"			, "");
		}
	}
}
