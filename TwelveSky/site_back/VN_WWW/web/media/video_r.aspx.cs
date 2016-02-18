using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.media
{
    public partial class video_r : System.Web.UI.Page
    {
        webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();

        private string NAT_CD = SYS.NAT_CD;
        private string DIV = "video";

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "SEQ" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                left.setSUB_TITL = DIV;

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
                DataTable info = T_MEDIA_BORD.getRead(DIV, NAT_CD, Request.QueryString["SEQ"].ToString());

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

                string path = info.Rows[0]["PATH"].ToString();
                string movie_id = path.Substring(path.LastIndexOf('/'));
                CNTN.InnerHtml += "<iframe width='560' height='350' src='https://www.youtube.com/embed" + movie_id + "' frameborder='0' allowfullscreen></iframe>";

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
            Response.Redirect(SYS.makeURL(this, "video_e.aspx", REMOVE));
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
                Response.Redirect(SYS.makeURL(this, "video.aspx", REMOVE));
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
            Response.Redirect(SYS.makeURL(this, "video.aspx", REMOVE));
        }
        
    }
}
