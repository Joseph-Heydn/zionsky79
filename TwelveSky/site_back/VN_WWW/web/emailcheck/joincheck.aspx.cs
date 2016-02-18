using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.emailCheck
{
    public partial class joincheck : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!SYS.is_null(Request.QueryString["CheckCode"]))
                {
                    getRead();
                }
                else
                {
                    S.Visible = false;
                    F.Visible = true;
                }
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
                string USER_ID = SYS.Base64Decode(Request.QueryString["CheckCode"].ToString());
                DataTable info = T_MBER.getRead(USER_ID);

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                string USE_AUTH = info.Rows[0]["USE_AUTH"].ToString();
                string REG_DTM = info.Rows[0]["REG_DTM"].ToString();
                string nowdate= DateTime.Now.ToShortDateString();
                DateTime T1 = DateTime.Parse(REG_DTM);
                DateTime T2 = DateTime.Parse(nowdate);
                TimeSpan TS = T2 - T1;
                int diffDay = TS.Days;

                if (USE_AUTH.Equals("1"))
                {
                    if (diffDay > 1)
                    {
                        //return;
                    }

                    T_MBER.joinCheck(USER_ID);

                    S.Visible = true;
                    F.Visible = false;
                    //Response.Redirect("/");
                }
                else
                {
                    S.Visible = false;
                    F.Visible = true;
                    //Response.Redirect("/");
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }
        }
    }
}
