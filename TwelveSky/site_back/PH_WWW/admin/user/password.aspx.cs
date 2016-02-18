using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace _12sky2.admin.user
{
    public partial class password : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
            }
        }

        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            try
            {
                T_MBER.passwordChange2(UserID.Text, NewPassword.Text);

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('The information you have entered is not valid.\nPlease try again.');");
            }

        }
    }
}
