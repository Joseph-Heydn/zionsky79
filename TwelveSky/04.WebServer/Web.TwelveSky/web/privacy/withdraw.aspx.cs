using System;
using System.Data;
using Field.AuthorityAppTier.Dal;


namespace Web.TwelveSky.web.privacy {
	public partial class withdraw : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("Authority");
		private static string gThisPage = "withdraw.aspx?m={0}";

		public withdraw() {
			AuthoriyCheckAllow = true;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/withdraw.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// parameter 수집
		private void fnInitParameter() {
			pMenu.Value = Request.QueryString["m"];

			// 잘 못된 접근
			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}


			gThisPage = string.Format(gThisPage, pMenu.Value);
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect("/");
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			if ( vMenuInfo[0]["cType"].ToString() != "10" || !Convert.ToBoolean(vMenuInfo[0]["cIsWrite"]) ) {
				Response.Redirect("/");
				return;
			}

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region control layer
		// 로그인 확인
		private void fnCheckAccount() {
			uspGetLoginAccountInfo oDTO = new uspGetLoginAccountInfo
			{	pAccountId	= txtAccountId.Text
			,	pPassword	= PasswordManager.GetPassword(txtPassword.Text)
			};
			int vReturn = oDTO.fnGetResultInfo(gConnStr);

			if ( vReturn != 0 ) {
				throw new Exception($"Auth : {vReturn}");
			}
		}

		// 회원 탈퇴
		private void fnDropAccount() {
			uspSetNewDeleteAccount oDTO = new uspSetNewDeleteAccount
			{	pAccountNo	= AuthInfo.pAccountNo
			,	pCategory	= 0
			,	pMemoText	= ""
			};
			int vReturn = oDTO.fnSetDeleteInfo(gConnStr);

			if ( vReturn != 0 ) {
				throw new Exception($"Drop : {vReturn}");
			}
		}
		#endregion control layer


		#region button event layer
		// 탈퇴 버튼
		protected void btnDeactivate_Click(object sender, EventArgs e) {
			try {
				fnCheckAccount();
				fnDropAccount();
				AuthorityManager.ClearCookie();

				Response.Redirect("/");
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_03")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
