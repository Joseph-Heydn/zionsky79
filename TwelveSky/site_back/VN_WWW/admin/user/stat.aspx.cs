using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.user
{
    public partial class stat : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                STRT_DT.Text = System.DateTime.Now.ToShortDateString();
                END_DT.Text = System.DateTime.Now.ToShortDateString();

                getList();
            }
        }

        /*********************************************************************************************************************/
        /* 검색
        /*********************************************************************************************************************/
        //
        protected void btn_search_Click(object sender, EventArgs e)
        {
            getList();
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            try
            {
                DataTable result = T_MBER.getUserCount(STRT_DT.Text, END_DT.Text, NAT_CD);

                LIST.DataSource = result;
                LIST.DataBind();

                if (result.Rows.Count == 0) NO_LIST.Visible = true;
                else NO_LIST.Visible = false;
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }

        }
    }
}
