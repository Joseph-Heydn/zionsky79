using System;
using System.Web.UI;

namespace _12sky2.web.media {
	public partial class video_w : Page {
		private readonly webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();
		private readonly string NAT_CD = SYS.NAT_CD;
		private const string DIV = "video";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
			if ( !SYS.is_check(this.Page, KEY) )
				return;

			if ( !IsPostBack ) {
				left.setSUB_TITL = DIV;

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
		protected void btn_save_Click(object sender, EventArgs e) {
			try {
				string tmpCntn = Server.UrlDecode(_contents.Value);

				T_MEDIA_BORD.insert(DIV, _title.Value, tmpCntn, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), "N", NAT_CD, PATH.Text, _fileList.Value.Split(new char[] {','}));

				string[] REMOVE = {};

				SYS.Javascript(this.Page, "location.href = '" + SYS.makeURL(this, "video.aspx", REMOVE) + "';");
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
				SYS.Javascript(this.Page, "alert('Failed to save!');");
			}
		}

		/*********************************************************************************************************************/
		/* list
        /*********************************************************************************************************************/
		protected void btn_list_Click(object sender, EventArgs e) {
			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this, "video.aspx", REMOVE));
		}
	}
}
