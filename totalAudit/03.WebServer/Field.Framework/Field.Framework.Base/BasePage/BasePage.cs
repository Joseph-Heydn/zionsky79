using System;
using System.Data;
using System.IO;
using System.Web;

using Field.Framework.Web;

public abstract class BasePage : SuperBasePage {
	protected int gRowNo;
	protected readonly DateTime gLimitDate = Convert.ToDateTime("2015-10-01");
	protected readonly int gGameNo = Convert.ToInt32(ConfigValues.EnvText.cGameNo);
	protected readonly byte gPublisher = Convert.ToByte(ConfigValues.EnvText.cNation);
	protected string C_WEB_RESOURCE;

	protected override void OnInit(EventArgs e) {
		try {
		//	Load += new System.EventHandler(this.BasePage_Load);
			Unload += BasePage_Unload;
			base.OnInit(e);

			AuthInfo = AuthorityManager.GetAuthAccountInfo();
			BasePage_Load();
		} catch(Exception ex) {
			fnWriterLog(ex);
		}
	}


	#region Page Load/Unload
	private void BasePage_Load() {
		string vMenuNo = Request.QueryString["m"];

		if ( AuthoriyCheckAllow ) {
			fnCheckLogin();
		}

		// 페이지의 권한 정보를 불러온다.
		DataRow[] vAuthority = MenuList.fnMenuAuthority(AuthInfo.pAuthrity, Convert.ToInt32(vMenuNo));
		if ( vAuthority.Length <= 0 ) {
			return;
		}


		_IsReadableAuthority = Convert.ToBoolean(vAuthority[0]["cIsRead"]);
		_IsWritableAuthority = Convert.ToBoolean(vAuthority[0]["cIsWrite"]);
	}

	private void BasePage_Unload(object sender, EventArgs e) {
		// 페이지 종료시 종료내역을 기록한다.
	}
	#endregion Page Load/Unload


	#region control layer
	private void fnCheckLogin() {
		// 로그인 확인
		if ( AuthorityManager.IsValidLogin(AuthInfo) ) {
			return;
		}


		// 로그인 상태가 아닌 경우 로그인 화면으로 전환
		fnReturnPage("");
	}
	#endregion control layer


	#region BASEPAGE METHOD DEFINE
	// 로그인 관리자 아이피
	protected string fnHostIp() {
		HttpCookie vCookie = Request.Cookies["fnHostInfo"];
		return vCookie != null ? vCookie.Value : Request.ServerVariables["remote_addr"];
	}

	// 메뉴 번호 찾기
	protected int fnGetMenuNo() {
		string vBaseUrl = Request.ServerVariables["url"];
		string vPageInfo = Page.Request.Url.ToString();
		string vMenuNo = Request.QueryString["m"];

		if ( vPageInfo.IndexOf('?') < 0 && vBaseUrl == "/index.aspx" ) {
			return 1000001;
		}


		DataRow[] vMenuInfo = MenuList.fnMenuName(vMenuNo);
		return vMenuInfo.Length <= 0 ? 0 : Convert.ToInt32(vMenuInfo[0]["cMenuNo"]);
	}

	// 페이지에 권한이 없을 때 return url을 만들어서 로그인 페이지로 이동
	protected void fnReturnPage(string pMovePage) {
		string vPageUrl = Request.ServerVariables["url"].Replace("index.aspx", "");

		if ( string.IsNullOrEmpty(pMovePage) ) {
			pMovePage = Page.Request.Url.ToString().Replace("index.aspx", "");
			pMovePage = pMovePage.IndexOf('?') <= 0 ? "/" : $"/?pReturn={HttpUtility.UrlEncode(vPageUrl + pMovePage.Substring(pMovePage.IndexOf('?')))}";
		} else {
			pMovePage = $"{vPageUrl}?pReturn={pMovePage}";
		}

		Response.Redirect(pMovePage);
	}

	// 현재 페이지를 url encode해서 return url로 만들기
	protected string fnReturnPage(bool pIsEncode) {
		string vPageUrl = Request.ServerVariables["url"];
		string pMovePage = Page.Request.Url.ToString();

		if ( vPageUrl.IndexOf("index.aspx", StringComparison.Ordinal) > 0 ) {
			return "";
		}
		if ( pIsEncode ) {
			return pMovePage.IndexOf('?') < 0 ? "/" : HttpUtility.UrlEncode(vPageUrl + pMovePage.Substring(pMovePage.IndexOf('?')));
		}

		return pMovePage.IndexOf('?') < 0 ? "/" : vPageUrl + pMovePage.Substring(pMovePage.IndexOf('?'));
	}

	protected string fnRight(string pValue, int pLength) {
		if ( string.IsNullOrEmpty(pValue) ) {
			return string.Empty;
		}

		return pValue.Length <= pLength ? pValue : pValue.Substring(pValue.Length - pLength);
	}

	// 라벨에 텍스트 입력
	protected string fnLabelText(string pKey) {
		return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
	}

	// 메뉴 텍스트
	protected string fnMenuText(string pKey) {
		const string V_RESOURCE = "/App_Common/ucHeader.ascx";
		return ResourceValues.AppResourceText(V_RESOURCE, pKey);
	}

	// 키값에 맞는 리소스 텍스트
	protected string fnLabelName(string pKey) {
		string vMessage = fnLabelText(pKey);
		return string.IsNullOrEmpty(vMessage) ? pKey : vMessage;
	}

	// 키값에 맞는 리소스 텍스트
	protected string fnLabelName(object pKey) {
		string vMessage = fnLabelText(pKey.ToString());
		return string.IsNullOrEmpty(vMessage) ? pKey.ToString() : vMessage;
	}

	// 메시지 박스로 출력 (텍스트 입력)
	protected void fnMessageText(string pText) {
		MsgBox(MsgValue.MessageEx(pText));
	}

	// 메시지 박스로 출력 (리소스키 이용)
	protected void fnMessageKey(string pKey) {
		MsgBox(MsgValue.Message(C_WEB_RESOURCE, pKey));
	}

	// 에러 메시지 박스로 출력 (텍스트 입력)
	protected void fnErrorMessage(string pText) {
		MsgBox(MsgValue.MessageEx(pText.Replace("\r\n","\\n").Replace("\"","'")));
	}

	// 메세지 박스 출력 후 URL 이동
	protected void fnMessageBack(string pText, string pMoveUrl) {
		MsgBox(MsgValue.MessageBack(pText, pMoveUrl));
	}

	// 메시지 박스로 출력 및 이동
	protected void fnMessageKeyBack(string pKey, string pMoveUrl) {
		MsgBox(MsgValue.MessageBack(C_WEB_RESOURCE, pKey, pMoveUrl));
	}

	protected void MsgBox(string pOutString) {
		Type vScript = GetType();
		if ( !Page.ClientScript.IsStartupScriptRegistered(vScript, "MessageValue") ) {
			Page.ClientScript.RegisterStartupScript(vScript, "MessageValue", pOutString);
		}
	}

	// 날짜 형식
	protected string fnDateTime(object pDateTime) {
		return $"{pDateTime:yyyy-MM-dd HH:mm:ss}";
	}

	// 날짜 형식
	protected string fnDateOnly(object pDateTime) {
		return $"{pDateTime:yyyy-MM-dd}";
	}

	// AlternatingItemStyle 만들기
	protected string fnRowStyle() {
		return gRowNo++ % 2 == 0 ? "tbLayoutT" : "tbLayoutA";
	}

	// 최신 게시물 표시
	protected string fnIsNew(object pCreateTime) {
		DateTime vNow = DateTime.Now;
		DateTime vWrite = Convert.ToDateTime(pCreateTime);
		const string vNewImg = "<img src=\"/_common/_images/icon/ico_new.gif\" align=\"absmiddle\"/>";

		return (vNow-vWrite).TotalHours < 24 ? vNewImg : "";
	}

	// 첨부파일 아이콘
	protected string fnIsFile(object pImage) {
		if ( DBNull.Value.Equals(pImage) ) {
			return "";
		}


		const string vFileImg = "<img src=\"/_common/_images/icon/icon_filesave.png\" align=\"absmiddle\"/>";
		return Convert.ToInt64(pImage) > 0 ? vFileImg : "";
	}

	// XSS 막기
	protected string fnReplaceXSS(string pText) {
		return pText.Replace("<", "&lt;")
					.Replace(">", "&gt;")
					.Replace("//", "&#47;&#47;")
					.Replace("/*", "&#47;&#42;")
					.Replace("*/", "&#42;&#47;")
					.Replace("--", "&#45;&#45;");
	}
	#endregion


	#region Authority property
	private bool _IsReadableAuthority;
	private bool _IsWritableAuthority;
	protected bool _AuthoriyCheckAllow;

	public AuthAccountInfo AuthInfo { get; set; }

	// 인증 체크 여부. true=do check, default=true;
	public bool AuthoriyCheckAllow {
		get { return _AuthoriyCheckAllow; }
		protected set { _AuthoriyCheckAllow = value; }
	}

	public override bool IsReadableAuthority() {
		return _IsReadableAuthority;
	}

	public override bool IsWritableAuthority() {
		return _IsWritableAuthority;
	}
	#endregion Authority property


	#region SUPERBASEPAGE abstract Method Defile...
	protected override void fnWriterLog(Exception pExcept) {
		try {
			const string vLine = "--------------------------------------------------------------------------------";
			string vPath = Server.MapPath("~/error");
			string vCreateTime = $"{DateTime.Now:yyyy-MM-dd HH:mm:ss}";
			string vFile = $"{vPath}\\[{DateTime.Now:yyyy-MM-dd}] error.txt";

			FileStream fs = new FileStream(vFile, FileMode.OpenOrCreate, FileAccess.ReadWrite);
			StreamWriter sw = new StreamWriter(fs);

			sw.BaseStream.Seek(0, SeekOrigin.End);
			sw.Write($"{vCreateTime}\r\n{Page.Request.Url}\r\n{pExcept.Message}\r\n{vLine}\r\n{pExcept.StackTrace}\r\n{vLine}\r\n\r\n");

			sw.Flush();
			sw.Close();


			// 2주일 지난 파일 삭제
			for ( int i = -15; i < -31; --i ) {
				vFile = $"{vPath}\\[{DateTime.Now.AddDays(i):yyyy-MM-dd}] error.txt";

				if ( File.Exists(vFile) ) {
					File.Delete(vFile);
				} else {
					break;
				}
			}
		} catch ( Exception ) {
			throw new Exception();
		}
	}

	public override void SetCacheData(string key, object data, int cachingTime) {
		throw new Exception("The method or operation is not implemented.");
	}

	public override void GetCacheData(string key) {
		throw new Exception("The method or operation is not implemented.");
	}
	#endregion
}
