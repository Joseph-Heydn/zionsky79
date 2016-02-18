using System;
using System.Configuration;

public class ConfigValues {
	public struct EnvUrl {
		// LOGIN URL
		public static string wLoginUrl	= ConfigurationManager.AppSettings["wLoginURL"];
		// MAIN URL
		public static string wMainUrl	= ConfigurationManager.AppSettings["wMainURL"];
		// Error URL
		public static string wErrorUrl	= ConfigurationManager.AppSettings["wErrorURL"];
		// Common URL
		public static string wCommonUrl	= ConfigurationManager.AppSettings["wCommonUrl"];
		// Image URL
		public static string wImageUrl	= ConfigurationManager.AppSettings["wImageUrl"];
		// Upload URL
		public static string wUploadUrl	= ConfigurationManager.AppSettings["wUploadPath"];
		// Develope Port
		public static string wHomePort	= ConfigurationManager.AppSettings["wHomePort"];
		public static string wAuthPort	= ConfigurationManager.AppSettings["wAuthPort"];
	}

	public struct EnvPage {
		// 페이지그리드사이즈
		public static byte nBlockSize	= Convert.ToByte(ConfigurationManager.AppSettings["sBlockSize"]);
		public static byte nBlockSizeL	= Convert.ToByte(ConfigurationManager.AppSettings["sBlockSizeL"]);

		public static int nPageSize		= Convert.ToInt32(ConfigurationManager.AppSettings["sPageSize"]);
		public static int nPageSizeL	= Convert.ToInt32(ConfigurationManager.AppSettings["sPageSizeL"]);
		public static int nPageSizeLog	= Convert.ToInt32(ConfigurationManager.AppSettings["sPageSizeLog"]);
	}

	public struct EnvText {
		public static string sPageTitle	= ConfigurationManager.AppSettings["sPageTitle"];
		public static string cGameNo	= ConfigurationManager.AppSettings["cGameNo"];
		public static string cLangNo	= ConfigurationManager.AppSettings["cLangNo"];
		public static string cLangCode	= ConfigurationManager.AppSettings["cLangCode"];
		public static string cNation	= ConfigurationManager.AppSettings["cNation"];
		public static string cNateCode	= ConfigurationManager.AppSettings["cNatCode"];
		public static string cGameDown	= ConfigurationManager.AppSettings["wGameDown"];
		public static string cFaceBook	= ConfigurationManager.AppSettings["wFaceBook"];
		public static string sDomain	= string.Format(ConfigurationManager.AppSettings["sDomain"], cNateCode);
		public static string sBillUrl	= string.Format(ConfigurationManager.AppSettings["wBillURL"], cNateCode);
	}
}
