using System.Text;
using System.Web;

namespace Field.Framework.Web {
	/// <summary>
	/// Javascript Helper
	/// </summary>
	/// <remarks>author:Hoon-Sik,Jin</remarks>
	public static class ClientScriptHelper {
		private static void fnAlert(string pMessageText) {
			const string vScript = "<script language=\"javascript\">alert(\"{0}\");</script>";
			HttpContext.Current.Response.Write(string.Format(vScript, pMessageText));
		//	HttpContext.Current.Response.Write("<script language=\"javascript\">");
		//	HttpContext.Current.Response.Write("alert(\"" + messageText + "\");");
		//	HttpContext.Current.Response.Write("</script>");
		}

		public static void SetRegisterStartupScript(System.Web.UI.Page pPage, string pKey, string script) {
			pPage.ClientScript.RegisterStartupScript(pPage.GetType(), pKey, script, true);
		}

		public static void SetRegisterClientScriptBlock(System.Web.UI.Page pPage, string pKey, string script) {
			pPage.ClientScript.RegisterClientScriptBlock(pPage.GetType(), pKey, script, true);
		}

		public static void SetMsgBox(System.Web.UI.Page pPage, string pKey, string pText) {
			StringBuilder strBuilder = new StringBuilder();
			const string vScript = "alert(\"{0}\");";

			strBuilder.Append(string.Format(vScript, pText));
			strBuilder.Append("history.back();");

			pPage.ClientScript.RegisterClientScriptBlock(pPage.GetType(), pKey, strBuilder.ToString(), true);
		//	pPage.ClientScript.RegisterStartupScript(pPage.GetType(), pKey, strBuilder.ToString(), true);
		}
	}
}
