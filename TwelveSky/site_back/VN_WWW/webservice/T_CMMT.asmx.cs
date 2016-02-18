using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.Common;
using System.Configuration;
using System.Data;

namespace _12sky2.webservice
{
    /// <summary>
    /// T_CMMT의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_CMMT : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* 코멘트 전체목록
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getAllList(string RELT_DIV, string RELT_SEQ, string USER_ID)
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
-- " + this.ToString() + @" (getAllList)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                                SELECT
                                    A.SEQ
                                    , A.RELT_DIV
                                    , A.RELT_SEQ
                                    , A.CNTN
                                    , A.REG_ID
                                    , A.REG_NICK_NM
                                    , A.REG_DTM
                                    , A.UPDT_ID
                                    , A.UPDT_NICK_NM
                                    , A.UPDT_DTM
                                ";

                if (!SYS.is_null(USER_ID))
                {
                    tmpSQL += @",CASE 
                                    WHEN A.REG_ID = '" + USER_ID + @"'
                                    THEN 'true'
                                    ELSE 'false'
                                END AS ADMN
                                ";
                }
                else
                {
                    tmpSQL += @",'false' AS ADMN
                                ";
                }
                    tmpSQL += @"FROM T_CMMT A
                                WHERE A.RELT_DIV = @RELT_DIV
                                AND A.RELT_SEQ = @RELT_SEQ                                
                                ORDER BY REG_DTM DESC";

                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@RELT_DIV", RELT_DIV);
                connect.CreateParameter(command, "@RELT_SEQ", RELT_SEQ);

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

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
        /* insert
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception insert(string RELT_DIV, string RELT_SEQ, string CNTN, string USER_ID, string USER_NICK_NM)
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
-- " + this.ToString() + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    INSERT INTO T_CMMT
                    (
                        SEQ
                        , RELT_DIV
                        , RELT_SEQ
                        , CNTN
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                    )
                    VALUES
                    (
                        (SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_CMMT)
                        , '" + SYS.nullToSpace(RELT_DIV) + @"'
                        , '" + SYS.nullToSpace(RELT_SEQ) + @"'
                        , @CNTN                       
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                    )";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@CNTN", SYS.nullToSpace(CNTN));

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

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
        /*********************************************************************************************************************/
        /* 코멘트 읽기
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable cmmtRead(string SEQ)
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
-- " + this.ToString() + @" (cmmtRead)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                                SELECT
                                    A.SEQ
                                    , A.RELT_DIV
                                    , A.RELT_SEQ
                                    , CNTN
                                    , REG_ID
                                    , REG_NICK_NM
                                    , REG_DTM
                                    , UPDT_ID
                                    , UPDT_NICK_NM
                                    , UPDT_DTM
                                FROM T_CMMT A
                                WHERE A.SEQ = @SEQ";

                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@SEQ", SEQ);

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

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
        /* 코멘트 수정
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception cmmtUpdate(string SEQ, string CNTN)
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
-- " + this.ToString() + @" (cmmtDelete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                            UPDATE T_CMMT SET
                                CNTN = @CNTN
                                , UPDT_DTM = GETDATE()
                            WHERE SEQ = @SEQ";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@SEQ", SEQ);
                connect.CreateParameter(command, "@CNTN", CNTN);

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
        /*********************************************************************************************************************/
        /* 코멘트 삭제
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception cmmtDelete(string SEQ)
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
-- " + this.ToString() + @" (cmmtDelete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                            DELETE FROM T_CMMT WHERE SEQ = @SEQ";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@SEQ", SEQ);

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
