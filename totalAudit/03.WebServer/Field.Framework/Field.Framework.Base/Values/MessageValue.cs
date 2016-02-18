/*********************************************************************************
 * Class    : MsgValue
 * Remarks  : 메시지를 스크립트로 생성 후 리턴한다. + (확장기능: 페이지제어)
 * History  :
 *
 * Ver	Date		Author			Description
 *----	----------	--------------	----------------------------------------------
 * 1.0	2013-03-12	Hoon-Sik,Jin    1.Create
 ********************************************************************************/
using System;

/// <summary>
/// MsgValue의 요약 설명입니다.
/// </summary>
public class MsgValue {
	private const string gFormat = "<script type=\"text/javascript\">alert(\"{0}\");</script>";
	public enum emERRORTYPE {
		eNET = 0
	,	eSQL
	,	eIO
	,	eXML
	,	ePRINTER
	,	eCOMPONENT
	}

	/// <summary>
	/// 메모 : 사용중 (LocalResources)
	/// </summary>
	public static string Message(string pPath, string pKey) {
		return string.Format(gFormat,ResourceValues.AppResourceText(pPath, pKey));
	}

	/// <summary>
	/// 메모 : 사용중 (LocalResources)
	/// </summary>
	public static string MessageBack(string pPath, string pKey, string pMoveUrl) {
		const string vFormat = "<script type=\"text/javascript\">alert(\"{0}\");location.href=\"{1}\"</script>";
		return string.Format(vFormat, ResourceValues.AppResourceText(pPath, pKey), pMoveUrl);
	}

	/// <summary>
	/// 메모 : 사용중 (LocalResources)
	/// </summary>
	public static string MessageBack(string pMessage, string pMoveUrl) {
		const string vFormat = "<script type=\"text/javascript\">alert(\"{0}\");location.href=\"{1}\"</script>";
		return string.Format(vFormat, pMessage, pMoveUrl);
	}

	/// <summary>
	/// 메모 : UI에서 출력값을 구해서 넘겨줄 경우
	/// 로컬 : base.MsgBox(MsgValue.MessageEx(this.GetLocalResourceObject("msgLoginSuccess"));
	/// 전역 : base.MsgBox(MsgValue.MessageEx(this.GetGlobalResourceObject(ResourceValues.C_PATH_MSG, "confirm_msgCreate"));
	///        base.MsgBox(MsgValue.MessageEx(Resources.SiteMessage.confirm_msgCreate));
	/// </summary>
	public static string MessageEx(string pMessage) {
		return string.Format(gFormat, pMessage.Replace("\\", "/"));
	}


	#region 서버변수 사용 펑션
	/// <summary>
	/// 메모 : 사용중 (GlobalResources)
	/// </summary>
	public static string Message(string pKey) {
		return string.Format(gFormat, ResourceValues.AppResourceText(ResourceValues.C_PATH_MSG, pKey).Replace("\\", "/"));
	}

	/// <summary>
	/// 메모: 저장프로시저 리턴값에 대해서 리로스값을 찾아낸다.
	/// </summary>
	/// <param name="pPath">PAGE 가상경로</param>
	/// <param name="pProcedure">프로시저명</param>
	/// <param name="pResult">프로시저리턴값</param>
	/// <returns></returns>
	public static string MessageError(string pPath, string pProcedure, int pResult) {
		pPath = pPath.Replace("~/App/", "").Replace(".aspx", "");
		string sValue = $"{pPath}_{pProcedure}_{Convert.ToString(pResult).Replace("-", "")}";

		return string.Format(gFormat, ResourceValues.AppResourceText(ResourceValues.C_PATH_ERRMSG, sValue).Replace("\\", "/"));
	}

	/// <summary>
	/// 메모:   1. 모든 사용자정의 Exception 메시지에 대한 리소스값 서치 (범위: UI에서사용되는 클래스에 제한됨)
	///         2. 저장프로시저에서 공통으로 쓰이는 메시지에 대한 리소스값 서치
	///         3. 기타 공통메시지 관련해서 사용됨
	/// </summary>
	/// <param name="pType">에러타입</param>
	/// <param name="pResult">메시지번호</param>
	/// <returns></returns>
	public static string MessageError(emERRORTYPE pType, int pResult) {
		string sValue = "";

		switch ( pType ) {
			case emERRORTYPE.eNET:
				sValue = $"Share_Net_{Convert.ToString(pResult).Replace("-", "")}";
				break;
			case emERRORTYPE.eSQL:
				sValue = $"Share_Procedure_{Convert.ToString(pResult).Replace("-", "")}";
				break;
			case emERRORTYPE.eIO:
				break;
			case emERRORTYPE.eXML:
				break;
			case emERRORTYPE.ePRINTER:
				break;
			case emERRORTYPE.eCOMPONENT:
				break;
		}

		return string.Format(gFormat, ResourceValues.AppResourceText(ResourceValues.C_PATH_ERRMSG, sValue).Replace("\\", "/"));
	}

	/// <summary>
	/// 메모:   1. 모든 사용자정의 Exception 메시지에 대한 리소스값 서치 (범위: UI에서사용되는 클래스에 제한됨)
	///         2. 저장프로시저에서 공통으로 쓰이는 메시지에 대한 리소스값 서치
	///         3. 기타 공통메시지 관련해서 사용됨
	/// </summary>
	/// <param name="pType"></param>
	/// <param name="pResult"></param>
	/// <param name="pScript">스크립트코드 사용여부</param>
	/// <returns></returns>
	public static string MessageError(emERRORTYPE pType, int pResult, bool pScript) {
		string sValue = "";

		switch ( pType ) {
			case emERRORTYPE.eNET:
				sValue = $"Share_Net_{Convert.ToString(pResult).Replace("-", "")}";
				break;
			case emERRORTYPE.eSQL:
				sValue = $"Share_Procedure_{Convert.ToString(pResult).Replace("-", "")}";
				break;
			case emERRORTYPE.eIO:
				break;
			case emERRORTYPE.eXML:
				break;
			case emERRORTYPE.ePRINTER:
				break;
			case emERRORTYPE.eCOMPONENT:
				break;
		}

		return pScript
			? string.Format(gFormat, ResourceValues.AppResourceText(ResourceValues.C_PATH_ERRMSG, sValue).Replace("\\", "/"))
			: ResourceValues.AppResourceText(ResourceValues.C_PATH_ERRMSG, sValue);
	}
	#endregion 서버변수 사용 펑션
}
