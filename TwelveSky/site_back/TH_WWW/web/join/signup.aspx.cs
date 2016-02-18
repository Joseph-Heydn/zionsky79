using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.web.join
{
    public partial class signup : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

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
                //if (!Page.IsValid)
                //{
                //    string[] REMOVE = { };
                //    SYS.Javascript(this.Page, "location.href = '/web/join/signupfail.aspx';");
                //}
                //else
                //{
                    try
                    {
                        string EMAIL_RECV_YN = "N";
                        if (IsEmailChk.Checked) EMAIL_RECV_YN = "Y";
                        //T_MBER.insert(UserID.Text, Nickname.Text, Password.Text, "1", NAT_CD, SecurityEmail.Text, EMAIL_RECV_YN);
                        T_MBER.insert(UserID.Text, Nickname.Text, Password.Text, "2", NAT_CD, SecurityEmail.Text, EMAIL_RECV_YN);
                        string[] REMOVE = { };
                        SYS.Javascript(this.Page, "location.href = '/web/join/signupsuccess.aspx';");
                    }
                    catch (Exception ex)
                    {
                        //SYS.Save_Log(ex.ToString());
                    }

                //}
            }
            catch (Exception ex)
            {
                string[] REMOVE = { };
                SYS.Javascript(this.Page, "location.href = '/web/join/signupfail.aspx';");
            }

        }
    }
}
