using System;
using System.Data;
using System.Web.UI;

namespace _12sky2.web.shop {
	public partial class upgrading : Page {
		private readonly webservice.T_ITEM_LIST T_ITEM_LIST = new webservice.T_ITEM_LIST();
		private readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();
		private readonly string NAT_CD = SYS.NAT_CD;

		private const string DIV = "upgrading";
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(DIV);
			PAGE_TITL.InnerHtml = fnLabelText(DIV);

			LEFT_MENU_LIST.Visible = SYS.is_login(Page);
			getList();
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		public string GETBILLURL() {
			return SYS.BILL_URL;
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			int tmpTotalCnt = T_ITEM_LIST.getTotalCnt(DIV, NAT_CD);

			UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, 5);
		//	tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1)*5);
			DataTable result = T_ITEM_LIST.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

			for ( int i = 0; i < result.Rows.Count; i++ ) {
				DataTable fileList = T_FILE_INFO.getList(DIV, result.Rows[i]["SEQ"].ToString(), "IMAGE");

				for ( int j = 0; j < fileList.Rows.Count; j++ ) {
					if ( !fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
						continue;
					}

					switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
						case ".png":
						case ".jpg":
						case ".gif":
						case ".bmp":
							result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"] + "' width='50'/>";
							break;
					}
				}
			}

			LIST.DataSource = result;
			LIST.DataBind();

			NO_LIST.Visible = result.Rows.Count == 0;
		}
	}
}
