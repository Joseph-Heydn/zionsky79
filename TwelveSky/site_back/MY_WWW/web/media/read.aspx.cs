using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.media
{
    public partial class read : System.Web.UI.Page
    {
        webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();
        webservice.T_LIKE T_LIKE = new webservice.T_LIKE();

        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "DIV", "SEQ" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                left.setSUB_TITL = Request.QueryString["DIV"].ToString();

                NAV_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(left.TITL, left.SUB_TITL);

                getRead();

                T_MEDIA_BORD.updateHitCount(Request.QueryString["SEQ"].ToString());
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
                DataTable info = T_MEDIA_BORD.getRead(Request.QueryString["DIV"].ToString(), NAT_CD, Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                TITL.InnerHtml = info.Rows[0]["TITL"].ToString();
                REG_NICK_NM.InnerHtml = info.Rows[0]["REG_NICK_NM"].ToString();
                REG_DT.InnerHtml = info.Rows[0]["REG_DT"].ToString();
                HIT_CNT.InnerHtml = info.Rows[0]["HIT_CNT"].ToString();
                CNTN.InnerHtml = info.Rows[0]["CNTN"].ToString();

                if (SYS.is_login(this.Page))
                {
                    if (info.Rows[0]["REG_ID"].ToString().Equals(Session["USER_ID"].ToString()))
                    {
                        btn_edit.Visible = true;
                        btn_del.Visible = true;
                    }
                    else
                    {
                        btn_edit.Visible = false;
                        btn_del.Visible = false;
                    }
                }
                else
                {
                    btn_edit.Visible = false;
                    btn_del.Visible = false;
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
                T_MEDIA_BORD.delete(Request.QueryString["SEQ"].ToString(), Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

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
