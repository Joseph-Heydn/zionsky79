using System;
using System.Data;

namespace Web.TwelveSky.web.guest {
	public partial class signupOk : BasePage {
		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/board/write.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
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
			if ( pMenu.Value != "1000025" ) {
				Response.Redirect("/");
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer
	}
}
