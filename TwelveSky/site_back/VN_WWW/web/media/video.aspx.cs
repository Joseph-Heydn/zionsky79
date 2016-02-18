using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.media {
	public partial class video : Page {
		private readonly webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();
		private readonly string NAT_CD = SYS.NAT_CD;
		private const string DIV = "video";
		private const string C_WEB_RESOURCE = "/web/include/head2.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(left.SUB_TITL);
			PAGE_TITL.InnerHtml = fnLabelText(left.SUB_TITL);
			getList();
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			try {
				int tmpTotalCnt = T_MEDIA_BORD.getTotalCnt(DIV, NAT_CD);
				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));

			//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
				DataTable result = T_MEDIA_BORD.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					string path = result.Rows[i]["PATH"].ToString();
					string movie_id = path.Substring(path.LastIndexOf('/'));
					result.Rows[i]["IMG_SRC"] = "<img src='http://img.youtube.com/vi" + movie_id + "/0.jpg' width='200'/>";

				}

				LIST.DataSource = result;
				LIST.DataBind();

				NO_LIST.Visible = result.Rows.Count == 0;
				btn_reg.Visible = SYS.is_login(Page);
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
			}
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* data list click
        /*********************************************************************************************************************/
		protected void btn_list_Click(object sender, EventArgs e) {
			LinkButton lnkBtn = (LinkButton) sender;
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "video_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}

		/*********************************************************************************************************************/
		/* data write
        /*********************************************************************************************************************/
		protected void btn_reg_Click(object sender, EventArgs e) {
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "video_w.aspx", REMOVE));
		}
	}
}
