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

namespace _12sky2.admin.main
{
    public partial class main_image : System.Web.UI.Page
    {
        webservice.T_REPR_IMGE T_REPR_IMGE = new webservice.T_REPR_IMGE();
        webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

        private string NAT_CD = SYS.NAT_CD;
        private string DIV = "main";
        private static int totalCnt = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

                getList();
            }

            totalCnt = 1;
        }

        public string DATA_NUM()
        {
            return (totalCnt++).ToString();
        }

        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            try
            {
                DataTable result = T_REPR_IMGE.getList(DIV, NAT_CD);

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
                                    result.Rows[i]["IMG_SRC"] = "<img src='/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "' width='500' height='320'/>";
                                    break;
                            }
                        }
                    }
                }

                LIST.DataSource = result;
                LIST.DataBind();

                MODE.Value = "save";

            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }

        }
        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                if (MODE.Value == "save")
                {
                    T_REPR_IMGE.insert(DIV, _title.Value, _relt_link.Value, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), NAT_CD, _SORT_ORD.Value, FILE_SEQ.Value.Split(new char[] { ',' }));
                }
                else
                {
                    T_REPR_IMGE.update(DIV, SEQ.Value, _title.Value, _relt_link.Value, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString(), _SORT_ORD.Value, FILE_SEQ.Value.Split(new char[] { ',' }), DEL_FILE_SEQ.Value.Split(new char[] { ',' }));
                }

                MODE.Value = "save";

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }
        /*********************************************************************************************************************/
        /* edit
        /*********************************************************************************************************************/
        //
        protected void btn_edit_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;

            DataTable info = T_REPR_IMGE.getRead(lnk.CommandName);

            MODE.Value = "edit";
            SEQ.Value = lnk.CommandName;

            TITL.Text = info.Rows[0]["TITL"].ToString();
            RELT_LINK.Text = info.Rows[0]["RELT_LINK"].ToString();

            SORT_ORD.Text = info.Rows[0]["SORT_ORD"].ToString();

            DataTable fileInfo = T_FILE_INFO.getList(DIV, lnk.CommandName, "IMAGE");
            
            _fileList.Value = "";
            
            if (!fileInfo.Rows.Count.Equals(0))
            {
                for (int i = 0; i < fileInfo.Rows.Count; i++)
                {
                    if (i != 0)
                    {
                        _fileList.Value += ",";
                    }
                    _fileList.Value += fileInfo.Rows[i]["SEQ"].ToString();

                    EDIT_FILE_LIST.InnerHtml = "<div id='file_" + fileInfo.Rows[i]["SEQ"].ToString() + "'>";
                    EDIT_FILE_LIST.InnerHtml += "<div><img src='/resources/file/image.aspx?seq=" + fileInfo.Rows[i]["SEQ"].ToString() + "' width='300' /></div>";
                    EDIT_FILE_LIST.InnerHtml += "<div>[" + fileInfo.Rows[i]["FILE_DIV"].ToString() + "] ";
                    EDIT_FILE_LIST.InnerHtml += fileInfo.Rows[i]["FILE_LINK"].ToString();
                    EDIT_FILE_LIST.InnerHtml += " (" + fileInfo.Rows[i]["FILE_SIZE"].ToString() + "Mb) ";
                    EDIT_FILE_LIST.InnerHtml += " <a href='#' onclick='fileDelete(\"" + fileInfo.Rows[i]["SEQ"].ToString() + "\", \"" + fileInfo.Rows[i]["FILE_DIV"].ToString() + "\");'>delete</a>";
                    EDIT_FILE_LIST.InnerHtml += "</div></div>";
                }
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
                LinkButton lnk = (LinkButton)sender;

                T_REPR_IMGE.delete(lnk.CommandName, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

                string[] REMOVE = { };
                Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }
        }
    }
}
