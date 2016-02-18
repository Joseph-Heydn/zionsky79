using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.Common;
using System.Configuration;

namespace _12sky2.webservice
{
    /// <summary>
    /// T_LIKE의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    // [System.Web.Script.Services.ScriptService]
    public class T_LIKE : System.Web.Services.WebService
    {
        /*********************************************************************************************************************/
        /* insert
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        public Exception insert(string RELT_DIV, string RELT_SEQ, string LIKE_YN, string USER_ID, string USER_NICK_NM)
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

                    INSERT INTO T_LIKE
                    (
                        SEQ
                        , RELT_DIV
                        , RELT_SEQ
                        , LIKE_YN
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                    )
                    VALUES
                    (
                        (SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_LIKE)
                        , @RELT_DIV
                        , @RELT_SEQ
                        , @LIKE_YN
                        , @USER_ID
                        , @USER_NICK_NM
                        , GETDATE()
                        , @USER_ID
                        , @USER_NICK_NM
                        , GETDATE()
                    )";

                command.Parameters.Clear();
                command.CommandText = tmpSQL;

                connect.CreateParameter(command, "@RELT_DIV", SYS.nullToSpace(RELT_DIV));
                connect.CreateParameter(command, "@RELT_SEQ", SYS.nullToSpace(RELT_SEQ));
                connect.CreateParameter(command, "@LIKE_YN", SYS.nullToSpace(LIKE_YN));
                connect.CreateParameter(command, "@USER_ID", SYS.nullToSpace(USER_ID));
                connect.CreateParameter(command, "@USER_NICK_NM", SYS.nullToSpace(USER_NICK_NM));

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
