using System;
using System.Web.UI;
using System.Data;

namespace _12sky2.web.news {
	public partial class notice_r : Page {
		private readonly webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
		private readonly string NAT_CD = SYS.NAT_CD;

		private const string DIV = "notice";
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {"SEQ"};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(DIV);
			PAGE_TITL.InnerHtml = fnLabelText(DIV);

			getRead();
			T_NOTI_BORD.updateHitCount(Request.QueryString["SEQ"]);
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* data search
        /*********************************************************************************************************************/
		private void getRead() {
			try {
				DataTable info = T_NOTI_BORD.getRead(DIV, NAT_CD, Request.QueryString["SEQ"]);

				if ( info.Rows.Count != 1 ) {
					SYS.errScript(this);
					return;
				}


				TITL.InnerHtml = info.Rows[0]["TITL"].ToString();
				REG_NICK_NM.InnerHtml = info.Rows[0]["REG_NICK_NM"].ToString();
				REG_DT.InnerHtml = info.Rows[0]["REG_DT"].ToString();
				HIT_CNT.InnerHtml = info.Rows[0]["HIT_CNT"].ToString();
				CNTN.InnerHtml = info.Rows[0]["CNTN"].ToString();
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
				SYS.errScript(this);
			}
		}

		/*********************************************************************************************************************/
 		/* data list click
		/*********************************************************************************************************************/
		protected void btn_list_Click(object sender, EventArgs e) {
			string[] REMOVE = {"SEQ"};
			Response.Redirect(SYS.makeURL(this, "notice.aspx", REMOVE));
		}
	}
}
