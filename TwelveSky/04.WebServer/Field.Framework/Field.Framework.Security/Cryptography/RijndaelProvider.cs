/*********************************************************************************
 * Class	: RijndaelProvider
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class RijndaelProvider : CryptoProvider {
		public RijndaelProvider()
			: base(Rijndael.Create()) {
		}

		public RijndaelProvider(CryptoEncoding pEncoding)
			: base(Rijndael.Create(), pEncoding) {
		}
	}
}
