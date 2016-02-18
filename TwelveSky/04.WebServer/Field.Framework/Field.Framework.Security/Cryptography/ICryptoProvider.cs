/*********************************************************************************
 * Class	: ICryptoProvider
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

namespace Field.Framework.Security.Cryptography {
	public interface ICryptoProvider {
		string Password { get; }
		CryptoEncoding CryptoEncoding { get; set; }

		string Encrypt(string pText, string pPassowrd);
		string Decrypt(string pEncyptText, string pPassowrd);
	}
}
