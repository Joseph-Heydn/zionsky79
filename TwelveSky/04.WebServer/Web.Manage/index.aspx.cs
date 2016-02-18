using System;

namespace Web.Manage {
	public partial class index : BasePage {
		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}
		}
	}
}
