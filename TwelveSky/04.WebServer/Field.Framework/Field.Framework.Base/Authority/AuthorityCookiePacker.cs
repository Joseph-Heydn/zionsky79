using System;
using System.Collections;
using System.Linq;
using System.Text;

public sealed class AuthorityCookiePacker : CookiePackerBase<AuthAccountInfo> {
	private static readonly AuthorityCookiePacker gInstance = new AuthorityCookiePacker();

	private AuthorityCookiePacker() {
	}

	public static AuthorityCookiePacker GetInstance() {
		return gInstance;
	}

	public override AuthAccountInfo UnPack(string pAuthCookieString) {
		const char C_ROW_SEP = '&';
		const char C_COL_SEP = '=';

		Hashtable vHT = new Hashtable();
		string[] vNameValues = pAuthCookieString.Split(C_ROW_SEP);

		foreach ( string[] vItem in vNameValues.Select(vNameValue => vNameValue.Split(C_COL_SEP)) ) {
			switch ( vItem.Length ) {
				case 1:
					vHT.Add(vItem[0], "");
					break;
				case 2:
					vHT.Add(vItem[0], vItem[1]);
					break;
			}
		}


		AuthAccountInfo oAdminInfo = new AuthAccountInfo();
		if ( vHT.Contains(AuthAccountInfo.cKEY_FIELD_ACCTNO) ) {
			oAdminInfo.pAccountNo = Convert.ToInt32(DecodeValue(vHT[AuthAccountInfo.cKEY_FIELD_ACCTNO].ToString()));
		}
		if ( vHT.Contains(AuthAccountInfo.cKEY_FIELD_ACCTID) ) {
			oAdminInfo.pAccountId = DecodeValue(vHT[AuthAccountInfo.cKEY_FIELD_ACCTID].ToString());
		}
		if ( vHT.Contains(AuthAccountInfo.cKEY_FIELD_ACCTNM) ) {
			oAdminInfo.pAccountNm = DecodeValue(vHT[AuthAccountInfo.cKEY_FIELD_ACCTNM].ToString());
		}
		if ( vHT.Contains(AuthAccountInfo.cKEY_FIELD_AUTHNO) ) {
			oAdminInfo.pAuthrity = Convert.ToInt32(DecodeValue(vHT[AuthAccountInfo.cKEY_FIELD_AUTHNO].ToString()));
		}
		if ( vHT.Contains(AuthAccountInfo.cKEY_FIELD_EMAILS) ) {
			oAdminInfo.pEmail = DecodeValue(vHT[AuthAccountInfo.cKEY_FIELD_EMAILS].ToString());
		}

		return oAdminInfo;
	}

	public override string Pack(AuthAccountInfo pAuthAccountInfo) {
		const string vTmp = "{0}={1}&";
		StringBuilder oAuthCookies = new StringBuilder();

		oAuthCookies.AppendFormat
		(	vTmp
		,	AuthAccountInfo.cKEY_FIELD_ACCTNO
		,	EncodeValue(pAuthAccountInfo.pAccountNo.ToString())
		);

		oAuthCookies.AppendFormat
		(	vTmp
		,	AuthAccountInfo.cKEY_FIELD_ACCTID
		,	EncodeValue(pAuthAccountInfo.pAccountId)
		);

		oAuthCookies.AppendFormat
		(	vTmp
		,	AuthAccountInfo.cKEY_FIELD_ACCTNM
		,	EncodeValue(pAuthAccountInfo.pAccountNm)
		);

		oAuthCookies.AppendFormat
		(	vTmp
		,	AuthAccountInfo.cKEY_FIELD_AUTHNO
		,	EncodeValue(pAuthAccountInfo.pAuthrity.ToString())
		);

		oAuthCookies.AppendFormat
		(	vTmp
		,	AuthAccountInfo.cKEY_FIELD_EMAILS
		,	EncodeValue(pAuthAccountInfo.pEmail)
		);

		return oAuthCookies.ToString();
	}
}
