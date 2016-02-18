using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.support
{
    public partial class read : System.Web.UI.Page
    {
        webservice.T_QUST T_QUST = new webservice.T_QUST();

        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {

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
                USER_NO.InnerHtml = info.Rows[0]["USER_NO"].ToString();
                USER_ID.InnerHtml = info.Rows[0]["USER_ID"].ToString();
                SCRT_EMAIL.InnerHtml = info.Rows[0]["SCRT_EMAIL"].ToString();

                DEAL_STAT_NM.InnerHtml = info.Rows[0]["DEAL_STAT_NM"].ToString();

                string stat = info.Rows[0]["DEAL_STAT"].ToString();
                if (stat.Equals("0")) { STAT1.Visible = true; }
                else { STAT1.Visible = false;}

                if (stat.Equals("1") || stat.Equals("2")) { 
                    STAT2.Visible = true; 
                    btn_save.Visible = true;

                    DEAL_STAT_SELECT.SelectedValue = info.Rows[0]["DEAL_STAT"].ToString();
                    DEAL_CNTN.Text = info.Rows[0]["DEAL_CNTN"].ToString();
                }
                else { STAT2.Visible = false; btn_save.Visible = false; }

                if (stat.Equals("3"))
                {
                    STAT3.Visible = true;
                    DEAL_CNTN2.InnerHtml = info.Rows[0]["DEAL_CNTN"].ToString();
                }
                else { STAT3.Visible = false; }

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
            LinkButton lnkBtn = (LinkButton)sender;
            string[] REMOVE = { "SEQ" };
            Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
        }

        /*********************************************************************************************************************/
        /* click
        /*********************************************************************************************************************/
        //
        protected void btn_ok_Click(object sender, EventArgs e)
        {
            try
            {
                T_QUST.updateStat1(Request.QueryString["SEQ"].ToString());

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                T_QUST.updateStat2(
                    Request.QueryString["SEQ"].ToString()
                    , Session["USER_ID"].ToString()
                    , Session["USER_NICK_NM"].ToString()
                    , DEAL_STAT_SELECT.SelectedValue
                    , DEAL_CNTN.Text);
              
                if(DEAL_STAT_SELECT.SelectedValue == "3")
                {
                    T_QUST.updateStat3(
                        Request.QueryString["SEQ"].ToString()
                        , Session["USER_ID"].ToString());
                }
                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }
        /*********************************************************************************************************************/
        /* delete
        /*********************************************************************************************************************/
        //
        protected void btn_del_Click(object sender, EventArgs e)
        {
            try
            {
                T_QUST.delete(Request.QueryString["SEQ"].ToString());

                string[] REMOVE = { "PAGE", "SEQ" };
                Response.Redirect(SYS.makeURL(this, "list.aspx", REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }
    }
}
