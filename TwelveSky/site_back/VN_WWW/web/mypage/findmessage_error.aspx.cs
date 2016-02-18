using System;
using System.Web.UI;

namespace _12sky2.web.mypage {
	public partial class findmessage_error : Page {
		protected void Page_Load(object sender, EventArgs e) {}

		// 라벨에 텍스트 입력
		protected static string fnMainText(string pKey) {
			const string V_WEB_RESOURCE = "/web/include/head.ascx";
			return ResourceValues.AppResourceText(V_WEB_RESOURCE, pKey);
		}
	}
}
