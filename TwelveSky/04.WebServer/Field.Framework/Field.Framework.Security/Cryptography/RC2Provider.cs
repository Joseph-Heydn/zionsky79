/*********************************************************************************
 * Class	: RC2Provider
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class RC2Provider : CryptoProvider {
		public RC2Provider()
			: base(RC2.Create()) {
		}

		public RC2Provider(CryptoEncoding pEncoding)
			: base(RC2.Create(), pEncoding) {
		}
	}
}
