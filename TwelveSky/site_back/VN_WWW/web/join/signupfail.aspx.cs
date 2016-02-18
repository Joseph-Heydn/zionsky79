using System;
using System.Web.UI;

namespace _12sky2.web.join {
	public partial class signupfail : Page {
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			const string vDivs = "Signup";
			NAV_TITL.InnerHtml = fnLabelText(vDivs);
			PAGE_TITL.InnerHtml = fnLabelText(vDivs);
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}
	}
}
