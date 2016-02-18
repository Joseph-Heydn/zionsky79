using System.Data;
using System.Web.Services;
using System.Web.Script.Services;

namespace _12sky2.webservice {
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
	[ScriptService]
	public class services : WebService {
		private readonly T_MBER T_MBER = new T_MBER();

		/*********************************************************************************************************************/
		/* 사용자 아이디 체크
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
		public string getUserIdCheck(string UserID) {
			if ( !SYS.is_null(Session["USER_ID"]) ) {
				return "E1";
			}
			if ( SYS.is_null(UserID) ) {
				return "E2";
			}
			if ( !SYS.is_mail(UserID) ) {
				return "E5";
			}

			return T_MBER.getUserCheck(UserID, null) > 0 ? "E4" : "OK";
		}

		/*********************************************************************************************************************/
		/* 사용자 닉네임 체크
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
		public string getUserNicknameCheck(string Nickname) {
			if ( !SYS.is_null(Session["USER_ID"]) ) {
				return "E1";
			}
			if ( SYS.is_null(Nickname) ) {
				return "E2";
			}
			if ( Nickname.Length < 6 || Nickname.Length > 16 ) {
				return "E5";
			}

			return T_MBER.getUserCheck(null, Nickname) > 0 ? "E4" : "OK";
		}

		/*********************************************************************************************************************/
		/* 사용자 정보 조회 cookie
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
		public string getUserInfoCookie(string tmpUSER) {
			string USER_ID = SYS.Base64Decode(tmpUSER);
			DataTable result = T_MBER.getUserInfo(USER_ID);

			if ( result.Rows.Count != 0 ) {
				return Jquery.listData(result);
			}


			DataRow row = result.NewRow();
			row["Result"] = "0";
			result.Rows.Add(row);

			return Jquery.listData(result);
		}

		/*********************************************************************************************************************/
		/* 사용자 정보 조회 userid
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
		public string getUserInfo(string UserId) {
			DataTable result = T_MBER.getUserInfo(UserId);

			if ( result.Rows.Count != 0 ) {
				return Jquery.listData(result);
			}


			DataRow row = result.NewRow();
			row["Result"] = "0";
			result.Rows.Add(row);

			return Jquery.listData(result);
		}
	}
}
