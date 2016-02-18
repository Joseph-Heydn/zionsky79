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
    /// T_REPR_ANIM의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_REPR_ANIM : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* read
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public DataTable getRead(string NAT_CD)
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
                    , TITL
                    , ANIM_PATH                            
                    , REG_ID
                    , REG_NICK_NM
                    , REG_DTM                            
                    , UPDT_ID
                    , UPDT_NICK_NM
                    , UPDT_DTM
                    , NAT_CD
                    , DEL_YN                  
                FROM T_REPR_ANIM
                WHERE DEL_YN = 'N'
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
        public Exception insert(string TITL, string ANIM_PATH
            , string USER_ID, string USER_NICK_NM, string NAT_CD)
        {
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

                            SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_REPR_ANIM
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

                    INSERT INTO T_REPR_ANIM
                    (
                        SEQ
                        , TITL
                        , ANIM_PATH
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                        , NAT_CD
                        , DEL_YN                        
                    )
                    VALUES
                    (
                        " + NOW_SEQ + @"
                        , @TITL
                        , @ANIM_PATH                       
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(NAT_CD) + @"'
                        , 'N'
                    )";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@TITL", SYS.nullToSpace(TITL));
                connect.CreateParameter(command, "@ANIM_PATH", SYS.nullToSpace(ANIM_PATH));

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
        /* update
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception update(string SEQ, string ANIM_PATH, string NAT_CD, string USER_ID, string USER_NICK_NM)
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
-- " + this.ToString() + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_ANIM SET
                        ANIM_PATH = @ANIM_PATH
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND NAT_CD = '" + NAT_CD + @"'
                    AND SEQ = '" + SEQ + "'";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@ANIM_PATH", SYS.nullToSpace(ANIM_PATH));

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
        
    }
}
