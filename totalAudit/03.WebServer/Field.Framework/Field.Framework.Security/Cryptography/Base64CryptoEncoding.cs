/*********************************************************************************
 * Class    : Base64CryptoEncoding
 * Remarks  :
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Text;

namespace Field.Framework.Security.Cryptography {
	public sealed class Base64CryptoEncoding : CryptoEncoding {
		public Base64CryptoEncoding() {
		}

		public Base64CryptoEncoding(Encoding pEncoding)
			: base(pEncoding) {
		}

		public override string GetEncryptOutput(byte[] pOutput) {
			return Convert.ToBase64String(pOutput);
		}

		public override byte[] GetDecryptInput(string pInput) {
			return Convert.FromBase64String(pInput);
		}
	}
}
