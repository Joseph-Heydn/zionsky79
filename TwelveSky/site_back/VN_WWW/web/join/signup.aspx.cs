using System;
using System.Web.UI;

namespace _12sky2.web.join {
	public partial class signup : Page {
		private readonly webservice.T_MBER T_MBER = new webservice.T_MBER();
		private readonly string NAT_CD = SYS.NAT_CD;
		private const string C_WEB_RESOURCE = "/web/join/signup.aspx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
			const string vDivs = "Signup";

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(vDivs);
			PAGE_TITL.InnerHtml = fnLabelText(vDivs);
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
				//recaptcha check
				if ( !Page.IsValid ) {
					SYS.Javascript(Page, "location.href = '/web/join/signupfail.aspx';");
				} else {
					try {
						string EMAIL_RECV_YN = "N";
						if ( IsEmailChk.Checked ) {
							EMAIL_RECV_YN = "Y";
						}

					//	T_MBER.insert(UserID.Text, Nickname.Text, Password.Text, "1", NAT_CD, SecurityEmail.Text, EMAIL_RECV_YN);
						T_MBER.insert(UserID.Text, Nickname.Text, Password.Text, "2", NAT_CD, SecurityEmail.Text, EMAIL_RECV_YN);

						SYS.Javascript(Page, "location.href = '/web/join/signupsuccess.aspx';");
					} catch ( Exception ex ) {
						SYS.Save_Log(ex.ToString());
					}

				}
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.ToString());
				SYS.Javascript(Page, "location.href = '/web/join/signupfail.aspx';");
			}
		}
	}
}
