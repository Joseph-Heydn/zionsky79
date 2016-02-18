using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.news {
	public partial class announcement : Page {
		private readonly webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
		private readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();
		private readonly string NAT_CD = SYS.NAT_CD;

		private const string DIV = "announcement";
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
			int LIST_CNT = int.Parse(SYS.LIST_EA);

			if ( DIV.Equals("announcement") ) {
				LIST_CNT = 5;
			}

			UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, LIST_CNT);
		//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*LIST_CNT);
			DataTable result = T_NOTI_BORD.getList2(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

			for ( int i = 0; i < result.Rows.Count; i++ ) {
				DataTable fileList = T_FILE_INFO.getList(DIV, result.Rows[i]["SEQ"].ToString(), "FILE");

				for ( int j = 0; j < fileList.Rows.Count; j++ ) {
					if ( !fileList.Rows[j]["FILE_DIV"].ToString().Equals("FILE") ) {
						continue;
					}

					switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
						case ".png":
						case ".jpg":
						case ".gif":
						case ".bmp":
							result.Rows[i]["IMG_SRC"] = $"<img src=\"/resources/file/image.aspx?seq={fileList.Rows[j]["SEQ"]}\"/>";
							break;
					}
				}
			}

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
			Response.Redirect(SYS.makeURL(this, "announcement_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
		}
	}
}
