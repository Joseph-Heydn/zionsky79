/*********************************************************************************
 * Class	: CryptoService
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;

namespace Field.Framework.Security.Cryptography {
	public sealed class CryptoService : Crypto {
		/// <summary>
		/// DESProvider로 CryptoService를 생성한다.
		/// </summary>
		public CryptoService()
			: this(new DESProvider()) {
		}

		/// <summary>
		/// cryptoAlgorithm로 지정한 CryptoProvider로 CryptoService를 생성한다.
		/// </summary>
		/// <param name="pCryptoProvider"></param>
		public CryptoService(CryptoProvider pCryptoProvider)
			: base(pCryptoProvider) {
		}

		/// <summary>
		///
		/// </summary>
		/// <param name="pTypeName">Field.Framework.Security.Cryptography.DESProvider, Field.Framework.Security로 지정하면 DESProvider의 인스턴스를 반환한다.</param>
		/// <returns>typeName에 해당하는 CryptoProvider를 반환한다.</returns>
		public static CryptoProvider CreateProvider(string pTypeName) {
			Type vType = Type.GetType(pTypeName);

			if ( vType == null ) {
				throw new Exception(string.Format("\"{0}\" type is not found.", pTypeName));
			}
			if ( vType.BaseType == null )
				return (CryptoProvider) Activator.CreateInstance(vType);


			Type vProviderType = typeof(CryptoProvider);
			if ( vType.BaseType.BaseType != null && vType.BaseType.BaseType == vProviderType ) {
				throw new Exception(string.Format("\"{0}\" type will not be able to convert in \"{1}\" type.", pTypeName, vProviderType.FullName));
			}
			return (CryptoProvider)Activator.CreateInstance(vType);
		}

		public static CryptoProvider CreateDESProvider() {
			return new DESProvider();
		}

		public static CryptoProvider CreateRC2Provider() {
			return new RC2Provider();
		}

		public static CryptoProvider CreateRijndaelProvider() {
			return new RijndaelProvider();
		}

		public static CryptoProvider CreateTripleDESProvider() {
			return new TripleDESProvider();
		}
	}
}
