/*********************************************************************************
 * Class	: ICrypto
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
namespace Field.Framework.Security.Cryptography {
	public interface ICrypto {
		CryptoProvider CryptoProvider { get; set; }
		string Encrypt(string pText, string pPassword);
		string Decrypt(string pEncyptText, string pPassword);
	}
}
