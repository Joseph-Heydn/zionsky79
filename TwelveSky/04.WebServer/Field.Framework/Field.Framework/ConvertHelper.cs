/*********************************************************************************
 * Class	: ConvertHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Text.RegularExpressions;

namespace Field.Framework {
	public class ConvertHelper {
		public static string ToHex(byte[] value) {
			if ( value == null ) {
				throw new ArgumentNullException("value");
			}

			return BitConverter.ToString(value).Replace("-", "").ToLower();
		}

		public static string ToHex(bool value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(char value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(int value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(long value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(float value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(double value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(short value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(ushort value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToHex(uint value) {
			byte[] valueBytes = BitConverter.GetBytes(value);
			return ToHex(valueBytes);
		}

		public static string ToBase64String(byte[] value) {
			if ( value == null ) {
				throw new ArgumentNullException("value");
			}

			return Convert.ToBase64String(value);
		}

		public static byte[] HexToBytes(string hexValue) {
			const int baseLength = 2;
			if ( !IsHex(hexValue) ) {
				throw new Exception("Hex string format error");
			}

			int ubound = hexValue.Length / baseLength;
			byte[] bytes = new byte[ubound];

			for ( int i = 0; i < bytes.Length; ++i ) {
				bytes[i] = Convert.ToByte(hexValue.Substring(i * baseLength, baseLength), 16);
			}

			return bytes;
		}

		public static bool IsHex(string hexValue) {
			bool isHex;
			const int baseLength = 2;

			if ( hexValue.Length > 1 ) {
				if ( (hexValue.Length % baseLength) == 0 ) {
					Regex regExp = new Regex("[^a-f0-9]", RegexOptions.IgnoreCase);
					isHex = !(regExp.IsMatch(hexValue));
				} else {
					isHex = false;
				}
			} else {
				isHex = false;
			}

			return isHex;
		}
	}
}
