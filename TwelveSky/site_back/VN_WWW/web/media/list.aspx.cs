using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.media {
	public partial class list : Page {
		private readonly webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();
		private readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

		private readonly string NAT_CD = SYS.NAT_CD;
		private const string C_WEB_RESOURCE = "/web/include/head2.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

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
				int tmpTotalCnt = T_MEDIA_BORD.getTotalCnt(vDivs, NAT_CD);

				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
			//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
				DataTable result = T_MEDIA_BORD.getList(vDivs, NAT_CD, int.Parse(NOW_PAGE.Text));

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList(vDivs, result.Rows[i]["SEQ"].ToString(), "IMAGE");

					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( !fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							continue;
						}

						switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
							case ".png":
							case ".jpg":
							case ".gif":
							case ".bmp":
								result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"] + "'/>";
								break;
						}
					}
				}

				LIST.DataSource = result;
				LIST.DataBind();

				NO_LIST.Visible = result.Rows.Count == 0;
				btn_reg.Visible = SYS.is_login(Page);
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
			}
		}

		/*********************************************************************************************************************/
		/* data list click
        /*********************************************************************************************************************/
		//
		protected void btn_list_Click(object sender, EventArgs e) {
			LinkButton lnkBtn = (LinkButton) sender;
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "read.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}

		/*********************************************************************************************************************/
		/* data write
        /*********************************************************************************************************************/
		//
		protected void btn_reg_Click(object sender, EventArgs e) {
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "write.aspx", REMOVE));
		}
	}
}
