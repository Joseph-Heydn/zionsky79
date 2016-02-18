using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.shop
{
    public partial class edit : System.Web.UI.Page
    {
        webservice.T_ITEM_LIST T_ITEM_LIST = new webservice.T_ITEM_LIST();
        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "DIV", "SEQ" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                admin_left.setSUB_TITL = Request.QueryString["DIV"].ToString();

                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                getRead();
            }

            CNTN.config.toolbar = new object[]
			{
                new object[] { "Source" },
                new object[] { "Cut", "Copy", "Paste", "PasteText", "PasteFromWord", 
                                "-", "Undo", "Redo"  },
                new object[] { "Find", "Replace", "-", "SelectAll"},
                new object[] { "Link", "Unlink", "Anchor" },
                "/",
                new object[] { "Bold", "Italic", "Underline", "Strike", "-", "RemoveFormat" },
                new object[] { "NumberedList", "BulletedList", "-", "Outdent", "Indent",
                               "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock",
                               "-", "BidiLtr", "BidiRtl"},                
                
                new object[] { "Table", "HorizontalRule", "SpecialChar"},
				"/",
				new object[] { "Styles", "Format", "Font", "FontSize" },				
                new object[] { "TextColor", "BGColor" },                
                new object[] { "Maximize", "ShowBlocks" }									
			};
            CNTN.Language = SYS.NAT_LANG;
            CNTN.UIColor = SYS.EDITOR_COLOR;
        }

        /*********************************************************************************************************************/
        /* read
        /*********************************************************************************************************************/
        //
        private void getRead()
        {
            try
            {
                DataTable info = T_ITEM_LIST.getRead(Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                ITEM_NM.Text = info.Rows[0]["ITEM_NM"].ToString();
                SALE_QTY.Text = info.Rows[0]["SALE_QTY"].ToString();
                SALE_AMT.Text = info.Rows[0]["SALE_AMT"].ToString();
                CNTN.Text = info.Rows[0]["EXPL"].ToString();

                //-------------------------------------------------
                // 첨부파일 정보
                //-------------------------------------------------
                DataTable fileInfo = T_FILE_INFO.getList(Request.QueryString["DIV"].ToString(), Request.QueryString["SEQ"].ToString(), "IMAGE");

                if (!fileInfo.Rows.Count.Equals(0))
                {
                    for (int i = 0; i < fileInfo.Rows.Count; i++)
                    {
                        if (i != 0)
                        {
                            _fileList.Value += ",";
                        }
                        _fileList.Value += fileInfo.Rows[i]["SEQ"].ToString();

                        IMG_SRC.InnerHtml = "<img src='/resources/file/image.aspx?seq=" + fileInfo.Rows[i]["SEQ"].ToString() + "' width='50'/>";
                    }
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }
        }

        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                string tmpCntn = Server.UrlDecode(_contents.Value);

                T_ITEM_LIST.update(Request.QueryString["SEQ"].ToString(), Request.QueryString["DIV"].ToString()
                    , _ITEM_NM.Value, _SALE_QTY.Value, _SALE_AMT.Value, tmpCntn, ""
                    , Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), NAT_CD,
                    FILE_SEQ.Value.Split(new char[] { ',' }), DEL_FILE_SEQ.Value.Split(new char[] { ',' }));

                string[] REMOVE = { };
                SYS.Javascript(this.Page, "location.href = '" + SYS.makeURL(this, "read.aspx", REMOVE) + "';");
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }

        /*********************************************************************************************************************/
        /* cancel
        /*********************************************************************************************************************/
        //
        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "read.aspx", REMOVE));
        }
        /*********************************************************************************************************************/
        /* list
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { "SEQ" };
            Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
        }
    }
}
