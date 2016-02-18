/*********************************************************************************
 * Class	: CryptoAlgorithmHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.IO;
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	internal static class CryptoHelper {
		private readonly static byte[] gSalt = { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 };

		public static void GenerateKeyAndIV(ref SymmetricAlgorithm pAlgorithm, string pPassword) {
			if ( pAlgorithm == null ) {
				throw new ArgumentNullException("pAlgorithm");
			}


			PasswordDeriveBytes vDerive = new PasswordDeriveBytes(pPassword, gSalt);
			pAlgorithm.Key = vDerive.GetBytes(pAlgorithm.KeySize / 8);
			pAlgorithm.IV = vDerive.GetBytes(pAlgorithm.BlockSize / 8);
		}

		/// <summary>
		///
		/// </summary>
		/// <param name="pTransform"></param>
		/// <param name="pInputBytes"></param>
		/// <param name="pPassword"></param>
		/// <returns></returns>
		/// <exception>ArgumentNullException</exception>
		/// <exception>CryptographicException</exception>
		/// <exception>Exception</exception>
		public static byte[] GenerateCrypt(ICryptoTransform pTransform, byte[] pInputBytes, string pPassword) {
			if ( pTransform == null ) {
				throw new ArgumentNullException("pTransform");
			}
			if ( pInputBytes == null ) {
				throw new ArgumentNullException("pInputBytes");
			}


			MemoryStream oPutStream = new MemoryStream();
			CryptoStream vCryptStream = new CryptoStream(oPutStream, pTransform, CryptoStreamMode.Write);

			try {
				vCryptStream.Write(pInputBytes, 0, pInputBytes.Length);
				vCryptStream.FlushFinalBlock();

				return oPutStream.ToArray();
			} catch ( CryptographicException ) {
				throw;
			} catch ( Exception e ) {
				throw new Exception(string.Format("Error in symmetric engine. Error : {0}", e.Message), e);
			} finally {
				vCryptStream.Close();
				oPutStream.Close();
			}
		}
	}
}
