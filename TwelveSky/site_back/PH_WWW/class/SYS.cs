using System;
using System.Configuration;
using System.Web;
using System.Web.UI;

using System.Drawing;
using System.IO;
using System.Collections.Specialized;
using System.Linq;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

public class SYS {
	public static string DOMAIN = "http://www.12sky2-ph.com";
	public static string MAIL_SERVER = "211.119.136.241";
	public static string BILL_URL = "http://bill.12sky2-ph.com";
	public static string COOKIE_DOMAIN = "12sky2-ph.com";
	public static string E_MAIL_URL = "kjgames15@gmail.com";
	public static string FACEBOOK_LANG = "en_US";
	public static string FACEBOOK_URL = "https://www.facebook.com/wsp.ph";
	public static string EXE_URL = "http://kj.edgesuite.net/PH/SETUP/WSP_PH.exe";

	public static string LIST_EA = ConfigurationManager.AppSettings["LIST_EA"];
	public static string ICON_NEW = "&nbsp;&nbsp;<img src=/resources/images/icon/ico_new.gif align=absmiddle /> ";
	public static string ICON_NEW2 = "&nbsp;&nbsp;<img src=/hun/images/us/12sky2/launcher/icon_new.gif align=absmiddle /> ";
	public static string ICON_FILE = "&nbsp;&nbsp;<img src=/resources/images/icon/icon_filesave.png align=absmiddle /> ";
	public static int NEW_DAY = 1;

	public static string NAT_CD = "PH";
	public static string NAT_LANG = "en";
	public static Color EDITOR_COLOR = ColorTranslator.FromHtml("#f2f2f2");

	public static string makeURL(Page PAGE, string URL, string[] REMOVE) {
		NameValueCollection post = PAGE.Request.QueryString;
		string tmpURL = null;

		try {
			for ( int i = 0; i < post.Count; i++ ) {
				var remove = false;

				foreach ( string vKey in REMOVE ) {
					if ( post.GetKey(i).Equals(vKey) ) {
						remove = true;
					}
				}
				if ( is_null(post[i]) || remove ) {
					continue;
				}
				if ( is_null(tmpURL) ) {
					tmpURL += "?";
				} else {
					tmpURL += "&";
				}
				tmpURL += post.GetKey(i) + "=" + post[i];
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
		}

		if ( !is_null(tmpURL) ) {
			URL += tmpURL + "&";
		} else {
			URL += "?";
		}

		return URL;
	}

	/*********************************************************************************************************************/
	/* 로그
    /*********************************************************************************************************************/
	public static Exception Log(HttpContext Context, Exception ex) {
		Context.Trace.Write("Exception", "error", ex);
		return new Exception(ex.Message);
	}

	/*********************************************************************************************************************/
	/* 로그 저장
    /*********************************************************************************************************************/
	public static void Save_Log(string msg) {
		string tmpFileTime = "[ " + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + " ";
		tmpFileTime += DateTime.Now.Hour + ":" + DateTime.Now.Minute + ":" + DateTime.Now.Second + " ]";

		FileStream fs = new FileStream(ConfigurationManager.AppSettings["PATH_LOG"] + "ERROR.log", FileMode.OpenOrCreate, FileAccess.ReadWrite);
		StreamWriter w = new StreamWriter(fs);
		w.BaseStream.Seek(0, SeekOrigin.End);

		string tmpStr = tmpFileTime + "\r\n" + msg + "\r\n--------------------------------------------------------------------------------\r\n";

		w.Write(tmpStr);
		w.Flush();
		w.Close();
	}

	/*********************************************************************************************************************/
	/* null 체크
    /*********************************************************************************************************************/
	public static bool is_null(object OBJECT) {
		try {
			if ( OBJECT != null && !OBJECT.Equals("") && !OBJECT.Equals("null") && OBJECT.ToString().Length > 0 ) {
				return false;
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
			return true;
		}

		return true;
	}

	/*********************************************************************************************************************/
	/* POPUP 체크
    /*********************************************************************************************************************/
	public static bool is_pop(Page PAGE) {
		try {
			if ( !is_null(PAGE.Request.QueryString["POP"]) ) {
				if ( PAGE.Request.QueryString["POP"].Equals("Y") ) {
					return true;
				}
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
			return false;
		}

		return false;
	}

	/*********************************************************************************************************************/
	/* null 을 공백으로
    /*********************************************************************************************************************/
	public static string nullToSpace(object OBJECT) {
		try {
			if ( OBJECT != null && !OBJECT.Equals("") && !OBJECT.Equals("null") ) {
				return OBJECT.ToString().Trim();
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
			return "";
		}

		return "";
	}

	/*********************************************************************************************************************/
	/* 페이지 공통 체크
    /*********************************************************************************************************************/
	public static bool is_check(Page PAGE, string[] KEY) {
		bool ret = true;

		try {
			string script = "";

			foreach ( string vKey in KEY ) {
				if ( !is_null(PAGE.Request.QueryString[vKey]) ) {
					continue;
				}

				ret = false;
				script = "alert('error!');";

				if ( is_pop(PAGE) ) {
					script += "self.close();";
				} else {
					script += "history.back();";
				}
			}
			if ( !is_null(script) ) {
				Javascript(PAGE, script);
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
			ret = false;
		}

		return ret;
	}

	// =============================================================================================================
	//													- Javascript -
	// =============================================================================================================
	public static void Javascript(Page PAGE, string script) {
		ScriptManager.RegisterClientScriptBlock(PAGE, PAGE.GetType(), "str", script, true);
	}

	public static void errScript(Page PAGE) {
		string script = "Sorry, the page you requested could not be found!');";

		if ( !is_null(PAGE.Request.QueryString["POP"]) ) {
			if ( PAGE.Request.QueryString["POP"].Equals("Y") ) {
				script += "self.close();";
			}
		} else {
			script += "location.href='/';";
		}

		ScriptManager.RegisterClientScriptBlock(PAGE, PAGE.GetType(), "str", script, true);
	}

	/*********************************************************************************************************************/
	/* 이메일 주소 체크
    /*********************************************************************************************************************/
	public static bool is_mail(string email) {
		bool valid = Regex.IsMatch(email,
			"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
		return valid;
	}

	/*********************************************************************************************************************/
	/* 비밀번호 암호화
    /*********************************************************************************************************************/
	public static string GetMD5Hash(string input) {
		MD5CryptoServiceProvider x = new MD5CryptoServiceProvider();
		byte[] bs = Encoding.UTF8.GetBytes(input);
		StringBuilder s = new StringBuilder();
		bs = x.ComputeHash(bs);

		foreach ( byte b in bs ) {
			s.Append(b.ToString("x2").ToLower());
		}
		string password = s.ToString();

		return password;
	}

	/*********************************************************************************************************************/
	/* 로그인 검사
    /*********************************************************************************************************************/
	public static bool is_login(Page PAGE) {
		try {
			if ( PAGE.Session["USER_ID"] != null && !PAGE.Session["USER_ID"].Equals("") &&
				!PAGE.Session["USER_ID"].Equals("null") ) {
				return true;
			}
			if ( PAGE.Request.Cookies["tmpUSER"] != null ) {
				HttpCookie myCookie = new HttpCookie("tmpUSER") {
					Expires = DateTime.Now.AddDays(-1),
					Domain = COOKIE_DOMAIN
				};
				PAGE.Response.Cookies.Add(myCookie);
			}

			if ( PAGE.Request.Cookies["KJGAMES_BILL"] != null ) {
				HttpCookie myCookie = new HttpCookie("KJGAMES_BILL") {
					Expires = DateTime.Now.AddDays(-1),
					Domain = COOKIE_DOMAIN
				};
				PAGE.Response.Cookies.Add(myCookie);
			}

			foreach ( var httpCookie in PAGE.Request.Cookies.AllKeys.Select(str => PAGE.Response.Cookies[str]).Where(httpCookie => httpCookie != null) ) {
				httpCookie.Expires = DateTime.Now.AddDays(-1);
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
		}
		return false;
	}

	/*********************************************************************************************************************/
	/* 관리자 Level 체크
    /*********************************************************************************************************************/
	public static bool is_admin(Page PAGE) {
		try {
			if ( PAGE.Session["USE_AUTH"] != null && PAGE.Session["USE_AUTH"].Equals("8") ) {
				return true;
			}
		} catch ( Exception ex ) {
			Save_Log(ex.Message);
			return false;
		}

		return false;
	}

	/*********************************************************************************************************************/
	/* 보안
    /*********************************************************************************************************************/
	public static string Base64Encode(string data) {
		try {
			var encData_byte = Encoding.UTF8.GetBytes(data);
			string encodedData = Convert.ToBase64String(encData_byte);

			return encodedData;
		} catch ( Exception e ) {
			Save_Log("Error in base64Encode" + e.Message);
			throw new Exception("Error in base64Encode" + e.Message);
		}
	}

	public static string Base64Decode(string data) {
		try {
			UTF8Encoding encoder = new UTF8Encoding();
			Decoder utf8Decode = encoder.GetDecoder();
			byte[] todecode_byte = Convert.FromBase64String(data);
			int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
			char[] decoded_char = new char[charCount];

			utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
			string result = new string(decoded_char);

			return result;
		} catch ( Exception e ) {
			Save_Log("Error in base64Decode" + e.Message);
			throw new Exception("Error in base64Decode" + e.Message);
		}
	}

	// =============================================================================================================
	//													- 메일발송 -
	// =============================================================================================================
	public static Exception mailTo(string titl, string subject, string TO) {
		try {
			//-------------------------------------------------
			// 메일 메세지 설정
			//-------------------------------------------------
			MailMessage message = new MailMessage {
				From = new MailAddress(E_MAIL_URL),
				Subject = titl,
				IsBodyHtml = true
			};
			message.To.Add(TO);
			message.Body = @"
<div>
    <table width='650' border='0' cellspacing='0' cellpadding='0' bgcolor='#dedede'>
        <thead></thead>
            <colgroup>
                <col width='10px'>		
                <col width='315px'>		
                <col width='315px'>		
                <col width='10px'>
            </colgroup>
        <tbody>
            <tr>
                <td height='60'></td>
                <td>
                    <a href='" + DOMAIN + @"' target='_blank'>
                        <img src='" + DOMAIN +
				@"/resources/images/img/kjgames_logo.png' border='0' alt='KJ GAMES' style='margin-left:10px;'>
                    </a>
                </td>
                <td align='right'></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td colspan='2'>
                    <table width='630' border='0' cellspacing='0' cellpadding='0'>
                        <tbody>
                            <tr>
                                <td bgcolor='#FFFFFF' align='center' style='font-family:verdana;font-size:22px;font-weight:bold;color:#c30;line-height:25px;padding:20px 0'>
                                    <br>Welcom to KJ GAMES!
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor='#FFFFFF'>
                                    <table width='590' border='0' cellspacing='0' cellpadding='0' align='center'>
                                        <tbody>
                                            <tr height='1'>
                                                <td bgcolor='#CCCCCC'></td>
                                            </tr>
                                            <tr>
                                                <td style='padding:50px 20px;font-family:verdana;font-size:12px;line-height:20px'>
                                                    " + subject + @"							
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td colspan='2' align='center'>
                    <table width='580' border='0' cellspacing='0' cellpadding='0'>
                        <tbody>
                            <tr>
                                <td height='20'></td>
                            </tr>
                            <tr>
                                <td align='center' style='font-family:verdana;font-size:10px;color:#363636;line-height:13px'>
                                    You are receiving this e-mail because you indicated you wanted news about special events and offers when you provided your e-mail address to KJ GAMES. Your e-mail address has not been, and will not be, given to any third parties.<br><br>
                                    Copyright (c) <strong>KJ GAMES</strong>, All Rights Reserved.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td></td>	
            </tr>
            <tr>
                <td colspan='4' height='30'></td>
            </tr>
        </tbody>
    </table>
</div>
";

			message.SubjectEncoding = Encoding.Default;
			message.BodyEncoding = Encoding.Default;

			//-------------------------------------------------
			// SMTP를 이용하여 메일을 발송합니다.
			//-------------------------------------------------
			SmtpClient smtp = new SmtpClient(MAIL_SERVER, 25) {
				UseDefaultCredentials = true,
				DeliveryMethod = SmtpDeliveryMethod.Network
			};
			smtp.Send(message); // 작성한 메일메세지를 Smtp로 발송합니다.

			return null;
		}
		catch ( SmtpException ex ) {
			//Trans.Rollback();

			Save_Log(@"[메일 발송 실패]" + @"
error          : " + ex.Message + @"
error          : " + ex);

			throw;
		}
	}

	public static Exception mailFrom(string titl, string subject, string FROM) {
		try {
			//-------------------------------------------------
			// 메일 메세지 설정
			//-------------------------------------------------
			MailMessage message = new MailMessage {
				From = new MailAddress(FROM),
				Subject = titl,
				IsBodyHtml = true
			};
			message.To.Add(E_MAIL_URL);
			message.Body = @"
<div>
    <table width='650' border='0' cellspacing='0' cellpadding='0' bgcolor='#dedede'>
        <thead></thead>
            <colgroup>
                <col width='10px'>		
                <col width='315px'>		
                <col width='315px'>		
                <col width='10px'>
            </colgroup>
        <tbody>
            <tr>
                <td height='60'></td>
                <td>
                    <a href='" + DOMAIN + @"' target='_blank'>
                        <img src='" + DOMAIN +
				@"/resources/images/img/kjgames_logo.png' border='0' alt='KJ GAMES' style='margin-left:10px;'>
                    </a>
                </td>
                <td align='right'></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td colspan='2'>
                    <table width='630' border='0' cellspacing='0' cellpadding='0'>
                        <tbody>
                            <tr>
                                <td bgcolor='#FFFFFF'>
                                    <table width='590' border='0' cellspacing='0' cellpadding='0' align='center'>
                                        <tbody>
                                            <tr height='1'>
                                                <td bgcolor='#CCCCCC'></td>
                                            </tr>
                                            <tr>
                                                <td style='padding:50px 20px;font-family:verdana;font-size:12px;line-height:20px'>
                                                    " + subject + @"							
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td></td>
            </tr>
            <tr>
                <td colspan='4' height='30'></td>
            </tr>
        </tbody>
    </table>
</div>
";

			message.SubjectEncoding = Encoding.Default;
			message.BodyEncoding = Encoding.Default;

			//-------------------------------------------------
			// SMTP를 이용하여 메일을 발송합니다.
			//-------------------------------------------------
			SmtpClient smtp = new SmtpClient(MAIL_SERVER, 25) {
				UseDefaultCredentials = true,
				DeliveryMethod = SmtpDeliveryMethod.Network
			};
			smtp.Send(message); // 작성한 메일메세지를 Smtp로 발송합니다.

			return null;
		}
			//catch (Exception ex)
		catch ( SmtpException ex ) {
			//Trans.Rollback();

			Save_Log(@"[메일 발송 실패]" + @"
error          : " + ex.Message + @"
error          : " + ex);

			throw;
		}
	}

	/*********************************************************************************************************************/
	/* 임시비밀번호 생성
    /*********************************************************************************************************************/
	public static string CreateTempPassword() {
		string[] alpabet = {
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"x",
			"y",
			"z"
		};
		string[] alpabet2 = {
			"A",
			"B",
			"C",
			"D",
			"E",
			"F",
			"G",
			"H",
			"I",
			"J",
			"K",
			"L",
			"M",
			"N",
			"O",
			"P",
			"Q",
			"R",
			"S",
			"T",
			"U",
			"V",
			"X",
			"Y",
			"Z"
		};
		string[] number = {
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9",
			"0"
		};
		string[] special = {
			"!",
			"@",
			"#",
			"$",
			"%",
			"^",
			"&",
			"*"
		};

		Random nalpabet = new Random();
		Random nnumber = new Random();
		Random nspecial = new Random();

		var password = special[nspecial.Next(0, 7)] + alpabet[nalpabet.Next(0, 24)] + alpabet2[nalpabet.Next(0, 24)] +
			alpabet[nalpabet.Next(0, 24)] + number[nnumber.Next(0, 9)] + alpabet2[nalpabet.Next(0, 24)] +
			alpabet[nalpabet.Next(0, 24)] + number[nnumber.Next(0, 9)] + number[nnumber.Next(0, 9)] +
			alpabet[nalpabet.Next(0, 24)] + number[nnumber.Next(0, 9)] + alpabet2[nalpabet.Next(0, 24)] +
			alpabet2[nalpabet.Next(0, 24)] + special[nspecial.Next(0, 7)] + special[nspecial.Next(0, 7)];

		return password;
	}
}
