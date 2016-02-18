using System;
using System.Web;
using System.Web.UI;
using System.Web.Security;

namespace _12sky2.web.mypage {
	public partial class password : Page {
		private readonly webservice.T_MBER T_MBER = new webservice.T_MBER();
		private const string C_WEB_RESOURCE = "/web/mypage/password.aspx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			const string DIV = "password";

			NAV_TITL.InnerHtml = fnMainText(DIV);
			PAGE_TITL.InnerHtml = fnMainText(DIV);


			if ( SYS.is_login(Page) ) {
				return;
			}


			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "/", REMOVE));
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		// 라벨에 텍스트 입력
		protected static string fnMainText(string pKey) {
			const string V_WEB_RESOURCE = "/web/include/head.ascx";
			return ResourceValues.AppResourceText(V_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* save
		/*********************************************************************************************************************/
		protected void btn_submit_Click(object sender, EventArgs e) {
			try {
				//recaptcha check
				if ( !Page.IsValid ) {
					SYS.Javascript(Page, $"alert('{fnLabelText("msgError_08")}');");
				} else {
					T_MBER.passwordChange(UserID.Text, Password.Text, NewPassword.Text);

					FormsAuthentication.SignOut();
					Session.Clear();
					Session.Abandon();

					if ( Request.Cookies["tmpUSER"] != null ) {
						HttpCookie myCookie = new HttpCookie("tmpUSER") {
							Expires = DateTime.Now.AddDays(-1d)
						};
						Response.Cookies.Add(myCookie);
					}

					SYS.Javascript(Page, "location.href = '/';");
				}
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
				SYS.Javascript(Page, $"alert('{fnLabelText("msgError_08")}');");
			}
		}
	}
}
