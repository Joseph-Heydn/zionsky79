using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.news
{
    public partial class announcement_r : System.Web.UI.Page
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
        private string DIV = "announcement";
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "SEQ" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                getRead();

                T_NOTI_BORD.updateHitCount(Request.QueryString["SEQ"].ToString());
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
                DataTable info = T_NOTI_BORD.getRead(DIV, NAT_CD, Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                TITL.InnerHtml = info.Rows[0]["TITL"].ToString();
                REG_NICK_NM.InnerHtml = info.Rows[0]["REG_NICK_NM"].ToString();
                REG_DT.InnerHtml = info.Rows[0]["REG_DT"].ToString();
                CNTN.InnerHtml = info.Rows[0]["CNTN"].ToString();
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }
        }
        /*********************************************************************************************************************/
        /* list
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { "SEQ" };
            Response.Redirect(SYS.makeURL(this, "announcement.aspx", REMOVE));
        }
    }
}
