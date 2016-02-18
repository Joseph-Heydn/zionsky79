using System;
using System.Web.UI;

namespace _12sky2.web.include {
	public partial class head : UserControl {
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			TOP_MENU_LIST.Visible = SYS.is_login(Page);
			Page.Title = @"TwelveSky2 WSP";
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		public string GETBILLURL() {
			return SYS.BILL_URL;
		}
	}
}
