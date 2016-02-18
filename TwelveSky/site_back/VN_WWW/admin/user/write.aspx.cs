using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.admin.user
{
    public partial class write : System.Web.UI.Page
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
                string EMAIL_RECV_YN = "N";
                T_MBER.insert(UserID.Text, Nickname.Text, Password.Text, USE_AUTH.SelectedValue, NAT_CD, SecurityEmail.Text, EMAIL_RECV_YN);
                   
                string[] REMOVE = { };
                SYS.Javascript(this.Page, "location.href = '" + SYS.makeURL(this, "list.aspx", REMOVE) + "';");
            }
            catch (Exception ex)
            {
                SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }

        /*********************************************************************************************************************/
        /* list
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
        }
    }
}
