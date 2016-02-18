using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.shop
{
    public partial class read : System.Web.UI.Page
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
        }
        /*********************************************************************************************************************/
        /* data search
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

                ITEM_NM.InnerHtml = info.Rows[0]["ITEM_NM"].ToString();
                SALE_QTY.InnerHtml = int.Parse(info.Rows[0]["SALE_QTY"].ToString()).ToString("#,#;0;0");
                SALE_AMT.InnerHtml = int.Parse(info.Rows[0]["SALE_AMT"].ToString()).ToString("#,#;0;0");
                EXPL.InnerHtml = info.Rows[0]["EXPL"].ToString();

                DataTable fileList = T_FILE_INFO.getList(Request.QueryString["DIV"].ToString(), Request.QueryString["SEQ"].ToString(), "IMAGE");

                for (int j = 0; j < fileList.Rows.Count; j++)
                {
                    if (fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE"))
                    {
                        switch (fileList.Rows[j]["FILE_TYP"].ToString().ToLower())
                        {
                            case ".png":
                            case ".jpg":
                            case ".gif":
                            case ".bmp":
                                IMG_SRC.InnerHtml = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "' width='50'/>";
                                break;
                        }
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
        /* edit
        /*********************************************************************************************************************/
        //
        protected void btn_edit_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "edit.aspx", REMOVE));
        }
        /*********************************************************************************************************************/
        /* delete
        /*********************************************************************************************************************/
        //
        protected void btn_del_Click(object sender, EventArgs e)
        {
            try
            {
                T_ITEM_LIST.delete(Request.QueryString["SEQ"].ToString(), Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

                string[] REMOVE = { "PAGE", "SEQ" };
                Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
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
