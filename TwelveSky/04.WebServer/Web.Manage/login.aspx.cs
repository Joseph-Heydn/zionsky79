using System;

namespace Web.Manage {
	public partial class login : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("SiteManager");
		private static string gThisPage = "/login.aspx?r={0}";

		public login() {
			AuthoriyCheckAllow = false;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/login.aspx";

			if ( IsPostBack ) {
				return;
			}


			AuthorityManager.ClearCookie();
			fnInitParameter();
		}


		#region initialize Layer
		// 파라미터 바인딩
		private void fnInitParameter() {
			pReturn.Value = Request.QueryString["r"];

			if ( string.IsNullOrEmpty(pReturn.Value) ) {
				pReturn.Value = "/";
			}

			gThisPage = string.Format(gThisPage, pReturn.Value);
		}
		#endregion initialize Layer


		#region Logic Layer
		// 로그인
		private void fnAuthLogin() {
			string vPassword = PasswordManager.GetPassword(txtAccountId.Text, txtPassword.Text);
			int vReturn = AuthLoginAccount.fnLoginAccount(txtAccountId.Text, vPassword, fnHostIp(), gConnStr);

			if ( vReturn == 0 ) {
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, 0);
				Response.Redirect(pReturn.Value);
			} else {
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, Convert.ToByte(vReturn));
				throw new Exception($"fail : {vReturn}");
			}
		}
		#endregion Logic Layer


		#region Control Layer
		protected void btnLogin_Click(object sender, EventArgs eventArgs) {
			try {
				fnAuthLogin();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion Control Layer
	}
}
