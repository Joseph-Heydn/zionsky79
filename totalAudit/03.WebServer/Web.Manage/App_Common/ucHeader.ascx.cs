using System;
using System.Web.UI;

namespace Web.Manage.App_Common {
	public partial class ucHeader : UserControl {
		protected void Page_Load(object sender, EventArgs e) {}


		#region button event layer
		// 로그 아웃 버튼
		protected void btnLogout_OnClick(object sender, EventArgs e) {
			AuthorityManager.ClearCookie();
			Response.Redirect("/");
		}
		#endregion button event layer
	}
}
