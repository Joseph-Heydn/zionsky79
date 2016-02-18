using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.media {
	public partial class list : Page {
		private readonly webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();
		private readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

		private readonly string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
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
				int tmpTotalCnt = T_MEDIA_BORD.getTotalCnt(Request.QueryString["DIV"].ToString(), NAT_CD);

				UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
				tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*int.Parse(SYS.LIST_EA));
				DataTable result = T_MEDIA_BORD.getList(Request.QueryString["DIV"].ToString(), NAT_CD, int.Parse(NOW_PAGE.Text));

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList(Request.QueryString["DIV"].ToString(), result.Rows[i]["SEQ"].ToString(), "IMAGE");

					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "'/>";
									break;
							}
						}
					}
				}

				LIST.DataSource = result;
				LIST.DataBind();

				if ( result.Rows.Count == 0 )
					NO_LIST.Visible = true;
				else
					NO_LIST.Visible = false;


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

