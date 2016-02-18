using System.Collections.Generic;
using System.Configuration;
using System.Web;

public class AppConfig {
	private static string mHostName;

	private static Dictionary<string, string> fnAppConfig {
		get {
			Dictionary<string, string> oTable = (Dictionary<string, string>) HttpContext.Current.Cache["tAppConfig"];

			if ( oTable != null ) {
				return oTable;
			}


			string vImageIp;
			string mMainPage	= ConfigurationManager.AppSettings["wMainURL"];
			string mUploadUrl	= ConfigurationManager.AppSettings["wUploadPath"];
			string mCommonUrl	= ConfigurationManager.AppSettings["wCommonUrl"];
			string mCommonImg	= $"{ConfigurationManager.AppSettings["wCommonUrl"]}/images";
			string mImagesUrl	= ConfigurationManager.AppSettings["wImageUrl"];

			switch ( mHostName ) {
				case "www.adminsite.com":
					vImageIp = ConfigurationManager.AppSettings["ImageLiveIp"];
					// 라이브 서버
					oTable = new Dictionary<string, string>
					{	{"pMainPage"	, string.Format(mMainPage	, "com")}
					,	{"pAuthPage"	, string.Format(mMainPage	, "com/login")}
					,	{"pUploadUrl"	, string.Format(mUploadUrl	, vImageIp, "co.kr")}
					,	{"pCommonUrl"	, string.Format(mCommonUrl	, "https", "com")}
					,	{"pCommonImg"	, string.Format(mCommonImg	, "https", "com")}
					,	{"pImagesUrl"	, string.Format(mImagesUrl	, "co.kr")}
					};
					break;
				case "www.adminsite.net":
					vImageIp = ConfigurationManager.AppSettings["ImageTestIp"];
					// 테스트 서버
					oTable = new Dictionary<string, string>
					{	{"pMainPage"	, string.Format(mMainPage	, "net")}
					,	{"pAuthPage"	, string.Format(mMainPage	, "net/login")}
					,	{"pUploadUrl"	, string.Format(mUploadUrl	, vImageIp, "net")}
					,	{"pCommonUrl"	, string.Format(mCommonUrl	, "http", "net")}
					,	{"pCommonImg"	, string.Format(mCommonImg	, "http", "net")}
					,	{"pImagesUrl"	, string.Format(mImagesUrl	, "net")}
					};
					break;
				case "www.adminsite.dev":
					vImageIp = ConfigurationManager.AppSettings["ImageDevsIp"];
					// 로컬 개발 서버
					oTable = new Dictionary<string, string>
					{	{"pMainPage"	, string.Format(mMainPage	, "dev")}
					,	{"pAuthPage"	, string.Format(mMainPage	, "dev/login")}
					,	{"pUploadUrl"	, string.Format(mUploadUrl	, vImageIp, "dev")}
					,	{"pCommonUrl"	, string.Format(mCommonUrl	, "http", "dev")}
					,	{"pCommonImg"	, string.Format(mCommonImg	, "http", "dev")}
					,	{"pImagesUrl"	, string.Format(mImagesUrl	, "dev")}
					};
					break;
				default:
					// 로컬 Express 서버
					const string vTmpString = "http://{0}:{1}/{2}";
					string vHomePort = ConfigValues.EnvUrl.wHomePort;
					vImageIp = ConfigurationManager.AppSettings["ImageDevsIp"];

					if ( mHostName == null ) {
						mHostName = "localhost";
					}
					if ( mHostName.IndexOf(":", System.StringComparison.Ordinal) > 0 ) {
						mHostName = mHostName.Substring(0, mHostName.IndexOf(":", System.StringComparison.Ordinal));
					}

					oTable = new Dictionary<string, string>
					{	{"pMainPage"	, string.Format(vTmpString	, mHostName, vHomePort, "")}
					,	{"pAuthPage"	, string.Format(vTmpString	, mHostName, vHomePort, "login")}
					,	{"pUploadUrl"	, string.Format(mUploadUrl	, vImageIp, "dev")}
					,	{"pCommonUrl"	, string.Format(mCommonUrl	, "http", "dev")}
					,	{"pCommonImg"	, string.Format(mCommonImg	, "http", "dev")}
					,	{"pImagesUrl"	, string.Format(mImagesUrl	, "dev")}
					};
					break;
			}

			return oTable;
		}
	}

	public static void SetConfigValues(string pHostName) {
		mHostName = pHostName;
	}

	public static string GetConfigValues(string pName) {
		string oValue;
		Dictionary<string, string> vTable = fnAppConfig;

		if ( !vTable.TryGetValue(pName, out oValue) ) {
			oValue = "";
		}

		return oValue;
	}
}
