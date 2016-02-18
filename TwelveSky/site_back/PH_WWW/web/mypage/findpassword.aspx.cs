using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.mypage
{
    public partial class findpassword : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
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
                //recaptcha check
                if (!Page.IsValid)
                {
                    string[] REMOVE = { };
                    SYS.Javascript(this.Page, "location.href = '/web/mypage/findmessage_error.aspx';");
                }
                else
                {
                    if (T_MBER.findpassword(USER_ID.Text))
                    {
                        string[] REMOVE = { };
                        SYS.Javascript(this.Page, "location.href = '/web/mypage/findmessage_pw.aspx';");
                    }
                    else
                    {
                    }
                }
            }
            catch (Exception ex)
            {
                string[] REMOVE = { };
                SYS.Javascript(this.Page, "location.href = '/web/mypage/findmessage_error.aspx';");
            }

        }
    }
}
