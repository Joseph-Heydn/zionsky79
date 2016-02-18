/*********************************************************************************
 * Class	: TripleDESProvider
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class TripleDESProvider : CryptoProvider {
		public TripleDESProvider()
			: base(TripleDES.Create()) {
		}

		public TripleDESProvider(CryptoEncoding pEncoding)
			: base(TripleDES.Create(), pEncoding) {
		}
	}
}
