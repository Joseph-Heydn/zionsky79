using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


namespace _12sky2.web.include
{
    public partial class head : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SYS.is_login(this.Page))
                {
                    TOP_MENU_LIST.Visible = true;
                }
                else
                {
                    TOP_MENU_LIST.Visible = false;
                }

                this.Page.Title = "TwelveSky2 WSP";
            }
        }
        public string GETBILLURL()
        {
            return SYS.BILL_URL;
        }
    }
}