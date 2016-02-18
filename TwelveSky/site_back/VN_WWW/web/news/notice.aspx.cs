using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.news {
	public partial class notice : Page {
		private readonly webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
		private readonly string NAT_CD = SYS.NAT_CD;

		private const string DIV = "notice";
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(DIV);
			PAGE_TITL.InnerHtml = fnLabelText(DIV);

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
			int tmpTotalCnt = T_NOTI_BORD.getTotalCnt(DIV, NAT_CD);

			UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
		//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
			DataTable result = T_NOTI_BORD.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

			LIST.DataSource = result;
			LIST.DataBind();

			NO_LIST.Visible = result.Rows.Count == 0;
		}

		/*********************************************************************************************************************/
		/* data list click
        /*********************************************************************************************************************/
		protected void btn_list_Click(object sender, EventArgs e) {
			LinkButton lnkBtn = (LinkButton) sender;
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "notice_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}
	}
}
