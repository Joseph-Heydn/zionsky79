using Field.SiteManagerAppTier.Dal;

public class AuthLoginAccount {
	// 로그인
	public static int fnLoginAccount(string pAccountId, string pPassword, string pHostIp, string pConnStr) {
		KWP00103_SG_WS_ADMIN_LOGIN_R oDTO = new KWP00103_SG_WS_ADMIN_LOGIN_R
		{	pAdminId	= pAccountId
		,	pPassword	= pPassword
		};
		int oReturnNo = oDTO.fnGetResultInfo(pConnStr);

		if ( oReturnNo != 0 ) {
			AuthorityManager.ClearCookie();
			return oReturnNo;
		}


		// 로그인 후 쿠키에 담는다.
		AuthAccountInfo vAccountInfo = new AuthAccountInfo
		{	pAccountNo	= oDTO.oAdminNo
		,	pAccountId	= oDTO.pAdminId
		,	pAccountNm	= oDTO.oAdminName
		,	pAuthrity	= oDTO.oAuthGroup
		};
		AuthorityManager.SetAuthAccountInfo(vAccountInfo);


		return oReturnNo;
	}
}
