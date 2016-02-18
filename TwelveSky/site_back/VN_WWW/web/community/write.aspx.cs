using System;
using System.Web.UI;

namespace _12sky2.web.community {
	public partial class write : Page {
		webservice.T_COMMUNITY_BORD T_COMMUNITY_BORD = new webservice.T_COMMUNITY_BORD();
		private string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {"DIV"};
			if ( !SYS.is_check(this.Page, KEY) )
				return;

			if ( !IsPostBack ) {
				left.setSUB_TITL = Request.QueryString["DIV"].ToString();

				NAV_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);
				PAGE_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);
			}

			CNTN.config.toolbar = new object[] {new object[] {"Source"}, new object[] {"Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"}, new object[] {"Find", "Replace", "-", "SelectAll"}, new object[] {"Link", "Unlink", "Anchor"}, "/", new object[] {"Bold", "Italic", "Underline", "Strike", "-", "RemoveFormat"}, new object[] {"NumberedList", "BulletedList", "-", "Outdent", "Indent", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock", "-", "BidiLtr", "BidiRtl"}, new object[] {"Table", "HorizontalRule", "SpecialChar"}, "/", new object[] {"Styles", "Format", "Font", "FontSize"}, new object[] {"TextColor", "BGColor"}, new object[] {"Maximize", "ShowBlocks"}};
			CNTN.Language = SYS.NAT_LANG;
			CNTN.UIColor = SYS.EDITOR_COLOR;
		}

		/*********************************************************************************************************************/
		/* save
        /*********************************************************************************************************************/
		//
		protected void btn_save_Click(object sender, EventArgs e) {
			try {
				string tmpCntn = Server.UrlDecode(_contents.Value);

				T_COMMUNITY_BORD.insert(Request.QueryString["DIV"].ToString(), _title.Value, tmpCntn, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), "N", NAT_CD, _fileList.Value.Split(new char[] {','}));

				string[] REMOVE = {};

				SYS.Javascript(this.Page, "location.href = '" + SYS.makeURL(this, "list.aspx", REMOVE) + "';");
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
				SYS.Javascript(this.Page, "alert('Failed to save!');");
			}

		}

		/*********************************************************************************************************************/
		/* list
        /*********************************************************************************************************************/
		//
		protected void btn_list_Click(object sender, EventArgs e) {
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
		}
	}
}
