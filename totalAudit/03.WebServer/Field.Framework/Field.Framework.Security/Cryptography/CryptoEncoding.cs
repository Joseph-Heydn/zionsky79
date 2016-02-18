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
	public abstract class CryptoEncoding : ICryptoEncoding {
		protected Encoding gEncoding;

		protected CryptoEncoding() {
			gEncoding = new UnicodeEncoding();
		}

		protected CryptoEncoding(Encoding pEncoding) {
			gEncoding = pEncoding;
		}


		#region ICryptoEncoding Members
		public abstract byte[] GetDecryptInput(string pInput);

		public string GetDecryptOutput(byte[] pOutput) {
			return gEncoding.GetString(pOutput);
		}

		public byte[] GetEncryptInput(string pInput) {
			return gEncoding.GetBytes(pInput);
		}

		public abstract string GetEncryptOutput(byte[] pOutput);

		public Encoding Encoding {
			get { return gEncoding; }
		}
		#endregion
	}
}
