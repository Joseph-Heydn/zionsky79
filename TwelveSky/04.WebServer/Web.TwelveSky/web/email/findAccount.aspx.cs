using System;
using System.Web.UI;

namespace Web.TwelveSky.web.email {
	public partial class findAccount : Page {
		protected readonly string gDomain = $"http://www{ConfigValues.EnvText.sDomain}";
		protected void Page_Load(object sender, EventArgs e) {}
	}
}
