using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.news
{
    public partial class notice : System.Web.UI.Page
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
        private static int totalCnt = 0;
        private string DIV = "notice";
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
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
            int tmpTotalCnt = T_NOTI_BORD.getTotalCnt(DIV, NAT_CD);

            UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
            tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * int.Parse(SYS.LIST_EA));
            totalCnt = tmpTotalCnt;

            DataTable result = T_NOTI_BORD.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

            LIST.DataSource = result;
            LIST.DataBind();

            if (result.Rows.Count == 0) NO_LIST.Visible = true;
            else NO_LIST.Visible = false;
        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            LinkButton lnkBtn = (LinkButton)sender;
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "notice_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
        }
    }
}
