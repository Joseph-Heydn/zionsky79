using System;
using System.Data;

using Field.AuthorityAppTier.Dal;

namespace Web.TwelveSky.web.privacy {
	public partial class password : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("Authority");

		public password() {
			AuthoriyCheckAllow = true;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/password.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageBack(vMessage, "/");
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// initialize parameter
		private void fnInitParameter() {
			pMenu.Value = Request.QueryString["m"];

			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}
			if ( pMenu.Value != "1000019" ) {
				Response.Redirect("/");
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect("/");
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region control layer
		// 비밀번호 저장
		private void fnModifyPassword() {
			if ( txtAccountId.Text != AuthInfo.pAccountId ) {
				throw new Exception(fnLabelText("msgError_03"));
			}
			if ( txtPassword.Text.Length < 8 ) {
				throw new Exception(fnLabelText("msgAlert_02"));
			}
			if ( txtNewPassword.Text.Length < 8 ) {
				throw new Exception(fnLabelText("msgAlert_05"));
			}
			if ( txtConfirmPass.Text.Length < 8 ) {
				throw new Exception(fnLabelText("msgAlert_06"));
			}
			if ( txtNewPassword.Text != txtConfirmPass.Text ) {
				throw new Exception(fnLabelText("msgAlert_03"));
			}


			uspSetFixPassword oDTO = new uspSetFixPassword
			{	pAccountNo		= AuthInfo.pAccountNo
			,	pPassword		= PasswordManager.GetPassword(txtPassword.Text)
			,	pNewPassword	= PasswordManager.GetPassword(txtNewPassword.Text)
			};
			int vResult = oDTO.fnSetModifyInfo(gConnStr);

			if ( vResult == -2 ) {
				throw new Exception(fnLabelText("msgError_04"));
			}
			if ( vResult != 0 ) {
				throw new Exception(vResult.ToString());
			}
		}
		#endregion control layer


		#region button event layer
		protected void btnModifyPassword_OnClick(object sender, EventArgs e) {
			const string vThisPage = "password.aspx?m=1000019";

			try {
				if ( Page.IsValid ) {
					fnModifyPassword();
					AuthorityManager.ClearCookie();
					fnMessageKeyBack("msgAlert_09", "/");
					return;
				}


				fnMessageKeyBack("msgError_05", vThisPage);
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, vThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
