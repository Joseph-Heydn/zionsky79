using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.news
{
    public partial class edit : System.Web.UI.Page
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
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


                if (Request.QueryString["DIV"].ToString().Equals("announcement"))
                {
                    fileTitle.InnerHtml = "Thumbnail Image";
                }
                else
                {
                    fileTitle.InnerHtml = "Attach Files";
                }

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
                DataTable info = T_NOTI_BORD.getRead(Request.QueryString["DIV"].ToString(), NAT_CD, Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                TITL.Text = info.Rows[0]["TITL"].ToString();
                CNTN.Text = info.Rows[0]["CNTN"].ToString();

                //-------------------------------------------------
                // 첨부파일 정보
                //-------------------------------------------------
                DataTable fileInfo = T_FILE_INFO.getList(Request.QueryString["DIV"].ToString(), Request.QueryString["SEQ"].ToString(), "FILE");

                if (!fileInfo.Rows.Count.Equals(0))
                {
                    for (int i = 0; i < fileInfo.Rows.Count; i++)
                    {
                        if (i != 0)
                        {
                            _fileList.Value += ",";
                        }
                        _fileList.Value += fileInfo.Rows[i]["SEQ"].ToString();

                        EDIT_FILE_LIST.InnerHtml += "<div id='file_" + fileInfo.Rows[i]["SEQ"].ToString() + "'>";
                        EDIT_FILE_LIST.InnerHtml += fileInfo.Rows[i]["FILE_LINK"].ToString();
                        EDIT_FILE_LIST.InnerHtml += " (" + fileInfo.Rows[i]["FILE_SIZE"].ToString() + "Mb) ";
                        EDIT_FILE_LIST.InnerHtml += " <a href='#' onclick='fileDelete(\"" + fileInfo.Rows[i]["SEQ"].ToString() + "\", \"" + fileInfo.Rows[i]["FILE_DIV"].ToString() + "\");'>delete</a>";
                        EDIT_FILE_LIST.InnerHtml += "</div>";
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

                T_NOTI_BORD.update(Request.QueryString["DIV"].ToString(), Request.QueryString["SEQ"].ToString(), _title.Value, tmpCntn, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), "N", FILE_SEQ.Value.Split(new char[] { ',' }), DEL_FILE_SEQ.Value.Split(new char[] { ',' }));

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
