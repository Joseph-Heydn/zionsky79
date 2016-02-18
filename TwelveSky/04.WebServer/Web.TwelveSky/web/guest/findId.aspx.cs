using System;
using System.Data;

using Field.AuthorityAppTier.Dal;

namespace Web.TwelveSky.web.guest {
	public partial class findId : BasePage {
		private const string gThisPage = "findId.aspx?m=1000023";
		private readonly string gConnStr = ConnString.fnGetName("Authority");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/findId.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// initialize parameter
		private void fnInitParameter() {
			pMenu.Value = Request.QueryString["m"];

			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}
			if ( pMenu.Value != "1000023" ) {
				Response.Redirect("/");
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region control layer
		private void fnFindAccount() {
			uspGetLookupAccountId oDTO = new uspGetLookupAccountId
			{	pNickName	= txtNickname.Text
			,	pLookupType = 0
			};
			int vReturn = oDTO.fnGetResultInfo(gConnStr);

			if ( vReturn != 0 ) {
				fnMessageKeyBack("msgError_03", gThisPage);
				return;
			}


			string[] vBody = {"", oDTO.oAccountId, "", "", ""};
			vBody[0] = $"http://www{ConfigValues.EnvText.sDomain}/web/email/findAccount.aspx";
			SendMail.fnSendMail(oDTO.oSecEmail, fnLabelText("msgMailSubject"), vBody);

			Response.Redirect("~/web/privacy/findResult.aspx?m=1000023&t=0");
		}
		#endregion control layer


		#region button event layer
		protected void btnFindAccount_Click(object sender, EventArgs e) {
			try {
				if ( Page.IsValid ) {
					fnFindAccount();
					return;
				}


				fnMessageKeyBack("msgError_04", gThisPage);
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
