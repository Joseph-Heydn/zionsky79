using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.community {
	public partial class list : Page {
		webservice.T_COMMUNITY_BORD T_COMMUNITY_BORD = new webservice.T_COMMUNITY_BORD();

		private static int totalCnt = 0;
		private string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {"DIV"};
			if ( !SYS.is_check(this.Page, KEY) )
				return;

			if ( !IsPostBack ) {
				left.setSUB_TITL = Request.QueryString["DIV"].ToString();

				NAV_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);
				PAGE_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);
				getList();
			}
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			try {
				int tmpTotalCnt = T_COMMUNITY_BORD.getTotalCnt(Request.QueryString["DIV"].ToString(), NAT_CD);

				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
				tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
				totalCnt = tmpTotalCnt;

				DataTable result = T_COMMUNITY_BORD.getList(Request.QueryString["DIV"].ToString(), NAT_CD, int.Parse(NOW_PAGE.Text));

				LIST.DataSource = result;
				LIST.DataBind();

				if ( result.Rows.Count == 0 )
					NO_LIST.Visible = true;
				else
					NO_LIST.Visible = false;

				DataTable result_top = T_COMMUNITY_BORD.getTopList(Request.QueryString["DIV"].ToString(), NAT_CD);

				TOP_LIST.DataSource = result_top;
				TOP_LIST.DataBind();

				if ( result_top.Rows.Count > 0 )
					TOP_LIST.Visible = true;
				else
					TOP_LIST.Visible = false;

				DataTable result_top5 = T_COMMUNITY_BORD.getTop5List(Request.QueryString["DIV"].ToString(), NAT_CD);

				TOP_5_LIST.DataSource = result_top5;
				TOP_5_LIST.DataBind();

				if ( result_top5.Rows.Count > 0 )
					TOP_5_LIST.Visible = true;
				else
					TOP_5_LIST.Visible = false;


				if ( SYS.is_login(this.Page) )
					btn_reg.Visible = true;
				else
					btn_reg.Visible = false;
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
			Response.Redirect(SYS.makeURL(this, "read.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}

		/*********************************************************************************************************************/
		/* data write
        /*********************************************************************************************************************/
		protected void btn_reg_Click(object sender, EventArgs e) {
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "write.aspx", REMOVE));
		}
	}
}
