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


namespace _12sky2.admin.shop
{
    public partial class list : System.Web.UI.Page
    {
        webservice.T_ITEM_LIST T_ITEM_LIST = new webservice.T_ITEM_LIST();
        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();
        
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
            int tmpTotalCnt = T_ITEM_LIST.getTotalCnt(Request.QueryString["DIV"].ToString(), NAT_CD);

            UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, 5);
            tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * 5);
            totalCnt = tmpTotalCnt;

            DataTable result = T_ITEM_LIST.getList(Request.QueryString["DIV"].ToString(), NAT_CD, int.Parse(NOW_PAGE.Text));

            for (int i = 0; i < result.Rows.Count; i++)
            {
                DataTable fileList = T_FILE_INFO.getList(Request.QueryString["DIV"].ToString(), result.Rows[i]["SEQ"].ToString(), "IMAGE");

                for (int j = 0; j < fileList.Rows.Count; j++)
                {
                    if (fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE"))
                    {
                        switch (fileList.Rows[j]["FILE_TYP"].ToString().ToLower())
                        {
                            case ".png":
                            case ".jpg":
                            case ".gif":
                            case ".bmp":
                                result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "' width='50'/>";
                                break;
                        }
                    }
                }
            }
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
