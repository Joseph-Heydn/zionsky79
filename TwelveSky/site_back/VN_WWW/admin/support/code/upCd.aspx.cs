using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _12sky2.admin.support.code
{
    public partial class upCd : System.Web.UI.Page
    {
        webservice.T_QUST_CD T_QUST_CD = new webservice.T_QUST_CD();
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
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                T_QUST_CD.insert(CD_NM.Text, "0", Session["USER_ID"].ToString(), NAT_CD);

                string[] REMOVE = { };
                SYS.Javascript(this.Page, "if(opener) {opener.location.reload();}self.close();");
            }
            catch (Exception ex)
            {
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }
    }
}
