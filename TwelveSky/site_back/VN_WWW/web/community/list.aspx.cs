using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.community {
	public partial class list : Page {
		private readonly webservice.T_COMMUNITY_BORD T_COMMUNITY_BORD = new webservice.T_COMMUNITY_BORD();
		private const string C_WEB_RESOURCE = "/web/include/head2.ascx";

	//	private static int totalCnt = 0;
		private readonly string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {"DIV"};
			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			left.setSUB_TITL = Request.QueryString["DIV"];
			string vSubTitle = fnLabelText(MENU.getPageTItle(left.TITL, left.SUB_TITL));

			NAV_TITL.InnerHtml = vSubTitle;
			PAGE_TITL.InnerHtml = vSubTitle;

			getList();
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			try {
				string vDivs = Request.QueryString["DIV"];
				int tmpTotalCnt = T_COMMUNITY_BORD.getTotalCnt(Request.QueryString["DIV"], NAT_CD);

				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
			//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
			//	totalCnt = tmpTotalCnt;


				DataTable result = T_COMMUNITY_BORD.getList(vDivs, NAT_CD, int.Parse(NOW_PAGE.Text));

				LIST.DataSource = result;
				LIST.DataBind();
				NO_LIST.Visible = result.Rows.Count == 0;


				DataTable result_top = T_COMMUNITY_BORD.getTopList(vDivs, NAT_CD);

				TOP_LIST.DataSource = result_top;
				TOP_LIST.DataBind();
				TOP_LIST.Visible = result_top.Rows.Count > 0;


				DataTable result_top5 = T_COMMUNITY_BORD.getTop5List(vDivs, NAT_CD);

				TOP_5_LIST.DataSource = result_top5;
				TOP_5_LIST.DataBind();
				TOP_5_LIST.Visible = result_top5.Rows.Count > 0;


				btn_reg.Visible = SYS.is_login(Page);
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
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
