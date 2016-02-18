using System;

namespace Web.Audit {
	public partial class login : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("SiteManager");

		public login() {
			AuthoriyCheckAllow = false;
		}

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			C_WEB_RESOURCE = "/login.aspx";
			AuthorityManager.ClearCookie();
			fnInitParameter();
		}


		#region initialize Layer
		// 파라미터 바인딩
		private void fnInitParameter() {
			pListUrl.Value = Request.QueryString["pListUrl"];
			pReturnUrl.Value = Request.QueryString["pReturnUrl"];

			if ( string.IsNullOrEmpty(pReturnUrl.Value) ) {
				pReturnUrl.Value = "/";
			}
		}
		#endregion initialize Layer


		#region Logic Layer
		// 로그인
		private void fnAuthLogin() {
			string vPassword = PasswordManager.GetPassword(txtAccountId.Text, txtPassword.Text);
			int[] oReturnNo = AuthLoginAccount.fnLoginAccount(txtAccountId.Text, vPassword, fnHostIp(), gConnStr);

			if ( oReturnNo[0] == 0 ) {
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, 0);
				string vMoveUrl = pReturnUrl.Value.Replace("＆", "&");

				if ( !string.IsNullOrEmpty(pListUrl.Value) ) {
					vMoveUrl = $"{vMoveUrl}&pListUrl={pListUrl.Value}";
				}

				Response.Redirect(vMoveUrl);
			} else {
				// Faild
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, Convert.ToByte(oReturnNo));
				string vMessage = $"{fnLabelText("msg_Error_02")} [{oReturnNo}]";
				MsgBox(fnMessageText(vMessage));
			}
		}
		#endregion Logic Layer


		#region Control Layer
		protected void btnLogin_Click(object sender, EventArgs eventArgs) {
			fnAuthLogin();
		}
		#endregion Control Layer
	}
}
