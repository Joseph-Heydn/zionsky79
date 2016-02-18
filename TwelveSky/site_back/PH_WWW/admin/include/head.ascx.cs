using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.admin.include
{
    public partial class head : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SYS.is_login(this.Page))
            {
                if (!SYS.is_admin(this.Page))
                {
                    Response.Redirect("/");
                }                
            }
            else
            {
                Response.Redirect("/admin/");                
            }
            this.Page.Title = "TwelveSky2 WSP - Admin";
        }
    }
}