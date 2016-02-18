public class AuthAccountInfo {
	public static readonly string cFIELD_CLASS = "AuthAccountInfo";
	public static readonly string cKEY_FIELD_ACCTNO = "FIELD_ACCTNO";
	public static readonly string cKEY_FIELD_ACCTID = "FIELD_ACCTID";
	public static readonly string cKEY_FIELD_ACCTNM = "FIELD_ACCTNM";
	public static readonly string cKEY_FIELD_AUTHNO = "FIELD_AUTHNO";
	public static readonly string cKEY_FIELD_EMAILS = "FIELD_EMAILS";

	public AuthAccountInfo() {
		pAccountNo	= 0;
		pAuthrity	= 2001010;

		pAccountId	= "";
		pAccountNm	= "";
		pEmail		= "";
	}


	#region initialize
	public long pAccountNo { get; set; }
	public int pAuthrity { get; set; }
	public string pAccountId { get; set; }
	public string pAccountNm { get; set; }
	public string pEmail { get; set; }
	#endregion initialize
}
