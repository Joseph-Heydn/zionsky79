using System;
using System.Web.UI;

namespace _12sky2.web.include {
	public partial class head : UserControl {
		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			TOP_MENU_LIST.Visible = SYS.is_login(Page);
			Page.Title = "TwelveSky2 WSP";
		}

		public string GETBILLURL() {
			return SYS.BILL_URL;
		}
	}
}
