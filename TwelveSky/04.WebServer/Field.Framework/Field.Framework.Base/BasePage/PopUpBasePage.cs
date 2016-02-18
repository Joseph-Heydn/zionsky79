using System;
using System.Configuration;
using System.IO;
using System.Web;
using Field.Framework.Web;
using Field.Framework.Logging;

public abstract class PopUpBasePage : SuperBasePage {
	protected int gRowNo;
	protected readonly int gGameNo = Convert.ToInt32(ConfigValues.EnvText.cGameNo);
	protected readonly byte gPublisher = Convert.ToByte(ConfigValues.EnvText.cNation);

	//private Page child;
	protected string C_WEB_RESOURCE = "";
	private readonly LogHelper pageLogger = LogHelper.GetLogHelper();

	protected override void OnInit(EventArgs e) {
		Load += PopUpBasePage_Load;
		Unload += PopUpBasePage_Unload;
		base.OnInit(e);

		AuthInfo = AuthorityManager.GetAuthAccountInfo();
		string vHostName = Request.ServerVariables["http_host"];
		AppConfig.SetConfigValues(vHostName);
	}


	#region Page Load/Unload
	private void PopUpBasePage_Load(object sender, EventArgs e) {
		if ( AuthoriyCheckAllow ) {
			CheckLogin();
		}
	}

	private void PopUpBasePage_Unload(object sender, EventArgs e) {
		// 페이지 종료시 종료내역을 기록한다.
	}
	#endregion Page Load/Unload


	#region Authority property
	protected AuthAccountInfo _AccountInfo;
	protected bool _AuthoriyCheckAllow;
	protected bool _IsReadableAuthority = false;
	protected bool _IsWritableAuthority = false;

	public AuthAccountInfo AuthInfo {
		get { return _AccountInfo; }
		protected set { _AccountInfo = value; }
	}

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
	#endregion


	#region Authority method
	private void CheckLogin() {
/*		if ( !AuthorityManager.IsValidLogin(AuthInfo) ) {
			Response.Redirect(C_LOGIN_PAGE_URL);
		}
*/	}
	#endregion


	#region BASEPAGE METHOD DEFINE
/*	protected void SetMenuAuthority(string pExecUrl) {
		try {
			int vMenuNo = fnGetMenuNo(pExecUrl);

			// 페이지의 권한 정보를 불러온다.
			uspGetAuthCheckMenuInfo oDTO = new uspGetAuthCheckMenuInfo();
			oDTO.pAccountNo = pAccountNo;
			oDTO.pMenuNo = vMenuNo;
			int oReturnNo = oDTO.fnGetResultInfo(gConnStr);

			if ( oReturnNo != 0 ) {
				ClientScriptHelper.SetMsgBox(Page, "message", Resources.SiteErrorMessage.MenuAuthority_Fail);
				return;
			}


			_IsReadableAuthority = oDTO.oIsRead;
			_IsWritableAuthority = oDTO.oIsWrite;
		} catch {
			new Exception("BasePage Load Error!");
		}
	}

	private int fnGetMenuNo(string pExecUrl) {
		uspGetAuthCheckExecUrl oDTO = new uspGetAuthCheckExecUrl();
		oDTO.pExecUrl = pExecUrl;
		int oReturnNo = oDTO.fnGetResultInfo(gConnStr);

		return oReturnNo != 0 ? null : oDTO.r_menu_no;
	}
*/
	// 로그인 관리자 아이피
	protected string fnHostIp() {
		HttpCookie vCookie = Request.Cookies["fnHostInfo"];
		return vCookie != null ? vCookie.Value : Request.ServerVariables["remote_addr"];
	}

	protected string fnRight(string pValue, int pLength) {
		if ( string.IsNullOrEmpty(pValue) )
			return string.Empty;

		return pValue.Length <= pLength ? pValue : pValue.Substring(pValue.Length - pLength);
	}

	// 라벨에 텍스트 입력
	protected string fnLabelText(string pKey) {
		return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
	}

	// 키값에 맞는 리소스 텍스트
	protected string fnLabelName(string pKey) {
		string vMessage = fnLabelText(pKey);
		if ( string.IsNullOrEmpty(vMessage) ) vMessage = Convert.ToString(pKey);

		return vMessage;
	}

	// 키값에 맞는 리소스 텍스트
	protected string fnLabelName(object pKey) {
		string vMessage = fnLabelText(pKey.ToString());
		if ( string.IsNullOrEmpty(vMessage) ) vMessage = Convert.ToString(pKey);

		return vMessage;
	}

	// 메시지 박스로 출력 (텍스트 입력)
	protected string fnMessageText(string pText) {
		return MsgValue.MessageEx(pText);
	}

	// 메시지 박스로 출력 (리소스키 이용)
	protected string fnMessageKey(string pKey) {
		return MsgValue.Message(C_WEB_RESOURCE, pKey);
	}

	// 에러 메시지 박스로 출력 (텍스트 입력)
	protected string fnErrorMessage(string pText) {
		return MsgValue.MessageEx(pText.Replace("\r\n", "\\n").Replace("\"", "'"));
	}

	// 메세지 박스 출력 후 URL 이동
	protected string fnMessageBack(string pText, string pMoveUrl) {
		return MsgValue.MessageBack(pText, pMoveUrl);
	}

	// 메시지 박스로 출력 및 이동
	protected string fnMessageKeyBack(string pKey, string pMoveUrl) {
		return MsgValue.MessageBack(C_WEB_RESOURCE, pKey, pMoveUrl);
	}

	public void MsgBox(string pOutString) {
		Type vCsType = GetType();
		if ( !Page.ClientScript.IsStartupScriptRegistered(vCsType, "MessageValue") ) {
			Page.ClientScript.RegisterStartupScript(vCsType, "MessageValue", pOutString);
		}
	}

	// 날짜 형식
	protected string fnDateFormat(object pDateTime) {
		return $"{pDateTime:yyyy-MM-dd HH:mm:ss}";
	}

	// AlternatingItemStyle 만들기
	protected string fnRowStyle() {
		return gRowNo++ % 2 == 0 ? "tbLayoutT" : "tbLayoutA";
	}

	private void PageLoggerInit() {
		string vLogConfigDirectory = ConfigurationManager.AppSettings["PageLogDiretory"];
		string vLogConfigUsable = ConfigurationManager.AppSettings["PageLogUsable"];

		if ( vLogConfigUsable == null ) {
			return;
		}


		pageLogger.FileLocation = vLogConfigDirectory;
		pageLogger.FileName = "";
	}
	#endregion


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
