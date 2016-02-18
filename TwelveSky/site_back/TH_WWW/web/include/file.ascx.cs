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
    public partial class file : System.Web.UI.UserControl
    {
        public string FILE_DIV = string.Empty;
        public string setFILE_DIV { set { FILE_DIV = value; } }

        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                if (!SYS.is_null(Request.QueryString["DIV"])) FILE_DIV = Request.QueryString["DIV"].ToString();
                Proc_Main();
            }
        }

        /*********************************************************************************************************************/
        /* 정보 불러오기
        /*********************************************************************************************************************/
        //
        private void Proc_Main()
        {
            try
            {
                //-------------------------------------------------
                // 첨부파일 정보
                //-------------------------------------------------
                DataTable fileList = T_FILE_INFO.getList(FILE_DIV, Request.QueryString["SEQ"].ToString(), "FILE");

                if (!fileList.Rows.Count.Equals(0))
                {
                    APND_FILE.Visible = true;
                    FILE_LIST.DataSource = fileList;
                    FILE_LIST.DataBind();
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this.Page);
            }
            finally
            {
            }
        }
    }
}