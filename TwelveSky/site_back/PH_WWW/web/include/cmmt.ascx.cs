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
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

using System.Collections.Generic;
using System.IO;

using System.Data.Common;

namespace _12sky2.web.include
{
    public partial class cmmt : System.Web.UI.UserControl
    {
        public string RELT_DIV = string.Empty;
        public string setRELT_DIV { set { RELT_DIV = value; } }

        public string RELT_SEQ = string.Empty;
        public string setRELT_SEQ { set { RELT_SEQ = value; } }

        webservice.T_CMMT T_CMMT = new webservice.T_CMMT();

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
        /* getList
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            is_cmmt.Visible = false;

            string USER_ID = null;
            if (SYS.is_login(this.Page))
            {
                USER_ID = Session["USER_ID"].ToString();
                CMMT_SAVE.Visible = true;
            }
            else
            {
                CMMT_SAVE.Visible = false;
            }

            if (!SYS.is_null(this.Page.Request.QueryString["DIV"])) RELT_DIV = this.Page.Request.QueryString["DIV"].ToString();
            if (!SYS.is_null(this.Page.Request.QueryString["SEQ"])) RELT_SEQ = this.Page.Request.QueryString["SEQ"].ToString();

            DataTable result = T_CMMT.getAllList(RELT_DIV, RELT_SEQ, USER_ID);

            LIST.DataSource = result;
            LIST.DataBind();

            if (result.Rows.Count > 0) is_cmmt.Visible = true;
        }

        /*********************************************************************************************************************/
        /* 저장
        /*********************************************************************************************************************/
        //
        protected void btn_reg_Click(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            try
            {
                if (!SYS.is_null(this.Page.Request.QueryString["DIV"])) RELT_DIV = this.Page.Request.QueryString["DIV"].ToString();
                if (!SYS.is_null(this.Page.Request.QueryString["SEQ"])) RELT_SEQ = this.Page.Request.QueryString["SEQ"].ToString();

                T_CMMT.insert(RELT_DIV, RELT_SEQ, CNTN.Text, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }

        /*********************************************************************************************************************/
        /* 저장
        /*********************************************************************************************************************/
        //
        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            for (int i = 0; i < LIST.Items.Count; i++)
            {
                HiddenField SEQ = (HiddenField)LIST.Items[i].FindControl("SEQ");
                HtmlControl cmmtEdit = (HtmlControl)LIST.Items[i].FindControl("cmmtEdit");
                HiddenField MODE = (HiddenField)LIST.Items[i].FindControl("MODE");
                TextBox tmpCNTN = (TextBox)LIST.Items[i].FindControl("CNTN");
                if (SEQ.Value.Equals(lnk.CommandName))
                {
                    cmmtEdit.Visible = false;
                }
            }
        }
        //
        protected void btn_reply_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            for (int i = 0; i < LIST.Items.Count; i++)
            {
                HiddenField SEQ = (HiddenField)LIST.Items[i].FindControl("SEQ");
                HtmlControl cmmtEdit = (HtmlControl)LIST.Items[i].FindControl("cmmtEdit");
                HiddenField MODE = (HiddenField)LIST.Items[i].FindControl("MODE");
                TextBox tmpCNTN = (TextBox)LIST.Items[i].FindControl("CNTN");
                if (SEQ.Value.Equals(lnk.CommandName))
                {
                    cmmtEdit.Visible = true;
                    MODE.Value = "REPLY";
                    tmpCNTN.Text = "";
                }
            }
        }
        //
        protected void btn_edit_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            DataTable info = T_CMMT.cmmtRead(lnk.CommandName);

            for (int i = 0; i < LIST.Items.Count; i++)
            {
                HtmlControl cmmtEdit = (HtmlControl)LIST.Items[i].FindControl("cmmtEdit");
                HiddenField MODE = (HiddenField)LIST.Items[i].FindControl("MODE");
                HiddenField SEQ = (HiddenField)LIST.Items[i].FindControl("SEQ");
                TextBox tmpCNTN = (TextBox)LIST.Items[i].FindControl("CNTN");
                if (SEQ.Value.Equals(lnk.CommandName))
                {
                    cmmtEdit.Visible = true;
                    MODE.Value = "EDIT";
                    SEQ.Value = info.Rows[0]["SEQ"].ToString();
                    tmpCNTN.Text = info.Rows[0]["CNTN"].ToString();
                }
            }
        }
        //
        protected void btn_del_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            try
            {
                T_CMMT.cmmtDelete(lnk.CommandName);
                getList();
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }

        /*********************************************************************************************************************/
        /* 저장
        /*********************************************************************************************************************/
        //
        protected void btn_cmmt_reg_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            try
            {
                for (int i = 0; i < LIST.Items.Count; i++)
                {
                    HiddenField SEQ = (HiddenField)LIST.Items[i].FindControl("SEQ");
                    HtmlControl cmmtEdit = (HtmlControl)LIST.Items[i].FindControl("cmmtEdit");
                    HiddenField MODE = (HiddenField)LIST.Items[i].FindControl("MODE");
                    TextBox tmpCNTN = (TextBox)LIST.Items[i].FindControl("CNTN");
                    if (SEQ.Value.Equals(lnk.CommandName))
                    {
                        switch (MODE.Value)
                        {
                            case "EDIT":
                                T_CMMT.cmmtUpdate(SEQ.Value, tmpCNTN.Text);
                                getList();
                                break;
                            case "REPLY":
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }
    }
}
