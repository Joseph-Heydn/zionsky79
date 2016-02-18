using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.shop
{
    public partial class vanity : System.Web.UI.Page
    {
        webservice.T_ITEM_LIST T_ITEM_LIST = new webservice.T_ITEM_LIST();
        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();
        private static int totalCnt = 0;
        private string NAT_CD = SYS.NAT_CD;
        private string DIV = "vanity";

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                if (SYS.is_login(this.Page))
                {
                    LEFT_MENU_LIST.Visible = true;
                }
                else
                {
                    LEFT_MENU_LIST.Visible = false;
                }

                getList();
            }
        }
        public string GETBILLURL()
        {
            return SYS.BILL_URL;
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            int tmpTotalCnt = T_ITEM_LIST.getTotalCnt(DIV, NAT_CD);

            UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, 5);
            tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * 5);
            totalCnt = tmpTotalCnt;

            DataTable result = T_ITEM_LIST.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

            for (int i = 0; i < result.Rows.Count; i++)
            {
                DataTable fileList = T_FILE_INFO.getList(DIV, result.Rows[i]["SEQ"].ToString(), "IMAGE");

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
    }
}
