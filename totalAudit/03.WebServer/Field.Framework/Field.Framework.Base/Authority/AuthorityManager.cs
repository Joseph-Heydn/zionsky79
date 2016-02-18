/*********************************************************************************
 * Class    : AuthorityManager
 * Remarks  : 쿠키관련제어클래스
 * History  :
 *
 * Ver	Date		Author			Description
 * 1.0	2013-03-11	Hoon-Sik,Jin	1. Create.
 ********************************************************************************/
using System;
using System.Web;

public static class AuthorityManager {
	public static void ClearCookie() {
		HttpCookie vCookie = new HttpCookie(AuthAccountInfo.cFIELD_CLASS)
		{	Expires = DateTime.Now.AddDays(-1)
		,	Path	= "/"
		};
		vCookie.Values.Clear();
		HttpContext.Current.Response.Cookies.Add(vCookie);
	}

	public static void SetAuthAccountInfo(AuthAccountInfo pAccountInfo) {
		if ( pAccountInfo == null ) {
			const string vError = "pAccountInfo";
			throw new ArgumentNullException(vError);
		}


		string vAuthCookieString = AuthorityCookiePacker.GetInstance().Pack(pAccountInfo);
		string vAuthCookieData = AuthorityCookieCrypto.GetInstance().Encrypt(vAuthCookieString);

		WriteCookie(AuthAccountInfo.cFIELD_CLASS, vAuthCookieData);
	}

	public static AuthAccountInfo GetAuthAccountInfo() {
		string vAuthCookieData = GetReadCookie(AuthAccountInfo.cFIELD_CLASS);
		if ( string.IsNullOrEmpty(vAuthCookieData) ) {
			return new AuthAccountInfo();
		}


		string vAuthCookieString = AuthorityCookieCrypto.GetInstance().Decypt(vAuthCookieData);
		return AuthorityCookiePacker.GetInstance().UnPack(vAuthCookieString);
	}

	public static AuthMenuInfo GetAuthMenuInfo() {
		return new AuthMenuInfo();
	}

	public static bool IsValidLogin(AuthAccountInfo pAccountInfo) {
		return !string.IsNullOrEmpty(pAccountInfo.pAccountNm);
	}

	public static bool fnCheckLogin() {
		return !string.IsNullOrEmpty(GetAuthAccountInfo().pAccountNm);
	}

	// 쿠키 생성
	private static void WriteCookie(string pName, string pValue) {
		HttpCookie vCookie = HttpContext.Current.Request.Cookies[pName];
		if ( vCookie != null ) {
			ClearCookie();
		}


		vCookie = new HttpCookie(pName, pValue)
		{	Path = "/"
		};
		HttpContext.Current.Response.Cookies.Add(vCookie);
		//HttpContext.Current.Response.SetCookie(new HttpCookie(pName, pValue));
	}

	private static string GetReadCookie(string pName) {
		HttpCookie vCookie = HttpContext.Current.Request.Cookies[pName];
		return vCookie == null ? string.Empty : vCookie.Value;
	}
}
