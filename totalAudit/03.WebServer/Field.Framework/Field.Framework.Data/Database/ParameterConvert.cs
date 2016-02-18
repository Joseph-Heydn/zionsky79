/*********************************************************************************
 * Class	: ParameterConvert
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;

namespace Field.Framework.Data {
	public class ParameterConvert {
		public static int ToResultCode(object value) {
			int lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = -100;       // Default Error Code
			}

			if ( Int32.TryParse(value.ToString().Trim(), out lResult) ) {
				return (int) value;
			}

			throw new Exception("int object format error");
		}

		public static int ToInt(object value) {
			int lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Int32.TryParse(value.ToString().Trim(), out lResult) ) {
				return Convert.ToInt32(value);
				//return (int)value;
			}

			throw new Exception("int object format error");
		}

		public static long ToLong(object value) {
			long lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Int64.TryParse(value.ToString().Trim(), out lResult) ) {
				return Convert.ToInt64(value);
				//return (int)value;
			}

			throw new Exception("long object format error");
		}

		public static Int16 ToInt16(object value) {
			Int16 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Int16.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Int16) value;
			}

			throw new Exception("Int16 object format error");
		}

		public static Int32 ToInt32(object value) {
			Int32 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Int32.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Int32) value;
			}

			throw new Exception("Int32 object format error");
		}

		public static Int64 ToInt64(object value) {
			Int64 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Int64.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Int64) value;
			}

			throw new Exception("Int64 object format error");
		}

		public static uint ToUInt(object value) {
			uint lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( UInt32.TryParse(value.ToString().Trim(), out lResult) ) {
				return (uint) value;
			}

			throw new Exception("uint object format error");
		}

		public static ulong ToULong(object value) {
			ulong lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( UInt64.TryParse(value.ToString().Trim(), out lResult) ) {
				return (ulong) value;
			}

			throw new Exception("ulong object format error");
		}

		public static UInt16 ToUInt16(object value) {
			UInt16 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( UInt16.TryParse(value.ToString().Trim(), out lResult) ) {
				return (UInt16) value;
			}

			throw new Exception("UInt16 object format error");
		}

		public static UInt32 ToUInt32(object value) {
			UInt32 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( UInt32.TryParse(value.ToString().Trim(), out lResult) ) {
				return (UInt32) value;
			}

			throw new Exception("UInt32 object format error");
		}

		public static UInt64 ToUInt64(object value) {
			UInt64 lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( UInt64.TryParse(value.ToString().Trim(), out lResult) ) {
				return (UInt64) value;
			}

			throw new Exception("UInt64 object format error");
		}

		public static Single ToSingle(object value) {
			Single lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Single.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Single) value;
			}

			throw new Exception("Single object format error");
		}

		public static Double ToDouble(object value) {
			Double lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Double.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Double) value;
			}

			throw new Exception("Double object format error");
		}

		public static Decimal ToDecimal(object value) {
			Decimal lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Decimal.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Decimal) value;
			}

			throw new Exception("Decimal object format error");
		}

		public static DateTime ToDateTime(object value) {
			DateTime lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = DateTime.MinValue.Date;
			}

			if ( DateTime.TryParse(value.ToString().Trim(), out lResult) ) {
				return (DateTime) value;
			}

			throw new Exception("DateTime object format error");
		}

		public static String ToString(object value) {
			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = "";
			}

			return (String) value;
		}

		public static Char ToChar(object value) {
			Char lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = "";
			}

			if ( Char.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Char) value;
			}

			throw new Exception("Char object format error");
		}

		public static Boolean ToBoolean(object value) {
			Boolean lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = false;
			}

			if ( Boolean.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Boolean) value;
			}

			throw new Exception("Boolean object format error");
		}

		public static SByte ToSByte(object value) {
			SByte lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( SByte.TryParse(value.ToString().Trim(), out lResult) ) {
				return (SByte) value;
			}

			throw new Exception("SByte object format error");
		}

		public static Byte ToByte(object value) {
			Byte lResult;

			if ( value.ToString().Trim() == "" || value == DBNull.Value ) {
				value = 0;
			}

			if ( Byte.TryParse(value.ToString().Trim(), out lResult) ) {
				return (Byte) value;
			}

			throw new Exception("Byte object format error");
		}
	}
}
