using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;

namespace _12sky2.webservice
{
    /// <summary>
    /// services의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    [System.Web.Script.Services.ScriptService]
    public class services : System.Web.Services.WebService
    {
        webservice.T_MBER T_MBER = new webservice.T_MBER();

        /*********************************************************************************************************************/
        /* 사용자 아이디 체크
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String getUserIdCheck(string UserID)
        {
            string result = "OK";
            if (!SYS.is_null(Session["USER_ID"]))
            {
                result = "E1";
                return result;
            }

            if (SYS.is_null(UserID))
            {
                result = "E2";
                return result;
            }

            if (!SYS.is_mail(UserID))
            {
                result = "E5";
                return result;
            }

            if (T_MBER.getUserCheck(UserID, null) > 0)
            {
                result = "E4";
                return result;
            }

            return result;
        }
        /*********************************************************************************************************************/
        /* 사용자 닉네임 체크
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String getUserNicknameCheck(string Nickname)
        {
            string result = "OK";
            if (!SYS.is_null(Session["USER_ID"]))
            {
                result = "E1";
                return result;
            }

            if (SYS.is_null(Nickname))
            {
                result = "E2";
                return result;
            }

            if (Nickname.Length < 6 || Nickname.Length > 16)
            {
                result = "E5";
                return result;
            }

            if (T_MBER.getUserCheck(null, Nickname) > 0)
            {
                result = "E4";
                return result;
            }

            return result;
        }
        /*********************************************************************************************************************/
        /* 사용자 정보 조회 cookie
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String getUserInfoCookie(string tmpUSER)
        {
            string USER_ID = SYS.Base64Decode(tmpUSER);
            DataTable result = T_MBER.getUserInfo(USER_ID);

            if (result.Rows.Count == 0)
            {
                DataRow row = result.NewRow();
                row["Result"] = "0";
                result.Rows.Add(row);
            }

            return Jquery.listData(result);
        }
        /*********************************************************************************************************************/
        /* 사용자 정보 조회 userid
        /*********************************************************************************************************************/
        //
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String getUserInfo(string UserId)
        {
            DataTable result = T_MBER.getUserInfo(UserId);

            if (result.Rows.Count == 0)
            {
                DataRow row = result.NewRow();
                row["Result"] = "0";
                result.Rows.Add(row);
            }

            return Jquery.listData(result);
        }
    }
}
