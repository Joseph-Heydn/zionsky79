using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace _12sky2.web.mypage
{
    public partial class withdrawal : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                if (!SYS.is_login(this.Page))
                {
                    string[] REMOVE = { };
                    Response.Redirect(SYS.makeURL(this, "/", REMOVE));

                    return;
                }
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
                    SYS.Javascript(this.Page, "alert('The information you have entered is not valid.\nPlease try again.');");
                }
                else
                {
                    T_MBER.memberWithdrawal(UserID.Text, Password.Text);

                    FormsAuthentication.SignOut();
                    Session.Clear();
                    Session.Abandon();

                    if (Request.Cookies["tmpUSER"] != null)
                    {
                        HttpCookie myCookie = new HttpCookie("tmpUSER");
                        myCookie.Expires = DateTime.Now.AddDays(-1d);
                        Response.Cookies.Add(myCookie);
                    }

                    string[] REMOVE = { };
                    SYS.Javascript(this.Page, "location.href = '/';");
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('The information you have entered is not valid.\nPlease try again.');");
            }

        }
    }
}
