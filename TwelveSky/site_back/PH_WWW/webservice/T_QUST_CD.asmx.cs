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
    /// T_NOTI_BORD의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_QUST_CD : System.Web.Services.WebService
    {        
        /*********************************************************************************************************************/
        /* list
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getList(string UP_CD_NO, string NAT_CD)
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
                        row_number() over(order by SORT_ORD ASC) as ROWNO
                        , CD_NO
                        , CD_NM
                        , UP_CD_NO
                        , SORT_ORD
                        , REG_ID
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_DTM
                        , DEL_YN
                        , (SELECT CD_NM 
                            FROM T_QUST_CD 
                            WHERE DEL_YN = 'N'
                            AND CD_NO = A.UP_CD_NO) as UP_CD_NM
                    FROM T_QUST_CD A
                    WHERE DEL_YN = 'N'
                    AND UP_CD_NO = '" + UP_CD_NO + @"'
                    AND NAT_CD = '" + NAT_CD + @"'
                    ORDER BY SORT_ORD ASC";

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
        public DataTable getRead(string CD_NO, string NAT_CD)
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
                    CD_NO
                    , CD_NM
                    , UP_CD_NO
                    , SORT_ORD
                    , REG_ID
                    , REG_DTM
                    , UPDT_ID
                    , UPDT_DTM
                    , DEL_YN
                FROM T_QUST_CD
                WHERE DEL_YN = 'N' 
                AND CD_NO = '" + CD_NO + @"'
                AND NAT_CD = '" + NAT_CD + @"'
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
        public Exception insert(string CD_NM, string UP_CD_NO, string USER_ID, string NAT_CD)
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

                    INSERT INTO T_QUST_CD
                    (
                        CD_NO
                        , CD_NM
                        , UP_CD_NO
                        , SORT_ORD
                        , REG_ID
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_DTM
                        , DEL_YN
                        , NAT_CD
                    )
                    VALUES
                    (
                        (SELECT ISNULL(MAX(CD_NO)+1, 1) FROM T_QUST_CD)
                        , '" + SYS.nullToSpace(CD_NM) + @"'
                        , '" + SYS.nullToSpace(UP_CD_NO) + @"'
                        , (SELECT COUNT(CD_NO)  +1
                            FROM T_QUST_CD 
                            WHERE DEL_YN = 'N' 
                            AND UP_CD_NO = '" + SYS.nullToSpace(UP_CD_NO) + @"')                       
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , GETDATE()
                        , 'N'
                        , '" + SYS.nullToSpace(NAT_CD) + @"'
                    )";

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
        public Exception update(string CD_NO, string CD_NM, string UP_CD_NO, string SORT_ORD, string USER_ID, string NAT_CD)
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

                    UPDATE T_QUST_CD SET
                        SORT_ORD = SORT_ORD - 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N' 
                    AND NAT_CD = '" + NAT_CD + @"'
                    AND SORT_ORD > (SELECT SORT_ORD FROM T_QUST_CD WHERE CD_NO = " + CD_NO + @" AND NAT_CD = '" + NAT_CD + @"')
                    AND SORT_ORD <= " + SORT_ORD + "";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();


                tmpSQL = @"
-- " + this.ToString() + @" (update order +)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST_CD SET
                        SORT_ORD = SORT_ORD + 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N' 
                    AND NAT_CD = '" + NAT_CD + @"'
                    AND SORT_ORD >= " + SORT_ORD + @"
                    AND SORT_ORD < (SELECT SORT_ORD FROM T_QUST_CD WHERE CD_NO = " + CD_NO + @" AND NAT_CD = '" + NAT_CD + @"')";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                tmpSQL = @"
-- " + this.ToString() + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST_CD SET
                        CD_NM = '" + SYS.nullToSpace(CD_NM) + @"'
                        , SORT_ORD = '" + SYS.nullToSpace(SORT_ORD) + @"'
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND UP_CD_NO = '" + UP_CD_NO + @"'
                    AND NAT_CD = '" + NAT_CD + @"'
                    AND CD_NO = '" + CD_NO + "'";

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
        /* delete
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception delete(string CD_NO, string USER_ID, string NAT_CD)
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

                    UPDATE T_QUST_CD SET
                        SORT_ORD = SORT_ORD - 1
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N' AND NAT_CD = '" + NAT_CD + @"'
                    AND SORT_ORD > (SELECT SORT_ORD FROM T_QUST_CD WHERE CD_NO = " + CD_NO + @" AND NAT_CD = '" + NAT_CD + @"')";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;
                command.ExecuteNonQuery();

                tmpSQL = @"
-- " + this.ToString() + @" (delete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST_CD SET
                        DEL_YN = 'Y'
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE CD_NO = '" + CD_NO + "' AND NAT_CD = '" + NAT_CD + @"'";

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
