using System;
using System.Data;

using Field.AuthorityAppTier.Dal;

namespace Web.TwelveSky.web.guest {
	public partial class signup : BasePage {
		private const string gThisPage = "signup.aspx?m=1000025";
		private readonly string gConnStr = ConnString.fnGetName("Authority");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/signup.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
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
			if ( pMenu.Value != "1000025" ) {
				Response.Redirect("/");
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region control layer
		private void fnRegister() {
			if ( txtAccountId.Text == "" || txtAccountId.Text.Length < 10 ) {
				throw new Exception(fnLabelText("msgError_04"));
			}
			if ( txtPassword.Text == "" || txtPassword.Text.Length < 7 ) {
				throw new Exception(fnLabelText("msgError_10"));
			}
			if ( txtSecurityEmail.Text == "" || txtSecurityEmail.Text.Length < 10 ) {
				throw new Exception(fnLabelText("msgError_16"));
			}
			if ( txtNickName.Text == "" || txtNickName.Text.Length < 5 ) {
				throw new Exception(fnLabelText("msgError_12"));
			}


			const string vSignup = "signup{0}.aspx?m=1000025";

			uspSetNewAccount oDTO = new uspSetNewAccount
			{	pAccountId	= txtAccountId.Text
			,	pPassword	= PasswordManager.GetPassword(txtPassword.Text)
			,	pNickName	= txtNickName.Text
			,	pEmail		= txtSecurityEmail.Text
			,	pHostIp		= fnHostIp()
			,	pEmailAgree	= chkIsEmailOk.Checked
			};
			int vReturn = oDTO.fnSetWriteInfo(gConnStr);

			switch ( vReturn ) {
				case 2:
					fnMessageKeyBack("msgError_05", string.Format(vSignup, ""));
					return;
				case 3:
					fnMessageKeyBack("msgError_14", string.Format(vSignup, ""));
					return;
			}

			Response.Redirect(string.Format(vSignup, "ok"));
		}
		#endregion control layer


		#region button event layer
		// 회원 가입 클릭
		protected void btnSignUp_Click(object sender, EventArgs e) {
			try {
				if ( Page.IsValid ) {
					fnRegister();
					return;
				}


				fnMessageKeyBack("msgError_22", gThisPage);
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_21")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
