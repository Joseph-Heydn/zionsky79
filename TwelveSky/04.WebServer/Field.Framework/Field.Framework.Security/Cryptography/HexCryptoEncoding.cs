/*********************************************************************************
 * Class	: CryptoEncoding
 * Remarks	:
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Text;

namespace Field.Framework.Security.Cryptography {
	public sealed class HexCryptoEncoding : CryptoEncoding {
		public HexCryptoEncoding() {
		}

		public HexCryptoEncoding(Encoding pEncoding)
			: base(pEncoding) {
		}

		public override string GetEncryptOutput(byte[] pOutput) {
			return ConvertHelper.ToHex(pOutput);
		}

		public override byte[] GetDecryptInput(string pInput) {
			return ConvertHelper.HexToBytes(pInput);
		}
	}
}
