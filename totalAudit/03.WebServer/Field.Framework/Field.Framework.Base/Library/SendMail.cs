using System.Net;
using System.Text;
using System.Net.Mail;

public class SendMail {
	private const int C_SMTP_PORT = 587;
	private const string C_SMTP_SERVER = "smart.whoismail.net";
	private const string C_SMTP_ACCUNT = "fullcount@fullcount.co.kr";
	private const string C_SMTP_SENDER = "kjgames15@gmail.com";
	private const string C_SMTP_DISPLY = "KJ Games";
	private const string C_SMTP_PASSWD = "vnfzkdnsxm1*";

	public static void fnSendMail(string pReceiver, string pSubject, string[] pBody) {
		SmtpClient vSmtp = new SmtpClient(C_SMTP_SERVER, C_SMTP_PORT)
		{	Credentials		= new NetworkCredential(C_SMTP_ACCUNT, C_SMTP_PASSWD)
		,	DeliveryMethod	= SmtpDeliveryMethod.Network
		,	EnableSsl		= true
		};

		MailMessage vMessage = fnMailMessage(pReceiver, pSubject, pBody);
/*		object vUserState = vMessage;

		vSmtp.SendCompleted += fnSmtpSendCompleted;
		vSmtp.SendAsync(vMessage, vUserState);
*/		vSmtp.Send(vMessage);
	}

	/// <summary>
	/// 기본적인 메일 메세지를 생성하여 반환합니다.
	/// </summary>
	/// <param name="pReceiver">수 신자 이메일</param>
	/// <param name="pSubject">메일 제목</param>
	/// <param name="pBody">메일 본문</param>
	/// <returns>메일 메세지 객체</returns>
	private static MailMessage fnMailMessage(string pReceiver, string pSubject, string[] pBody) {
		// pBody array
		// 0 : File Path - /email/findAccount.aspx
		WebClient vClient = new WebClient();
		vClient.QueryString.Add("pParam_01"	, pBody[1]);
		vClient.QueryString.Add("pParam_02"	, pBody[2]);
		vClient.QueryString.Add("pParam_03"	, pBody[3]);
		vClient.QueryString.Add("pParam_04"	, pBody[4]);
		string vBodyHtml = vClient.DownloadString(pBody[0]);

		MailMessage oMessage = new MailMessage
		{	From			= new MailAddress(C_SMTP_SENDER, C_SMTP_DISPLY)
		,	SubjectEncoding	= Encoding.UTF8
		,	Subject			= pSubject
		,	BodyEncoding	= Encoding.UTF8
		,	Body			= vBodyHtml
		,	IsBodyHtml		= true
		,	Priority		= MailPriority.Normal
		};
		oMessage.To.Add(new MailAddress(pReceiver));

		return oMessage;
	}

/*	/// <summary>
	/// 비동기 호출 이벤트
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	static void fnSmtpSendCompleted(object sender, AsyncCompletedEventArgs e) {
		SmtpClient smtpClient = (SmtpClient) sender;

		if ( e.Cancelled ) {
			return;
		}
		if ( e.Error != null ) {
			return;
		}

		smtpClient.Dispose();
	}*/
}
