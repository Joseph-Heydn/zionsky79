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
    /// T_REPR_IMGE의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_REPR_IMGE : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* total count
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public int getTotalCnt(string IMGE_DIV, string NAT_CD)
        {
            int ret = 0;
            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;

            try
            {
                tmpSQL = @"
-- " + this.ToString() + @" (getTotalCnt)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                                SELECT
                                    COUNT(SEQ)
                                FROM T_REPR_IMGE
                                WHERE DEL_YN = 'N' AND SEQ != 0                                
                                AND IMGE_DIV = '" + IMGE_DIV + @"'
                                AND NAT_CD = '" + NAT_CD + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    ret = int.Parse(reader[0].ToString());
                }
                reader.Close();
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

            return ret;
        }
        /*********************************************************************************************************************/
        /* list - main image
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getList(string IMGE_DIV, string NAT_CD)
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
                        SEQ
                        , IMGE_DIV
                        , TITL
                        , RELT_LINK
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                        , DEL_YN
                        , NAT_CD
                        , SORT_ORD
                        , '' AS IMG_SRC
                        , '' as CSS1, '' as CSS2
                    FROM T_REPR_IMGE
                    WHERE DEL_YN = 'N' AND SEQ <> 0
                    AND IMGE_DIV = '" + IMGE_DIV + @"'
                    AND NAT_CD = '" + NAT_CD + @"'
                    ORDER BY SORT_ORD ASC
                ";

                command.Parameters.Clear();
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
        /* read
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getRead(string SEQ)
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
-- " + this.ToString() + @" (getRead)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                SELECT
                    SEQ
                    , IMGE_DIV
                    , TITL
                    , RELT_LINK                            
                    , REG_ID
                    , REG_NICK_NM
                    , REG_DTM                            
                    , UPDT_ID
                    , UPDT_NICK_NM
                    , UPDT_DTM
                    , DEL_YN
                    , NAT_CD
                    , SORT_ORD
                FROM T_REPR_IMGE
                WHERE DEL_YN = 'N'
                AND SEQ = '" + SEQ + @"'
                ";

                command.Parameters.Clear();
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
        /* insert
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception insert(string IMGE_DIV, string TITL, string RELT_LINK, string USER_ID, string USER_NICK_NM, string NAT_CD, string SORT_ORD, string[] FILE_SEQ)
        {
            webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

            string tmpSQL = null, msg = null;
            int NOW_SEQ = 0;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;


            try
            {
                if (!SYS.is_null(SORT_ORD))
                {
                    tmpSQL = @"
-- " + this.ToString() + @" (update order +)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        SORT_ORD = SORT_ORD + 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND IMGE_DIV = '" + IMGE_DIV + @"'
                    AND SEQ <> 0
                    AND SORT_ORD >= " + SORT_ORD + @"";

                    command.Parameters.Clear();
                    command.CommandText = tmpSQL;
                    command.ExecuteNonQuery();
                }
                tmpSQL = @"
-- " + this.ToString() + @" (NEXT SEQ)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                            SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_REPR_IMGE
                            ";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                DbDataReader reader = command.ExecuteReader();
                if (!reader.HasRows) throw new System.Exception(); //다음 SEQ를 가져오지 못함
                if (reader.Read())
                {
                    NOW_SEQ = int.Parse(reader[0].ToString());
                }
                reader.Close();

                tmpSQL = @"
-- " + this.ToString() + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    INSERT INTO T_REPR_IMGE
                    (
                        SEQ
                        , IMGE_DIV
                        , TITL
                        , RELT_LINK
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                        , DEL_YN
                        , NAT_CD
                        , SORT_ORD
                    )
                    VALUES
                    (
                        " + NOW_SEQ + @"
                        , '" + SYS.nullToSpace(IMGE_DIV) + @"'
                        , @TITL
                        , @RELT_LINK                       
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , 'N'
                        , '" + SYS.nullToSpace(NAT_CD) + @"'
                        , '" + SYS.nullToSpace(SORT_ORD) + @"'
                    )";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@TITL", SYS.nullToSpace(TITL));
                connect.CreateParameter(command, "@RELT_LINK", SYS.nullToSpace(RELT_LINK));

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

                command.ExecuteNonQuery();

                T_FILE_INFO.reltFile(NOW_SEQ, IMGE_DIV, FILE_SEQ);

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
        /* update
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception update(string IMGE_DIV, string SEQ, string TITL, string RELT_LINK, string USER_ID, string USER_NICK_NM, string SORT_ORD, string[] FILE_SEQ, string[] DEL_FILE_SEQ)
        {
            webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

            string tmpSQL = null, msg = null;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;


            try
            {
                if (!SYS.is_null(SORT_ORD))
                {
                    tmpSQL = @"
-- " + this.ToString() + @" (update order -)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        SORT_ORD = SORT_ORD - 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND IMGE_DIV = '" + IMGE_DIV + @"'
                    AND SEQ <> 0
                    AND SORT_ORD > (SELECT SORT_ORD FROM T_REPR_IMGE WHERE SEQ = " + SEQ + @")
                    AND SORT_ORD <= " + SORT_ORD + "";

                    command.Parameters.Clear();
                    command.CommandText = tmpSQL;
                    command.ExecuteNonQuery();


                    tmpSQL = @"
-- " + this.ToString() + @" (update order +)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        SORT_ORD = SORT_ORD + 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND IMGE_DIV = '" + IMGE_DIV + @"'
                    AND SEQ <> 0
                    AND SORT_ORD >= " + SORT_ORD + @"
                    AND SORT_ORD < (SELECT SORT_ORD FROM T_REPR_IMGE WHERE SEQ = " + SEQ + @")";

                    command.Parameters.Clear();
                    command.CommandText = tmpSQL;
                    command.ExecuteNonQuery();
                }

                tmpSQL = @"
-- " + this.ToString() + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        TITL = @TITL
                        , RELT_LINK = @RELT_LINK
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                        , SORT_ORD = '" + SYS.nullToSpace(SORT_ORD) + @"'
                    WHERE DEL_YN = 'N'
                    AND IMGE_DIV = '" + IMGE_DIV + @"'
                    AND SEQ = '" + SEQ + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@TITL", SYS.nullToSpace(TITL));
                connect.CreateParameter(command, "@RELT_LINK", SYS.nullToSpace(RELT_LINK));

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

                command.ExecuteNonQuery();

                T_FILE_INFO.reReltFile(int.Parse(SEQ), IMGE_DIV, FILE_SEQ);
                T_FILE_INFO.delete(int.Parse(SEQ), DEL_FILE_SEQ);

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
        /* delete
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception delete(string SEQ, string USER_ID, string USER_NICK_NM)
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
-- " + this.ToString() + @" (update order -)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        SORT_ORD = SORT_ORD - 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND IMGE_DIV = (SELECT IMGE_DIV FROM T_REPR_IMGE WHERE SEQ = " + SEQ + @")
                    AND SEQ <> 0
                    AND SORT_ORD > (SELECT SORT_ORD FROM T_REPR_IMGE WHERE SEQ = " + SEQ + @")";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                tmpSQL = @"
-- " + this.ToString() + @" (delete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        DEL_YN = 'Y'
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE SEQ = '" + SEQ + "'";

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
