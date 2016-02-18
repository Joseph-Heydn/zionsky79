using System.Text;
using System.Configuration;
using System.Security.Cryptography;

using Field.Framework.Security.Cryptography;

// PasswordManager의 요약 설명입니다.
public class PasswordManager {
	public static string GetPassword(string pAccountId, string pPassword) {
		string oPassword;
		string vHashEnabled = ConfigurationManager.AppSettings["PasswordHashEnabled"].ToLower();  // Site Config 값 읽어오기.

		switch ( vHashEnabled ) {
			case "true":
				oPassword = PasswordHash(pAccountId, pPassword);
				break;
			default:
				oPassword = pPassword;
				break;
		}

		//string oPassword;
		//oPassword = passwordHashEnabled.Equals("Y") ? PasswordHash(pAccountId, pPassword) : pPassword;

		return oPassword;
	}

	/*********************************************************************************************************************/
	/* 비밀번호 암호화
	/*********************************************************************************************************************/
	public static string GetPassword(string pText) {
		StringBuilder oResult = new StringBuilder();
		MD5CryptoServiceProvider vCrypt = new MD5CryptoServiceProvider();

		byte[] vEncode = Encoding.UTF8.GetBytes(pText);
		vEncode = vCrypt.ComputeHash(vEncode);

		foreach ( byte vByte in vEncode ) {
			oResult.Append(vByte.ToString("x2").ToLower());
		}

		return oResult.ToString();
	}

	private static string PasswordHash(string pAccountId, string pPassword) {
		return Hashing.Hash(pAccountId + pPassword);
	}
}
