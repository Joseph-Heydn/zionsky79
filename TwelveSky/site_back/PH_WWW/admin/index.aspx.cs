using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.admin
{
    public partial class index : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();

        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SYS.is_admin(this.Page))
                {
                    Response.Redirect("/admin/main/main_image.aspx");
                }
            }
        }

        /*********************************************************************************************************************/
        /* login
        /*********************************************************************************************************************/
        //
        protected void btn_login_Click(object sender, EventArgs e)
        {
            if (SYS.is_null(ID.Text))
            {
                SYS.Javascript(this.Page, "alert('Enter to Id!');");
                ID.Focus();
                return;
            }

            if (SYS.is_null(PSWD.Text))
            {
                SYS.Javascript(this.Page, "alert('Enter to Password!');");
                PSWD.Focus();
                return;
            }


            if (T_MBER.login(ID.Text, PSWD.Text, NAT_CD))
            {
                if (!SYS.is_admin(this.Page))
                {
                    Response.Redirect("/");
                }

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, "/admin/main/main_image.aspx", REMOVE));
            }
            else
            {
                SYS.Javascript(this.Page, "alert('Failed to ID or Password!');");
                PSWD.Focus();
                return;
            }
        }
    }
}
