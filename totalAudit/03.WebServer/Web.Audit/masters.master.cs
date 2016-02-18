using System;
using System.Web.UI;

namespace Web.Audit {
	public partial class App_Master : MasterPage {
		private const string C_WEB_RESOURCE = "/index.aspx";

		protected void Page_Load(object sender, EventArgs e) {
		}


		#region initialize layer
		protected override void OnUnload(EventArgs e) {
			base.OnUnload(e);
		}

		// 키값에 맞는 리소스 텍스트
		protected string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}
		#endregion initialize layer


		#region button event layer
		// 관리웹 로그아웃
		protected void btnLogout_Click(object sender, EventArgs e) {
			// 쿠키제거후 로그인페이지로 Redirection...
			AuthorityManager.ClearCookie();

			Response.Redirect("/login.aspx");
		//	Response.Redirect(ConfigValues.EnvUrl.wLoginUrl);
		}
		#endregion button event layer
	}
}
