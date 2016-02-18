/*********************************************************************************
 * Class	: ReValidationHelper
 * History	:
 * Remarks	: 1. 각 타입들의 값을 검증할때 사용한다. (DataConvert -> DB_XXXX_TYPE.cs)
 *			: 2. UI 에서 값을 검증할때 사용한다.
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

using System;
using System.Text.RegularExpressions;

namespace Field.Framework {
	public class ReValidationHelper {
		public static bool REValidate(string RE, string val) {
			Regex oReg = new Regex(RE, RegexOptions.Compiled);
			return oReg.IsMatch(val);
		}

		/// <summary>
		/// ^[\\S]{5,12}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isUserPwd(string val) {
			val = val.Trim();
			return REValidate("^[\\S]{5,12}$", val);
		}

		/// <summary>
		/// ^[\\S]{2,12}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isNickName(string val) {
			val = val.Trim();
			return REValidate("^[\\S]{2,12}$", val);
		}

		/// <summary>
		/// ^[\S]{2,12}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isUserName(string val) {
			val = val.Trim();
			return REValidate("^[\\S]{2,12}$", val);
		}
		/// <summary>
		/// ^[a-zA-Z0-9-]+$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool CommonCode(string val) {
			return REValidate("^[a-zA-Z0-9-]+$", val);
		}

		/// <summary>
		/// ^[\\S\\s]{1,100}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isAnwser(string val) {
			val = val.Trim();
			return REValidate("^[\\S\\s]{1,100}$", val);
		}

		/// <summary>
		/// ^[a-zA-Z0-9-_]+$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool CommonNo(string val) {
			return REValidate("^[a-zA-Z0-9-_]+$", val);
		}

		/// <summary>
		/// 주민등록번호
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool ResidentNo(string val) {
			val = val.Trim();

			switch ( val.Length ) {
				case 6:
					return REValidate("^[0-9]{6}$", val);
				case 0:
					return true;
				default:
					return REValidate("^[0-9]{6}-[0-9]{0,7}$", val);
			}
		}

		/// <summary>
		/// ^[\w\-\,\s]{2,12}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isZipCode(string val) {
			val = val.Trim();
			return REValidate("^[\\w\\-\\,\\s]{2,12}$", val);
		}

		/// <summary>
		/// ^[\\S]{1,}\\@[\\w\\-]{1,}\\.[\\w]{2,}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isEmail(string val) {
			val = val.Trim();
			return REValidate("^[\\S]{1,}\\@[\\w\\-]{1,}\\.[\\w]{2,}$", val);
		}

		/// <summary>
		/// DateTime
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool DateTime(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			switch ( StringHelper.GetStringLength(val) ) {
				case 17:
					return REValidate("^[0-9]{17}$", val);
				case 14:
					return REValidate("^[0-9]{14}$", val);
				case 8:
					return REValidate("^[0-9]{8}$", val);
				default:
					return false;
			}
		}

		// DateTime
		public static bool DateTime(DateTime val) {
			if ( (val >= System.DateTime.MinValue) && (val <= System.DateTime.MaxValue) ) {
				return true;
			}

			return false;
		}

		// Date
		public static bool Date(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			switch ( StringHelper.GetStringLength(val) ) {
				case 8:
					return REValidate("^[0-9]{8}$", val);
				case 17:
					return REValidate("^[0-9]{17}$", val);
				case 14:
					return REValidate("^[0-9]{14}$", val);
				default:
					return false;
			}
		}

		// Time
		public static bool Time(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			switch ( StringHelper.GetStringLength(val) ) {
				case 6:
					return REValidate("^[0-9]{6}$", val);
				case 9:
					return REValidate("^[0-9]{9}$", val);
				default:
					return false;
			}
		}

		/// <summary>
		/// ^[\\d]{4}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isYear(string val) {
			val = val.Trim();
			return REValidate("^[\\d]{4}$", val);
		}

		/// <summary>
		/// ^(0[1-9]{1})|(1[0-2]{1})$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isMonth(string val) {
			val = val.Trim();
			return REValidate("^(0[1-9]{1})|(1[0-2]{1})$", val);
		}

		/// <summary>
		/// ^([0-2]{1}[\d]{1})|(3[0-1]{1})$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool isDay(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			return REValidate("^([0-2]{1}[\\d]{1})|(3[0-1]{1})$", val);
		}

		/// <summary>
		/// ^[0-9]{6}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool YearMonth(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			return REValidate("^[0-9]{6}$", val);
		}

		/// <summary>
		/// ^[0-9]{4}$
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool HourMin(string val) {
			val = val.Trim();

			if ( val.Length == 0 )
				return true;

			return REValidate("^[0-9]{4}$", val);
		}

		/// <summary>
		/// 숫자형 (DOUBLE)
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool Double(string val) {
			if ( val.Trim() == "" )
				return true;

			try {
				double temp = Convert.ToDouble(val);
				return true;
			} catch {
				return false;
			}
			//return REValidate("^[+-]?\\d+(\\.\\d+)?$",val);
		}

		/// <summary>
		/// 보너스형 (DOUBLE)
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool Bonus(string val) {
			if ( val.Trim() == "" )
				return true;

			try {
				double temp = Convert.ToDouble(val);
				return true;
			} catch {
				return false;
			}
			//return REValidate("^[+-]?\\d+(\\.\\d+)?$",val);
		}

		/// <summary>
		/// 확률형 (DOUBLE)
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool Percent(string val) {
			if ( val.Trim() == "" )
				return true;

			try {
				// %는 제외
				string val1 = val.Replace("%", "");
				double temp = Convert.ToDouble(val1);
				return true;
			} catch {
				return false;
			}
			//return REValidate("^[+-]?\\d+(\\.\\d+)?$",val);
		}

		/// <summary>
		/// 돈형 (DOUBLE)
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool Money(string val) {
			try {
				// \은 제외
				string val1 = val.Replace("\\", "");
				string val2 = val1.Replace(",", "");
				double temp = Convert.ToDouble(val2);
				return true;
			} catch {
				return false;
			}
			//return REValidate("^[+-]?\\d+(\\.\\d+)?$",val);
		}

		/// <summary>
		/// 숫자형
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static bool ID(string val) {
			try {
				int temp = Convert.ToInt32(val);
				return true;
			} catch {
				return false;
			}
		}

		// SQLTYPE => UniqueID (36자리 고유번호)
		public static bool UniqueID2(string val) {
			return StringHelper.GetStringLength(val) <= 36;
		}

		/// <summary>
		/// 대만 주민등록 번호 체크
		/// </summary>
		/// <param name="val">주민번호</param>
		/// <returns></returns>
		public static bool zhTW_Resident(string val) {
			if ( !REValidate("^[a-zA-Z]{1}(1|2)[\\d]{8}$", val) )
				return false;


			string vResident = zhTW_ResidentNum(val.Substring(0, 1)) + val.Substring(1, 9);
			int vResidentKey = Convert.ToInt16(val.Substring(9, 1));
			int vResidentSum = Convert.ToInt16(vResident.Substring(0, 1));

			for ( int i = 1; i < 10; ++i ) {
				int vResidentTmp = Convert.ToInt16(vResident.Substring(i, 1));
				vResidentSum += vResidentTmp * (10 - i);
			}

			bool oResidentResult = (10 - (vResidentSum % 10)) == vResidentKey;

			return oResidentResult;
		}

		private static string zhTW_ResidentNum(string v) {
			int oResult = 0;

			switch ( v.ToUpper() ) {
				case "A": oResult = 10; break;
				case "B": oResult = 11; break;
				case "C": oResult = 12; break;
				case "D": oResult = 13; break;
				case "E": oResult = 14; break;
				case "F": oResult = 15; break;
				case "G": oResult = 16; break;
				case "H": oResult = 17; break;
				case "I": oResult = 34; break;
				case "J": oResult = 18; break;
				case "K": oResult = 19; break;
				case "L": oResult = 20; break;
				case "M": oResult = 21; break;
				case "N": oResult = 22; break;
				case "O": oResult = 35; break;
				case "P": oResult = 23; break;
				case "Q": oResult = 24; break;
				case "R": oResult = 25; break;
				case "S": oResult = 26; break;
				case "T": oResult = 27; break;
				case "U": oResult = 28; break;
				case "V": oResult = 29; break;
				case "W": oResult = 32; break;
				case "X": oResult = 30; break;
				case "Y": oResult = 31; break;
				case "Z": oResult = 33; break;
			}

			return oResult.ToString("D");
		}
	}
}
