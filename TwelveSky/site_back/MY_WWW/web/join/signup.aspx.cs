using System;
using System.Web.UI;

namespace _12sky2.web.join {
	public partial class signup : Page {
		readonly webservice.T_MBER T_MBER = new webservice.T_MBER();
		private readonly string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}


			if ( !IsPostBack ) {
			}
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
