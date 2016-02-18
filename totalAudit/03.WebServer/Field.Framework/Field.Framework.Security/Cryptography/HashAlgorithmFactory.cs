/*********************************************************************************
 * Class	: HashingAlgorithmFactory
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class HashingAlgorithmFactory {
		private HashingAlgorithmFactory() {
		}

		public static HashAlgorithm CreateHashAlgorithm(HashingAlgorithmTypes pAlgorithm) {
			switch ( pAlgorithm ) {
				case HashingAlgorithmTypes.MD5:
					return new MD5CryptoServiceProvider();
				case HashingAlgorithmTypes.SHA:
					return new SHA1CryptoServiceProvider();
				case HashingAlgorithmTypes.SHA256:
					return new SHA256Managed();
				case HashingAlgorithmTypes.SHA384:
					return new SHA384Managed();
				case HashingAlgorithmTypes.SHA512:
					return new SHA512Managed();
				default:
					return new MD5CryptoServiceProvider();
			}
		}
	}
}
