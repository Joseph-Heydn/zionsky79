/*********************************************************************************
 * Class    : AuthorityCookieCrypto
 * Remarks  : Authority cookie crypt module.
 * History  :
 *
 * Ver	Date		Author			Description
 * 1.0	2013-03-11	Hoon-Sik,Jin	1. Create.
 ********************************************************************************/

using System;
using System.Configuration;

using Field.Framework.Security.Cryptography;

public sealed class AuthorityCookieCrypto {
	private static readonly AuthorityCookieCrypto gInstance = new AuthorityCookieCrypto();
	private AuthorityCookieSettings gSettings = new AuthorityCookieSettings();
	private CryptoProvider gCryptoProvider;

	private AuthorityCookieCrypto() {
		ReadSettings();
		CreateCryptoProvider(gSettings.CryptoProvider);
	}

	private void ReadSettings() {
		string vCryptoProvider = ConfigurationManager.AppSettings[AuthorityCookieSettingsKey.CryptoProvider];
		string vPassword = ConfigurationManager.AppSettings[AuthorityCookieSettingsKey.CryptoPassword];

		if ( string.IsNullOrEmpty(vPassword) )
			throw new Exception($"{AuthorityCookieSettingsKey.CryptoPassword} not found.(Web.Config<AppSettings>)");


		gSettings.Password = vPassword;
		gSettings.CryptoProvider = vCryptoProvider;
	}

	private void CreateCryptoProvider(string pCryptoProvider) {
		gCryptoProvider = CryptoService.CreateProvider(pCryptoProvider);
	}

	public static AuthorityCookieCrypto GetInstance() {
		return gInstance;
	}

	public string Encrypt(string pCookieData) {
		return gCryptoProvider.Encrypt(pCookieData, gSettings.Password);
	}

	public string Decypt(string pCookieData) {
		return gCryptoProvider.Decrypt(pCookieData, gSettings.Password);
	}

	public CryptoProvider CryptoProvider {
		get { return gCryptoProvider; }
		set { gCryptoProvider = value; }
	}

	public AuthorityCookieSettings Settings {
		get { return gSettings; }
		set { gSettings = value; }
	}
}

public sealed class AuthorityCookieSettings {
	private string pPassword = "P@ssw0rd";
	private string pCryptoProvider = "";

	public string Password {
		get { return pPassword; }
		set { pPassword = value; }
	}

	public string CryptoProvider {
		get { return pCryptoProvider; }
		set { pCryptoProvider = value; }
	}
}

public sealed class AuthorityCookieSettingsKey {
	public static readonly string CryptoPassword = "AuthorityCookieCrypto_CryptoPassword";
	public static readonly string CryptoProvider = "AuthorityCookieCrypto_CryptoProvider";
}
