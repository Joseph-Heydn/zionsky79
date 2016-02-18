/*********************************************************************************
 * Class	: DESProvider
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class DESProvider : CryptoProvider {
		public DESProvider()
			: base(DES.Create()) {
		}

		public DESProvider(CryptoEncoding pEncoding)
			: base(DES.Create(), pEncoding) {
		}
	}
}
