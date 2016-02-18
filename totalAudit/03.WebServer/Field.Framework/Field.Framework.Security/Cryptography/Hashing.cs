/*********************************************************************************
 * Class	: Hashing
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Security.Cryptography;

namespace Field.Framework.Security.Cryptography {
	public class Hashing {
		private Hashing() {}
		// 기본 해시 알고리즘 타입
		public static readonly HashingAlgorithmTypes gDefaultAgorithm = HashingAlgorithmTypes.SHA256;


		#region public method
		/// <summary>
		/// 입력한 데이터를 기본 해시 알고리즘(MD5)으로 해시한다.
		/// </summary>
		/// <param name="pText">해시할 데이터</param>
		/// <returns></returns>
		public static string Hash(string pText) {
			return Hash(pText, gDefaultAgorithm);
		}

		/// <summary>
		/// 입력한 데이터를 지정한 해시 알고리즘으로 해시한다.
		/// </summary>
		/// <param name="pRawData">해시할 데이터</param>
		/// <param name="pAlgorithm">해시 알고리즘</param>
		/// <returns></returns>
		public static string Hash(string pRawData, HashingAlgorithmTypes pAlgorithm) {
			return ConvertOutput(ComputeHashToBytes(pRawData, pAlgorithm));
		}

		public static bool Compare(string pTarget, string pHashed) {
			string inputHashed = Hash(pTarget);
			return inputHashed.Equals(pHashed);
		}

		public static bool Compare(string pTarget, string pHashed, HashingAlgorithmTypes pAlgorithm) {
			string inputHashed = Hash(pTarget, pAlgorithm);
			return inputHashed.Equals(pHashed);
		}
		#endregion


		#region private method
		private static string ConvertOutput(byte[] pOutput) {
			if ( pOutput == null ) {
				throw new ArgumentNullException("pOutput");
			}

			return ConvertHelper.ToHex(pOutput);
		}

		private static byte[] ComputeHashToBytes(string pRawData, HashingAlgorithmTypes pAlgorithm) {
			byte[] vInputBytes = UnicodeHelper.ToAsciiBytes(pRawData);
			HashAlgorithm vHash = HashingAlgorithmFactory.CreateHashAlgorithm(pAlgorithm);
			return vHash.ComputeHash(vInputBytes);
		}
		#endregion
	}
}
