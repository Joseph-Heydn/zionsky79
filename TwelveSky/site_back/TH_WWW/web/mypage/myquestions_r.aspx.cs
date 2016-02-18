using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.web.mypage
{
    public partial class myquestions_r : System.Web.UI.Page
    {
        webservice.T_QUST T_QUST = new webservice.T_QUST();

        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                if (!SYS.is_login(this.Page))
                {
                    string[] REMOVE = { };
                    Response.Redirect(SYS.makeURL(this, "/", REMOVE));

                    return;
                }

                getRead();
            }
        }
        /*********************************************************************************************************************/
        /* getRead
        /*********************************************************************************************************************/
        //
        private void getRead()
        {
            try
            {
                DataTable info = T_QUST.getRead(Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                QUST_CD_1.InnerHtml = info.Rows[0]["QUST_CD_1_NM"].ToString();
                QUST_CD_2.InnerHtml = info.Rows[0]["QUST_CD_2_NM"].ToString();
                NICK_NM.InnerHtml = info.Rows[0]["NICK_NM"].ToString();
                DEAL_STAT_NM.InnerHtml = info.Rows[0]["DEAL_STAT_NM"].ToString();
                TITL.InnerHtml = info.Rows[0]["TITL"].ToString();
                CNTN.InnerHtml = info.Rows[0]["CNTN"].ToString();

                if (!SYS.is_null(info.Rows[0]["FILE_PATH_1"]))
                {
                    FILE1.Visible = true;
                    FILE_PATH_1.InnerHtml = "<a href='/resources/file/file.aspx?seq=" + info.Rows[0]["FILE_PATH_1"].ToString() + "'>" + info.Rows[0]["FILE_PATH_1_NM"].ToString() + "</a>";
                }
                if (!SYS.is_null(info.Rows[0]["FILE_PATH_2"]))
                {
                    FILE2.Visible = true;
                    FILE_PATH_2.InnerHtml = "<a href='/resources/file/file.aspx?seq=" + info.Rows[0]["FILE_PATH_2"].ToString() + "'>" + info.Rows[0]["FILE_PATH_2_NM"].ToString() + "</a>";
                }
                if (!SYS.is_null(info.Rows[0]["FILE_PATH_3"]))
                {
                    FILE3.Visible = true;
                    FILE_PATH_3.InnerHtml = "<a href='/resources/file/file.aspx?seq=" + info.Rows[0]["FILE_PATH_3"].ToString() + "'>" + info.Rows[0]["FILE_PATH_3_NM"].ToString() + "</a>";
                }
                if (!SYS.is_null(info.Rows[0]["FILE_PATH_4"]))
                {
                    FILE4.Visible = true;
                    FILE_PATH_4.InnerHtml = "<a href='/resources/file/file.aspx?seq=" + info.Rows[0]["FILE_PATH_4"].ToString() + "'>" + info.Rows[0]["FILE_PATH_4_NM"].ToString() + "</a>";
                }
                if (!SYS.is_null(info.Rows[0]["FILE_PATH_5"]))
                {
                    FILE5.Visible = true;
                    FILE_PATH_5.InnerHtml = "<a href='/resources/file/file.aspx?seq=" + info.Rows[0]["FILE_PATH_5"].ToString() + "'>" + info.Rows[0]["FILE_PATH_5_NM"].ToString() + "</a>";
                }

                string stat = info.Rows[0]["DEAL_STAT"].ToString();
                if (stat.Equals("2") || stat.Equals("3"))
                {
                    STAT3.Visible = true;
                    DEAL_CNTN2.InnerHtml = info.Rows[0]["DEAL_CNTN"].ToString();
                }
                else { STAT3.Visible = false; }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }

        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { "SEQ" };
            Response.Redirect(SYS.makeURL(this, "myquestions.aspx", REMOVE));
        }
    }
}
