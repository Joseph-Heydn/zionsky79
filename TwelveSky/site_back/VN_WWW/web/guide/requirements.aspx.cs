using System;
using System.Web.UI;

namespace _12sky2.web.guide {
	public partial class requirements : Page {
		private const string C_WEB_RESOURCE = "/web/include/head.ascx";

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			NAV_TITL.InnerHtml = fnLabelText(left.SUB_TITL);
			PAGE_TITL.InnerHtml = fnLabelText(left.SUB_TITL);
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}
	}
}
