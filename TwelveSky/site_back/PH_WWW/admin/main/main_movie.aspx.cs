using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.main
{
    public partial class main_movie : System.Web.UI.Page
    {
        webservice.T_REPR_ANIM T_REPR_ANIM = new webservice.T_REPR_ANIM();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {

                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                getRead();
            }
        }
        /*********************************************************************************************************************/
        /* read
        /*********************************************************************************************************************/
        //
        private void getRead()
        {
            try
            {
                DataTable info = T_REPR_ANIM.getRead(NAT_CD);

                if (info.Rows.Count != 1)
                {
                    return;
                }

                SEQ.Value = info.Rows[0]["SEQ"].ToString();
                PATH.Text = info.Rows[0]["ANIM_PATH"].ToString();
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }

        }
        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                if (SYS.is_null(SEQ.Value))
                {
                    T_REPR_ANIM.insert("main movie", PATH.Text, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), NAT_CD);
                }
                else
                {
                    T_REPR_ANIM.update(SEQ.Value, PATH.Text, NAT_CD, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());
                }
                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }
    }
}
