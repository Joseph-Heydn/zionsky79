using System;
using System.Web.UI;

namespace _12sky2.admin.user {
	public partial class password : Page {
		private readonly webservice.T_MBER T_MBER = new webservice.T_MBER();
		private const string C_WEB_RESOURCE = "/web/admin/password.aspx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
			PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* save
        /*********************************************************************************************************************/
		protected void btn_submit_Click(object sender, EventArgs e) {
			try {
				T_MBER.passwordChange2(UserID.Text, NewPassword.Text);

				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(Page, Page.Request.Path, REMOVE));
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
				SYS.Javascript(Page, "alert('The information you have entered is not valid.\nPlease try again.');");
			}

		}
	}
}
