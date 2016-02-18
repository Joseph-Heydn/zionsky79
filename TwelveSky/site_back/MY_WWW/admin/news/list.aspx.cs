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


namespace _12sky2.admin.news
{
    public partial class list : System.Web.UI.Page
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
        
        private static int totalCnt = 0;
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "DIV" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                admin_left.setSUB_TITL = Request.QueryString["DIV"].ToString();

                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                getList();
            }
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            int tmpTotalCnt = T_NOTI_BORD.getTotalCnt(Request.QueryString["DIV"].ToString(), NAT_CD);

            UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
            tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * int.Parse(SYS.LIST_EA));
            totalCnt = tmpTotalCnt;

            DataTable result = T_NOTI_BORD.getList(Request.QueryString["DIV"].ToString(), NAT_CD, int.Parse(NOW_PAGE.Text));

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
            Response.Redirect(SYS.makeURL(this, "read.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
        }
        /*********************************************************************************************************************/
        /* data write
        /*********************************************************************************************************************/
        //
        protected void btn_reg_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "write.aspx", REMOVE));
        }
    }
}
