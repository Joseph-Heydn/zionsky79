using System;
using System.Web.UI.WebControls;

namespace Web.Manage.site {
	public partial class encryptTest : BasePage {
		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/encryptTest.aspx";
		}


		protected void btnUpdate_Click(object sender, CommandEventArgs e) {
			txtMD5Hash.Text = PasswordManager.GetPassword(txtUserId.Text, txtPassWd.Text);
		}
	}
}
