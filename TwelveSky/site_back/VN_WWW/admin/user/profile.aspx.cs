using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Configuration;
using System.Data.Common;

namespace _12sky2.admin.user
{
    public partial class profile : System.Web.UI.Page
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();
        private string NAT_CD = SYS.NAT_CD;

        private string F_FILE_NM = null;
        private string F_FILE_SIZE = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { "SEQ" };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                for (int i = 1940; i <= System.DateTime.Now.Year; i++)
                {
                    if (i == 1940)
                    {
                        ListItem item1 = new ListItem();
                        item1.Value = "";
                        item1.Text = "-";
                        YYYY.Items.Add(item1);
                    }

                    ListItem item = new ListItem();
                    item.Value = i.ToString();
                    item.Text = i.ToString();
                    YYYY.Items.Add(item);
                }
                for (int i = 1; i <= 12; i++)
                {
                    if (i == 1)
                    {
                        ListItem item1 = new ListItem();
                        item1.Value = "";
                        item1.Text = "-";
                        MM.Items.Add(item1);
                    }

                    ListItem item = new ListItem();
                    if (i < 10)
                    {
                        item.Value = "0" + i.ToString();
                    }
                    else
                    {
                        item.Value = i.ToString();
                    }                    
                    item.Text = i.ToString();
                    MM.Items.Add(item);
                }
                for (int i = 1; i <= 31; i++)
                {
                    if (i == 1)
                    {
                        ListItem item1 = new ListItem();
                        item1.Value = "";
                        item1.Text = "-";
                        DD.Items.Add(item1);
                    }

                    ListItem item = new ListItem();
                    if (i < 10)
                    {
                        item.Value = "0" + i.ToString();
                    }
                    else
                    {
                        item.Value = i.ToString();
                    }
                    item.Text = i.ToString();
                    DD.Items.Add(item);
                }
                
                NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
                PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

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
                DataTable info = T_MBER.getRead(Request.QueryString["SEQ"].ToString());

                if (info.Rows.Count != 1)
                {
                    SYS.errScript(this);
                    return;
                }

                if (!SYS.is_null(info.Rows[0]["REPR_IMGE_PATH"])) 
                { 
                    REPR_IMGE_PATH.InnerHtml = "<img src='" + info.Rows[0]["REPR_IMGE_PATH"].ToString() + "' alt=''/>";
                    FILE_PATH.Value = info.Rows[0]["REPR_IMGE_PATH"].ToString();
                }
                else { REPR_IMGE_PATH.InnerHtml = "<img src='/resources/images/con_img/my/profile.jpg' alt='' />"; }

                if (!SYS.is_null(info.Rows[0]["NICK_NM"])) NICK_NM.Text = info.Rows[0]["NICK_NM"].ToString();
                if (!SYS.is_null(info.Rows[0]["SEX"])) SEX.SelectedValue = info.Rows[0]["SEX"].ToString();

                if (!SYS.is_null(info.Rows[0]["BRDD"]))
                {
                    YYYY.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(0, 4);
                    MM.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(4, 2);
                    DD.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(6, 2);
                }

                if (!SYS.is_null(info.Rows[0]["EMAIL_RECV_YN"]))
                {
                    if (info.Rows[0]["EMAIL_RECV_YN"].ToString().Trim().Equals("Y"))
                    {
                        EMAIL_RECV_YN.Checked = true;
                    }
                    else
                    {
                        EMAIL_RECV_YN.Checked = false;
                    }
                }

                USE_AUTH.SelectedValue = info.Rows[0]["USE_AUTH"].ToString();
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }
        }

        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                string _EMAIL_RECV_YN = "N";
                if(EMAIL_RECV_YN.Checked) _EMAIL_RECV_YN = "Y";

                if (DEL_IMG.Checked) FILE_PATH.Value = null;

                T_MBER.updateMberInfo(YYYY.SelectedValue + MM.SelectedValue + DD.SelectedValue
                    , SEX.SelectedValue
                    , _EMAIL_RECV_YN
                    , FILE_PATH.Value
                    , Request.QueryString["SEQ"].ToString()
                    , USE_AUTH.SelectedValue);

                string[] REMOVE = { "SEQ" };
                Response.Redirect(SYS.makeURL(this.Page, "list.aspx", REMOVE));
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }
        /*********************************************************************************************************************/
        /* list
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {

            string[] REMOVE = { "SEQ" };
            Response.Redirect(SYS.makeURL(this.Page, "list.aspx", REMOVE));
        }

        /*********************************************************************************************************************/
        /* image
        /*********************************************************************************************************************/
        //
        protected void imageSelect_Click(object sender, EventArgs e)
        {
            string seq = "";

            if (imageFile.PostedFile.ContentLength > 0)
            {
                seq = imageSave(imageFile.PostedFile, "userimage");
            }
            else
            {
                return;
            }

            REPR_IMGE_PATH.InnerHtml = "<img src='/resources/file/image.aspx?seq=" + seq + "' alt=''/>";
            FILE_PATH.Value = "/resources/file/image.aspx?seq=" + seq;
        }

        private string imageSave(HttpPostedFile tmpFile, string folder)
        {

            string seq = null;

            FileInfo nowFile = null;

            try
            {
                string savePath = ConfigurationSettings.AppSettings["PATH_DATA"] + folder; // 저장경로

                string fileExeName = null, FILE_NM = null, CHNG_NM = null, FILE_TYP = null;
                FILE_NM = tmpFile.FileName.Substring(tmpFile.FileName.LastIndexOf("\\") + 1);

                FILE_TYP = System.IO.Path.GetExtension(FILE_NM);

                if (tmpFile.ContentLength > 0)
                {
                    if (!Directory.Exists(savePath))
                    {
                        Directory.CreateDirectory(savePath);
                    }

                    string tmpFilePath = savePath + "/" + FILE_NM;
                    System.IO.FileInfo fileInfo = new System.IO.FileInfo(tmpFilePath);

                    CHNG_NM = fileInfo.Name;

                    bool bExist = fileInfo.Exists;
                    int nNumbering = 1;

                    int indexDot = CHNG_NM.LastIndexOf(".");
                    if (indexDot != -1)
                    {
                        fileExeName = CHNG_NM.Substring(0, indexDot);
                    }

                    while (bExist)
                    {
                        string newName = fileExeName + "_reName(" + nNumbering + ")";
                        tmpFilePath = fileInfo.DirectoryName + "\\" + newName + fileInfo.Extension;
                        CHNG_NM = newName + fileInfo.Extension;
                        bExist = File.Exists(tmpFilePath);
                        nNumbering++;
                    }

                    tmpFile.SaveAs(tmpFilePath);

                    nowFile = new FileInfo(tmpFilePath);

                    seq = insertDB(folder, "IMAGE", FILE_NM, CHNG_NM, FILE_TYP, tmpFile.ContentLength);

                    F_FILE_NM = FILE_NM;
                    F_FILE_SIZE = tmpFile.ContentLength.ToString();
                }
            }
            catch (Exception err)
            {
                nowFile.Delete();
                SYS.Save_Log("[에디터 image 처리 실패] " + err.Message);
                return seq;
            }

            return seq;
        }

        private string insertDB(string RELT_DIV, string FILE_DIV, string FILE_NM, string CHNG_NM, string FILE_TYP, int FILE_SIZE)
        {
            string USER_ID = Session["USER_ID"].ToString();
            string tmpSQL = null, SEQ = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                tmpSQL = @"SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_FILE_INFO";

                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    SEQ = reader[0].ToString();
                }
                reader.Close();

                tmpSQL = @"
                        INSERT INTO T_FILE_INFO
                            (SEQ, RELT_DIV, RELT_SEQ, FILE_NM, CHNG_NM, FILE_SIZE, FILE_TYP, FILE_DIV, REG_ID, REG_DTM) 
                        VALUES
                            (" + SEQ + ", '" + RELT_DIV + "', 0,N'" + FILE_NM + "', N'" + CHNG_NM + "', '" + FILE_SIZE + "', '" + FILE_TYP + "', '" + FILE_DIV + "', '" + USER_ID + "', GETDATE())";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();
                Trans.Commit();
            }
            catch (DataException err)
            {
                Trans.Rollback();
                SYS.Save_Log(@"[" + Request.Path + " 에디터 data 처리후 insert 오류]" + @"
tmpSQL     : " + tmpSQL + @"
FILE_NM    : " + FILE_NM + @"
CHNG_NM      : " + CHNG_NM + @"
FILE_TYP   : " + FILE_TYP + @"
FILE_SIZE  : " + FILE_SIZE + @"
error          : " + err.Message);
                SEQ = null;
            }
            finally
            {
                cnn.Close();
            }

            return SEQ;
        }
    }
}
