using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.mypage {
	public partial class myquestions : Page {
		private readonly webservice.T_QUST T_QUST = new webservice.T_QUST();
		private readonly string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}
			if ( !SYS.is_login(Page) ) {
				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(this, "/", REMOVE));

				return;
			}


			const string DIV = "questions";

			NAV_TITL.InnerHtml = fnMainText(DIV);
			PAGE_TITL.InnerHtml = fnMainText(DIV);


			getList();
		}

		// 라벨에 텍스트 입력
		protected static string fnMainText(string pKey) {
			const string V_WEB_RESOURCE = "/web/include/head.ascx";
			return ResourceValues.AppResourceText(V_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			try {
				int tmpTotalCnt = T_QUST.getTotalCnt(Session["USER_ID"].ToString(), NAT_CD, null);

				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
				tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
				DataTable result = T_QUST.getList(Session["USER_ID"].ToString(), NAT_CD, int.Parse(NOW_PAGE.Text), null);

				LIST.DataSource = result;
				LIST.DataBind();

				if ( result.Rows.Count == 0 )
					NO_LIST.Visible = true;
				else
					NO_LIST.Visible = false;
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}

		}

		/*********************************************************************************************************************/
		/* data list click
        /*********************************************************************************************************************/
		protected void btn_list_Click(object sender, EventArgs e) {
			LinkButton lnkBtn = (LinkButton) sender;
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "myquestions_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}
	}
}
