using System;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Manage.site {
	public partial class password : BasePage {
		readonly string gConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/password.aspx";
		}


		#region Control Layer
		private void fnChangePassword() {
			string pwdOld = txtPassWd.Text;
			string pwdNew = txtPassWdChange.Text;
			string pwdchancheck = txtPassWdChangeCheck.Text;

			if ( pwdOld == "" || pwdNew == "" || pwdchancheck == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_01")));
			} else if ( !pwdNew.Equals(pwdchancheck) ) {
				txtPassWdChange.Text = "";
				txtPassWdChangeCheck.Text = "";

				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_02")));
			} else {
				string i_admin_id = AuthInfo.pAccountId;
				int vMenu = Convert.ToInt32(Request.QueryString["m"]);

				KWP00107_SG_WS_ADMIN_PASSWD_U oDTO = new KWP00107_SG_WS_ADMIN_PASSWD_U
				{	pAdminNo	= AuthInfo.pAccountNo
				,	pPasswdOld	= PasswordManager.GetPassword(i_admin_id, pwdOld)
				,	pPasswdNew	= PasswordManager.GetPassword(i_admin_id, pwdNew)
				,	pHostIp		= fnHostIp()
				};
				int vReturn = oDTO.fnSetModifyInfo(gConnStr);

				// 로그 기록
				WebLog.WriteLog.fnActionLogWrite(fnHostIp(), gGameNo, AuthInfo.pAccountNo, vMenu, vReturn, "KWP00107_SG_WS_ADMIN_PASSWD_U");
				switch ( vReturn ) {
					case 0:
						MsgBox(MsgValue.MessageEx(fnLabelText("msg_Success_01")));
						break;
					default:
						string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
						fnMessageText(vMessage);
						break;
				}
			}
		}
		#endregion Control Layer


		#region button event layer
		protected void btnUpdate_Click(object sender, CommandEventArgs e) {
			fnChangePassword();
		}
		#endregion button event layer
	}
}
