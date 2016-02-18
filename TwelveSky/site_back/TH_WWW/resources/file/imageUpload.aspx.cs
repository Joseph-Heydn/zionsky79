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

namespace _12sky2.resources.file
{
    public partial class imageUpload : System.Web.UI.Page
    {
        private string F_FILE_NM = null;
        private string F_FILE_SIZE = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;
        }

        protected void imageSelect_Click(object sender, EventArgs e)
        {
            string seq = "";

            if (imageFile.PostedFile.ContentLength > 0)
            {
                seq = imageSave(imageFile.PostedFile);
            }
            else
            {
                return;
            }

            Image1.Visible = true;

            Image1.ImageUrl = "/resources/file/image.aspx?seq=" + seq;

            string Javascript = @"setImg(
                                    '" + seq + @"',
                                    '/resources/file/image.aspx?seq=" + seq + @"', " +
                                    @"'" + F_FILE_NM + @"', " +
                                    @"'" + F_FILE_SIZE + "', " + @"
                                    '/resources/file/image.aspx?seq=" + seq + @"', 
                                    '/resources/file/image.aspx?seq=" + seq + @"');";

            SYS.Javascript(this.Page, Javascript);
        }

        private string imageSave(HttpPostedFile tmpFile)
        {

            string seq = null;

            FileInfo nowFile = null;

            try
            {
                string savePath = ConfigurationSettings.AppSettings["PATH_DATA"] + "editor"; // 저장경로

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

                    seq = insertDB("IMAGE", FILE_NM, CHNG_NM, FILE_TYP, tmpFile.ContentLength);

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

        private string insertDB(string FILE_DIV, string FILE_NM, string CHNG_NM, string FILE_TYP, int FILE_SIZE)
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
                            (SEQ, FILE_NM, CHNG_NM, FILE_SIZE, FILE_TYP, FILE_DIV, REG_ID, REG_DTM) 
                        VALUES
                            (" + SEQ + ", '" + FILE_NM + "', '" + CHNG_NM + "', '" + FILE_SIZE + "', '" + FILE_TYP + "', '" + FILE_DIV + "', '" + USER_ID + "', GETDATE())";

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
