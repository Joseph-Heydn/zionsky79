/*********************************************************************************
 * Class	: CryptoProvider
 * Remarks	:
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public abstract class CryptoProvider : ICryptoProvider {
		protected SymmetricAlgorithm gAlgorithm;
		protected string gPassword;
		protected CryptoEncoding gCryptoEncoding;

		protected CryptoProvider(SymmetricAlgorithm pAlgorithm) {
			gAlgorithm = pAlgorithm;
			gCryptoEncoding = new HexCryptoEncoding();
		}

		protected CryptoProvider(SymmetricAlgorithm pAlgorithm, CryptoEncoding pEncoding) {
			gAlgorithm = pAlgorithm;
			gCryptoEncoding = pEncoding;
		}


		#region ICryptoProvider 멤버
		public string Password {
			get { return gPassword; }
		}

		public CryptoEncoding CryptoEncoding {
			get { return gCryptoEncoding; }
			set {
				if ( value == null ) throw new ArgumentNullException("Crypto"+"Encoding");
				gCryptoEncoding = value;
			}
		}

		public string Encrypt(string pText, string pSecurity) {
			gPassword = pSecurity;

			byte[] vInputBytes = gCryptoEncoding.GetEncryptInput(pText);
			CryptoHelper.GenerateKeyAndIV(ref gAlgorithm, pSecurity);
			ICryptoTransform vCryptoTransform = gAlgorithm.CreateEncryptor();

			try {
				byte[] vOutputBytes = CryptoHelper.GenerateCrypt(vCryptoTransform, vInputBytes, pSecurity);
				return gCryptoEncoding.GetEncryptOutput(vOutputBytes);
			} catch ( CryptographicException ) {
				return "";
			}
		}

		public string Decrypt(string pText, string pSecurity) {
			gPassword = pSecurity;

			byte[] vInputBytes = gCryptoEncoding.GetDecryptInput(pText);
			CryptoHelper.GenerateKeyAndIV(ref gAlgorithm, pSecurity);
			ICryptoTransform vCryptoTransform = gAlgorithm.CreateDecryptor();

			try {
				byte[] vOutputBytes = CryptoHelper.GenerateCrypt(vCryptoTransform, vInputBytes, pSecurity);
				return gCryptoEncoding.GetDecryptOutput(vOutputBytes);
			} catch ( CryptographicException ) {
				return "";
			}
		}
		#endregion
	}
}
