/*********************************************************************************
 * Class	: Crypto
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

namespace Field.Framework.Security.Cryptography {
	public abstract class Crypto : ICrypto {
		protected CryptoProvider gCryptoProvider;

		protected Crypto(CryptoProvider pCryptoProvider) {
			gCryptoProvider = pCryptoProvider;
		}

		~Crypto() {
			gCryptoProvider = null;
		}

		public CryptoProvider CryptoProvider {
			get { return gCryptoProvider; }
			set { gCryptoProvider = value; }
		}

		public virtual string Encrypt(string pText, string pKey) {
			return gCryptoProvider.Encrypt(pText, pKey);
		}

		public virtual string Decrypt(string pText, string pKey) {
			return gCryptoProvider.Decrypt(pText, pKey);
		}
	}
}
