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


namespace _12sky2.admin.user
{
    public partial class list : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        
        private static int totalCnt = 0;
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                if (!SYS.is_null(Request.QueryString["DIV"]))
                {
                    _USE_AUTH.SelectedValue = Request.QueryString["DIV"].ToString();
                }

                if (!SYS.is_null(Request.QueryString["SCH_TXT"]))
                {
                    SCH_TXT.Text = Request.QueryString["SCH_TXT"].ToString();
                }

                getList();
            }
        }
        /*********************************************************************************************************************/
        /* 선택시
        /*********************************************************************************************************************/
        //
        protected void _USE_AUTH_SelectedIndexChanged(object sender, EventArgs e)
        {
            //getList();
            string SCH = "?DIV=" + _USE_AUTH.SelectedValue;
            if (!SYS.is_null(SCH_TXT.Text))
            {
                if (!SYS.is_null(SCH)) SCH += "&";
                SCH += "SCH_TXT=" + SCH_TXT.Text;
            }

            Response.Redirect("list.aspx" + SCH);
        }
        /*********************************************************************************************************************/
        /* 검색
        /*********************************************************************************************************************/
        //
        protected void btn_search_Click(object sender, EventArgs e)
        {
            string SCH = "?DIV=" + _USE_AUTH.SelectedValue;
            if (!SYS.is_null(SCH_TXT.Text))
            {
                if (!SYS.is_null(SCH)) SCH += "&";
                SCH += "SCH_TXT=" + SCH_TXT.Text;
            }

            Response.Redirect("list.aspx" + SCH);
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            try
            {
                int tmpTotalCnt = T_MBER.getTotalCnt(NAT_CD, _USE_AUTH.SelectedValue, SCH_TXT.Text);

                UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
                tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * int.Parse(SYS.LIST_EA));
                totalCnt = tmpTotalCnt;

                DataTable result = T_MBER.getList(NAT_CD, _USE_AUTH.SelectedValue, int.Parse(NOW_PAGE.Text), SCH_TXT.Text);

                LIST.DataSource = result;
                LIST.DataBind();

                if (result.Rows.Count == 0) NO_LIST.Visible = true;
                else NO_LIST.Visible = false;

                if (SYS.is_login(this.Page)) btn_reg.Visible = true;
                else btn_reg.Visible = false;
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }

        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            LinkButton lnkBtn = (LinkButton)sender;
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "profile.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
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
