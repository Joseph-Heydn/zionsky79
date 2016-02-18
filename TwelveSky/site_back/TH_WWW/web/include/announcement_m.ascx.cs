using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.include
{
    public partial class announcement_m : System.Web.UI.UserControl
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

        private string DIV = "announcement";
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable result = T_NOTI_BORD.getTop5List(DIV, NAT_CD);

            for(int i=0; i<result.Rows.Count;i++)
            {
                DataTable fileList = T_FILE_INFO.getList(DIV, result.Rows[i]["SEQ"].ToString(), "FILE");

                for (int j = 0; j < fileList.Rows.Count; j++)
                {
                    if (fileList.Rows[j]["FILE_DIV"].ToString().Equals("FILE"))
                    {
                        switch (fileList.Rows[j]["FILE_TYP"].ToString().ToLower())
                        {
                            case ".png":
                            case ".jpg":
                            case ".gif":
                            case ".bmp":
                                result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "'/>";
                                break;
                        }
                    }
                }
            }

            LIST.DataSource = result;
            LIST.DataBind();
        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            LinkButton lnkBtn = (LinkButton)sender;
            Response.Redirect("/web/news/announcement_r.aspx?SEQ=" + lnkBtn.CommandName);
        }
    }
}