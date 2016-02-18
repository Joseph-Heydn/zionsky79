using System;
using System.Data;
using System.Web.UI;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky {
	public partial class index : BasePage {
		protected readonly string C_NATE_CODE = ConfigValues.EnvText.cNateCode;
		protected readonly string C_LANG_CODE = ConfigValues.EnvText.cLangCode;
		protected string C_GAMEDOWN_URL = ConfigValues.EnvText.cGameDown;
		protected string C_FACEBOOK_URL = ConfigValues.EnvText.cFaceBook;
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/index.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitDefaultSetting();
				fnDisplayMainContents();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		private void fnInitDefaultSetting() {
			if ( Master != null ) {
				UserControl vLeftMenu = (UserControl) Master.FindControl("ucLeftMenu");
				vLeftMenu.Visible = false;
			}


			string vSubUrl = "";
			if ( C_NATE_CODE == "VN" ) {
				vSubUrl = "TS2.";
			}

			C_GAMEDOWN_URL = string.Format(C_GAMEDOWN_URL, C_NATE_CODE);
			C_FACEBOOK_URL = string.Format(C_FACEBOOK_URL, C_NATE_CODE, vSubUrl);

			if ( AuthInfo.pAccountNo == 0 ) {
				C_GAMEDOWN_URL = "javascript:fnDownload();";

				pnUserPage.Visible	= false;
				pnLoginPage.Visible	= true;
			} else {
				pnUserPage.Visible	= true;
				pnLoginPage.Visible	= false;

				lblNickName.Text = AuthInfo.pAccountNm;
			}
		}
		#endregion initialize layer


		#region binding layer
		private void fnDisplayMainContents() {
			uspGetMainList oDTO = new uspGetMainList
			{	pGameNo		= gGameNo
			,	pPublisher	= gPublisher
			};
			DataSet vContentsList = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{oDTO.oReturnNo}]";
				fnMessageText(vMessage);
				return;
			}


			// 슬라이딩 이미지
			repTopRolling.DataSource = vContentsList.Tables[0];
			repTopRolling.DataBind();
			repTopRollBtn.DataSource = vContentsList.Tables[0];
			repTopRollBtn.DataBind();

			// 광고글 출력
			repAnnounce.DataSource = vContentsList.Tables[1];
			repAnnounce.DataBind();

			// 홍보 동영상
			if ( vContentsList.Tables[2].Rows.Count > 0 ) {
				const string vYoutube = "https://www.youtube.com/embed";
				lblMovie.Text = $"<iframe src=\"{vYoutube}/{vContentsList.Tables[2].Rows[0][1]}\" width=\"230\" height=\"235\" frameborder=\"0\" allowfullscreen></iframe>";
            }

			vContentsList.Dispose();
		}

		protected string fnImageUrl(object pFolder, object pFileNo, object pExts, string pSize) {
			return $"/FileUp/{pFolder}/{pFileNo}-{pSize}.{pExts}";
		}
		protected string fnHideImage() {
			return gRowNo++ == 0 ? "" : " style=\"display:none;\"";
		}
		#endregion binding layer


		#region logic layer
		// 로그인
		private void fnLogin() {
			string vPassword = PasswordManager.GetPassword(txtPassword.Text);
			int oReturnNo = AuthLoginAccount.fnWebLoginAccount(txtAccountId.Text, vPassword, fnHostIp(), ConnString.fnGetName("Authority"));

			if ( oReturnNo == 0 ) {
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, 0);
			} else {
				// Faild
				WebLog.WriteLog.fnWebLoginWrite(gGameNo, txtAccountId.Text, Convert.ToByte(oReturnNo));
				throw new Exception(oReturnNo.ToString());
			}

			Response.Redirect("/");
		}

		// 로그아웃
		private void fnLogout() {
			AuthorityManager.ClearCookie();
			Response.Redirect("/");
		}
		#endregion logic layer


		#region button event layer
		// 로그인 버튼
		protected void btnLogin_OnClick(object sender, EventArgs e) {
			try {
				fnLogin();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, "/");
				fnWriterLog(ex);
			}
		}

		// 로그아웃 버튼
		protected void btnLogout_OnClick(object sender, EventArgs e) {
			try {
				fnLogout();
			} catch ( Exception ex ) {
				fnWriterLog(ex);
				Response.Redirect("/");
			}
		}
		#endregion button event layer
	}
}
