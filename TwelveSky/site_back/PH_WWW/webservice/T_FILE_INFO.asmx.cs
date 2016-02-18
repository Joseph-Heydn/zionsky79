using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.Common;
using System.Configuration;
using System.IO;
using System.Data;

namespace _12sky2.webservice
{
    /// <summary>
    /// T_FILE_INFO의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_FILE_INFO : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* 첨부파일 목록
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getList(string RELT_DIV, string RELT_SEQ, string FILE_DIV)
        {
            DataTable result = new DataTable("DataTable");
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                tmpSQL = @"
-- " + this.ToString() + @" (getList)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        SELECT
                            A.SEQ
                            , A.RELT_DIV
                            , A.RELT_SEQ
                            , A.FILE_NM
                            , A.CHNG_NM
                            , CONVERT(VARCHAR, CONVERT(MONEY, ROUND(CONVERT(float, A.FILE_SIZE)/1024/1024, 2)), 1) as FILE_SIZE
                            , A.FILE_TYP
                            , A.FILE_DIV
                            , A.REG_ID
                            , CONVERT(VARCHAR(10), A.REG_DTM, 120) as REG_DTM
                            , A.UPDT_ID
                            , CONVERT(VARCHAR(10), A.UPDT_DTM, 120) as UPDT_DTM
                            , '<a href=""/resources/file/file.aspx?seq=' + CONVERT(VARCHAR, A.SEQ) + '"">' + A.FILE_NM + '</a>' as FILE_LINK
                        FROM T_FILE_INFO A
                        WHERE SEQ = SEQ ";

                if (!SYS.is_null(RELT_DIV))
                {
                    tmpSQL += " and RELT_DIV = '" + RELT_DIV + "'";
                }

                if (!SYS.is_null(RELT_SEQ))
                {
                    tmpSQL += " and RELT_SEQ = '" + RELT_SEQ + "'";
                }

                if (!SYS.is_null(FILE_DIV))
                {
                    tmpSQL += " and FILE_DIV = '" + FILE_DIV + "'";
                }

                command.CommandText = tmpSQL;

                adapter.SelectCommand = command;
                adapter.Fill(result);

                Trans.Commit();
            }
            catch (Exception ex)
            {
                Trans.Rollback();
                msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
                SYS.Save_Log(msg);
                throw SYS.Log(Context, ex);
            }
            finally
            {
                cnn.Close();
            }

            return result;
        }

        /*********************************************************************************************************************/
        /* 첨부파일 관계 맺기
        /*********************************************************************************************************************/
        //
        public Exception reltFile(int RELT_SEQ, string RELT_DIV, string[] SEQ)
        {
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                if (SYS.is_null(SEQ) || SEQ.Length == 0 || SYS.is_null(SEQ[0]))
                {
                    cnn.Close();
                    return null; // 첨부파일이 없으면 path
                }

                tmpSQL = @"
-- " + this.ToString() + @" (reltFile)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        UPDATE T_FILE_INFO set
                            RELT_SEQ = '" + RELT_SEQ + @"'
                            , RELT_DIV = '" + RELT_DIV + @"'
                        WHERE ";

                for (int i = 0; i < SEQ.Length; i++)
                {
                    if (i != 0) tmpSQL += " or ";
                    tmpSQL += " SEQ = '" + SEQ[i] + "'";
                }


                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                command.ExecuteNonQuery();

                tmpSQL = @"
-- " + this.ToString() + @" (fileSet)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        SELECT
                            *
                        FROM T_FILE_INFO
                        WHERE ";


                for (int i = 0; i < SEQ.Length; i++)
                {
                    if (i != 0) tmpSQL += " or ";
                    tmpSQL += " SEQ = '" + SEQ[i] + "'";
                }

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string savePath = ConfigurationSettings.AppSettings["PATH_DATA"] + "editor";

                    string file_name = reader["CHNG_NM"].ToString().Trim();

                    if (File.Exists(savePath + "/" + file_name))
                    {
                        FileInfo nowFile = new FileInfo(savePath + "/" + file_name);

                        if (!SYS.is_null(reader["RELT_SEQ"]))
                        {
                            string rePath = ConfigurationSettings.AppSettings["PATH_DATA"];

                            rePath += reader["RELT_DIV"].ToString().Trim();

                            if (!reader["RELT_SEQ"].ToString().Trim().Equals("0")) rePath += "/" + reader["RELT_SEQ"].ToString().Trim();

                            if (!Directory.Exists(rePath))
                            {
                                Directory.CreateDirectory(rePath);
                            }

                            if (File.Exists(rePath + "/" + file_name))
                            {
                                FileInfo delFile = new FileInfo(rePath + "/" + file_name);
                                delFile.Delete();
                            }

                            nowFile.MoveTo(rePath + "/" + file_name);
                        }
                    }
                }

                reader.Close();

                Trans.Commit();

                return null;
            }
            catch (Exception ex)
            {
                msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
                SYS.Save_Log(msg);

                throw ex;
            }
        }

        /*********************************************************************************************************************/
        /* 첨부파일 관계 맺기
        /*********************************************************************************************************************/
        public Exception reReltFile(int RELT_SEQ, string RELT_DIV, string[] SEQ)
        {
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                tmpSQL = @"
-- " + this.ToString() + @" (reReltFile)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        UPDATE T_FILE_INFO set RELT_SEQ = '' where RELT_SEQ = '" + RELT_SEQ + @"' and RELT_DIV = '" + RELT_DIV + @"'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                if (SYS.is_null(SEQ) || SEQ.Length == 0 || SYS.is_null(SEQ[0]))
                {
                    Trans.Commit();
                    cnn.Close();
                    return null; // 첨부파일이 없으면 path
                }

                tmpSQL = @"
-- " + this.ToString() + @" (reltFile)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        UPDATE T_FILE_INFO set
                            RELT_SEQ = '" + RELT_SEQ + @"', RELT_DIV = '" + RELT_DIV + @"'
                        WHERE ";

                for (int i = 0; i < SEQ.Length; i++)
                {
                    if (i != 0) tmpSQL += " or ";
                    tmpSQL += " SEQ = '" + SEQ[i] + "'";
                }


                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                tmpSQL = @"
-- " + this.ToString() + @" (fileSet)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        SELECT
                            *
                        FROM T_FILE_INFO
                        WHERE";


                for (int i = 0; i < SEQ.Length; i++)
                {
                    if (i != 0) tmpSQL += " or ";
                    tmpSQL += " SEQ = '" + SEQ[i] + "'";
                }

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string savePath = ConfigurationSettings.AppSettings["PATH_DATA"] + "editor";

                    string file_name = reader["CHNG_NM"].ToString().Trim();

                    if (File.Exists(savePath + "/" + file_name))
                    {
                        FileInfo nowFile = new FileInfo(savePath + "/" + file_name);

                        string rePath = ConfigurationSettings.AppSettings["PATH_DATA"];

                        rePath += reader["RELT_DIV"].ToString().Trim();

                        if (!reader["RELT_SEQ"].ToString().Trim().Equals("0")) rePath += "/" + reader["RELT_SEQ"].ToString().Trim();

                        if (!Directory.Exists(rePath))
                        {
                            Directory.CreateDirectory(rePath);
                        }

                        if (File.Exists(rePath + "/" + file_name))
                        {
                            FileInfo delFile = new FileInfo(rePath + "/" + file_name);
                            delFile.Delete();
                        }

                        nowFile.MoveTo(rePath + "/" + file_name);
                    }
                }

                reader.Close();

                Trans.Commit();

                return null;
            }
            catch (Exception ex)
            {
                msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
                SYS.Save_Log(msg);
                throw ex;
            }
        }

        /*********************************************************************************************************************/
        /* 첨부파일 삭제
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception delete(int RELT_SEQ, string[] SEQ)
        {
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                for (int i = 0; i < SEQ.Length; i++)
                {

                    tmpSQL = @"
    -- " + this.ToString() + @" (fileSet)--
    -- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
    -- ■ API          : " + Context.Request.Path + @" --

                            SELECT
                                *
                            FROM T_FILE_INFO
                            WHERE SEQ = '" + SEQ[i] + "'";

                    command.Parameters.Clear();
                    command.CommandText = tmpSQL;

                    DbDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string rePath = ConfigurationSettings.AppSettings["PATH_DATA"];
                        rePath += reader["RELT_DIV"].ToString().Trim() + "/" + RELT_SEQ.ToString().Trim();

                        string file_name = reader["CHNG_NM"].ToString().Trim();

                        if (File.Exists(rePath + "/" + file_name))
                        {
                            FileInfo delFile = new FileInfo(rePath + "/" + file_name);
                            delFile.Delete();
                        }
                    }

                    reader.Close();
                }

                for (int i = 0; i < SEQ.Length; i++)
                {
                    tmpSQL = @"
    -- " + this.ToString() + @" (delete)--
    -- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
    -- ■ API          : " + Context.Request.Path + @" --

                            DELETE FROM T_FILE_INFO WHERE SEQ = '" + SEQ[i] + "'";

                    command.Parameters.Clear();
                    command.CommandText = tmpSQL;
                    command.ExecuteNonQuery();
                }
                Trans.Commit();

                return null;
            }
            catch (Exception ex)
            {
                Trans.Rollback();
                msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
                SYS.Save_Log(msg);
                throw ex;
            }
            finally
            {
                cnn.Close();
            }
        }

        /*********************************************************************************************************************/
        /* 첨부파일 삭제
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception deleteAll(int RELT_SEQ)
        {
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {

                tmpSQL = @"
-- " + this.ToString() + @" (fileSet)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        SELECT
                            *
                        FROM T_FILE_INFO
                        WHERE RELT_SEQ = '" + RELT_SEQ + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string rePath = ConfigurationSettings.AppSettings["PATH_DATA"];
                    rePath += reader["RELT_DIV"].ToString().Trim() + "/" + RELT_SEQ.ToString().Trim();
                    if (File.Exists(rePath))
                    {
                        DirectoryInfo dir = new DirectoryInfo(rePath);
                        System.IO.FileInfo[] files = dir.GetFiles("*.*", SearchOption.AllDirectories);
                        foreach (System.IO.FileInfo file in files) file.Attributes = FileAttributes.Normal;
                        Directory.Delete(rePath, true);
                    }
                }

                reader.Close();

                tmpSQL = @"
-- " + this.ToString() + @" (delete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                        DELETE FROM T_FILE_INFO WHERE RELT_SEQ = '" + RELT_SEQ + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                Trans.Commit();

                return null;
            }
            catch (Exception ex)
            {
                Trans.Rollback();
                msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
                SYS.Save_Log(msg);
                throw ex;
            }
            finally
            {
                cnn.Close();
            }
        }
    }
}
