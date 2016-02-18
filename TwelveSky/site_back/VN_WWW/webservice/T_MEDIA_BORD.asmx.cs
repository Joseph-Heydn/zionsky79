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
    /// T_MEDIA_BORD의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_MEDIA_BORD : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* total count
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public int getTotalCnt(string BORD_DIV, string NAT_CD)
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
                                FROM T_MEDIA_BORD
                                WHERE DEL_YN = 'N'
                                AND BORD_DIV = '" + BORD_DIV + @"'
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
        /* list
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getList(string BORD_DIV, string NAT_CD, int NOW_PAGE)
        {
            DataTable result = new DataTable("DataTable");
            string tmpSQL = null, msg = null;

            int LIST_CNT = int.Parse(SYS.LIST_EA);

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

                SELECT *
                FROM
                (
                    SELECT 
                        A.*
                        , ((ROWNO + " + LIST_CNT + " - 1)  / " + LIST_CNT + @") as PAGE
                    FROM
                    (
                        SELECT
                            SEQ
                            , BORD_DIV
                            , TITL
                            , CNTN
                            , HIT_CNT                            
                            , REG_ID
                            , REG_NICK_NM
                            , REG_DTM                            
                            , UPDT_ID
                            , UPDT_NICK_NM
                            , UPDT_DTM
                            , DEL_YN
                            , TOP_POST_YN
                            , NAT_CD
                            , PATH
                            , CONVERT(VARCHAR(10), REG_DTM, 120) as REG_DT
                            , CONVERT(VARCHAR(10), UPDT_DTM, 120) as UPDT_DT
                            , row_number() over(order by SEQ desc) as ROWNO
                            , row_number() over(order by SEQ asc) as ROWNUM
                            , CASE 
		                        WHEN LEN(TITL) > 30
		                        THEN SUBSTRING(TITL, 0, 30) + '...'
		                        ELSE TITL
	                        END AS TITL2
                            , '' as IMG_SRC
                            , CASE 
                                WHEN (SELECT COUNT(SEQ) FROM T_CMMT WHERE RELT_DIV = A.BORD_DIV AND RELT_SEQ = A.SEQ) > 0
                                THEN ' (' + CONVERT(VARCHAR, (SELECT COUNT(SEQ) FROM T_CMMT WHERE RELT_DIV = A.BORD_DIV AND RELT_SEQ = A.SEQ)) + ')'
                                ELSE ''
                            END AS CMMT_CNT
                            , CASE 
                                WHEN GETDATE() - A.REG_DTM <= " + SYS.NEW_DAY + @"
                                THEN '" + SYS.ICON_NEW + @"'
                                ELSE ''
                            END as ICON_NEW
                        FROM T_MEDIA_BORD A
                        WHERE DEL_YN = 'N' 
                        AND BORD_DIV = '" + BORD_DIV + @"'
                        AND NAT_CD = '" + NAT_CD + @"'
                    ) A
                ) A
                WHERE PAGE = " + NOW_PAGE + @"
                ORDER BY SEQ DESC";

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
        public DataTable getRead(string BORD_DIV, string NAT_CD, string SEQ)
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
                    , BORD_DIV
                    , TITL
                    , CNTN
                    , HIT_CNT                            
                    , REG_ID
                    , REG_NICK_NM
                    , REG_DTM                            
                    , UPDT_ID
                    , UPDT_NICK_NM
                    , UPDT_DTM
                    , DEL_YN
                    , TOP_POST_YN
                    , NAT_CD
                    , PATH
                    , CONVERT(VARCHAR, REG_DTM, 106) as REG_DT
                    , CONVERT(VARCHAR, UPDT_DTM, 106) as UPDT_DT
                FROM T_MEDIA_BORD
                WHERE DEL_YN = 'N' 
                AND BORD_DIV = '" + BORD_DIV + @"'
                AND NAT_CD = '" + NAT_CD + @"'
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
        public Exception insert(string BORD_DIV, string TITL, string CNTN, string USER_ID, string USER_NICK_NM, string TOP_POST_YN, string NAT_CD, string PATH, string[] FILE_SEQ)
        {
            webservice.T_FILE_INFO T_FILE_INFO = new T_FILE_INFO();

            string tmpSQL = null, msg = null;
            int NOW_SEQ = 0;

            DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
            DbCommand command = cnn.CreateCommand();
            DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
            DbTransaction Trans = cnn.BeginTransaction();
            command.Transaction = Trans;


            try
            {
                tmpSQL = @"
-- " + this.ToString() + @" (NEXT SEQ)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                            SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_MEDIA_BORD
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

                    INSERT INTO T_MEDIA_BORD
                    (
                        SEQ
                        , BORD_DIV
                        , TITL
                        , CNTN
                        , HIT_CNT
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                        , DEL_YN
                        , TOP_POST_YN
                        , NAT_CD
                        , PATH
                    )
                    VALUES
                    (
                        " + NOW_SEQ + @"
                        , '" + SYS.nullToSpace(BORD_DIV) + @"'
                        , @TITL
                        , @CNTN
                        , 0                        
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , 'N'
                        , '" + SYS.nullToSpace(TOP_POST_YN) + @"'
                        , '" + SYS.nullToSpace(NAT_CD) + @"'
                        , '" + SYS.nullToSpace(PATH) + @"'
                    )";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@TITL", SYS.nullToSpace(TITL));
                connect.CreateParameter(command, "@CNTN", SYS.nullToSpace(CNTN));

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

                command.ExecuteNonQuery();

                T_FILE_INFO.reltFile(NOW_SEQ, BORD_DIV, FILE_SEQ);

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
        public Exception update(string BORD_DIV, string SEQ, string TITL, string CNTN, string USER_ID, string USER_NICK_NM, string TOP_POST_YN, string PATH, string[] FILE_SEQ, string[] DEL_FILE_SEQ)
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
                tmpSQL = @"
-- " + this.ToString() + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_MEDIA_BORD SET
                        TITL = @TITL
                        , CNTN = @CNTN
                        , PATH = @PATH
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                        , TOP_POST_YN = '" + SYS.nullToSpace(TOP_POST_YN) + @"'
                    WHERE DEL_YN = 'N'
                    AND BORD_DIV = '" + BORD_DIV + @"'
                    AND SEQ = '" + SEQ + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@TITL", SYS.nullToSpace(TITL));
                connect.CreateParameter(command, "@CNTN", SYS.nullToSpace(CNTN));
                connect.CreateParameter(command, "@PATH", SYS.nullToSpace(PATH));

                for (int i = 0; i < command.Parameters.Count; i++)
                {
                    msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
                }

                command.ExecuteNonQuery();

                T_FILE_INFO.reReltFile(int.Parse(SEQ), BORD_DIV, FILE_SEQ);
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
-- " + this.ToString() + @" (delete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_MEDIA_BORD SET
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
        /*********************************************************************************************************************/
        /* update
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception updateHitCount(string SEQ)
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
-- " + this.ToString() + @" (updateHitCount)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_MEDIA_BORD SET
                        HIT_CNT = HIT_CNT + 1
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
