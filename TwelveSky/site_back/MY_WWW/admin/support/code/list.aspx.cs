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


namespace _12sky2.admin.support.code
{
    public partial class list : System.Web.UI.Page
    {
        webservice.T_QUST_CD T_QUST_CD = new webservice.T_QUST_CD();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {

                getList();
            }
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            DataTable result = T_QUST_CD.getList("0", NAT_CD);

            LIST.DataSource = result;
            LIST.DataBind();

            if (result.Rows.Count == 0)
            {
                NO_LIST.Visible = true;
                NO_S_LIST.Visible = true;
            }
            else
            {
                NO_LIST.Visible = false;

                DataTable subResult = T_QUST_CD.getList(result.Rows[0]["CD_NO"].ToString(), NAT_CD);

                S_LIST.DataSource = subResult;
                S_LIST.DataBind();

                if (subResult.Rows.Count == 0) NO_S_LIST.Visible = true;
                else NO_S_LIST.Visible = false;
            }
        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            LinkButton lnkBtn = (LinkButton)sender;

            DataTable subResult = T_QUST_CD.getList(lnkBtn.CommandName, NAT_CD);

            S_LIST.DataSource = subResult;
            S_LIST.DataBind();

            if (subResult.Rows.Count == 0) NO_S_LIST.Visible = true;
            else NO_S_LIST.Visible = false;
        }
    }
}
