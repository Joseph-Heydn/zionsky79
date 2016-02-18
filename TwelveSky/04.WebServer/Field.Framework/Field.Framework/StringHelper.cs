/*********************************************************************************
 * Class	: StringHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

using System;
using System.Collections;
using System.Linq;

namespace Field.Framework {
	public class StringHelper {
		// 문자열을 지정된 구간으로 자른다.
		public static string GetStringArea(string values, string split1, string split2) {
			int n1 = values.IndexOf(split1, StringComparison.Ordinal);
			int n2 = values.IndexOf(split2, StringComparison.Ordinal);
			// 구간의 위치를 찾고

			return values.Substring(n1 + split1.Length, (n2 - n1) - split1.Length);
		}

		// 문자열의 실제 길이를 구해주는 함수
		public static int GetStringLength(string pValues) {
			char[] vObj = pValues.ToCharArray();
			int maxB = 0;

			foreach (
				byte oF in from t in vObj
				let oF = (byte) ((t & 0xff00) >> 8)
				let oB = (byte)(t & 0x00ff)
				select oF
			) {
				if ( oF == 0 )
					maxB++;
				else
					maxB += 2;
			}

			return maxB;
		}

		// ArrayList 에담긴 Int 타입에서 콤마로 구분된 문자열 가져오기
		public static string GetStringFromIDArrayList(ArrayList pArray) {
			string sOut = pArray.Cast<int>().Aggregate("", (current, nData) => current + (string.Format("{0}, ", nData)));

			return sOut.Substring(0, sOut.Trim().Length - 1);
		}

		// ArrayList 에담긴 문자열(코드)에서 콤마로 구분된 문자열 가져오기
		public static string GetStringFromCodeArrayList(ArrayList pArray) {
			string sOut = pArray.Cast<string>().Aggregate("", (current, nData) => current + (string.Format("{0}, ", nData)));

			return sOut.Substring(0, sOut.Trim().Length - 1);
		}

		// string 에담긴 Int 콤마로 구분된 문자열을 분석하여 ArrayList로 가져오기
		public static ArrayList GetArrayListFromIDString(String pDataList) {
			ArrayList oOut = new ArrayList();
			string[] sOut = pDataList.Split(',');

			foreach ( string t in sOut ) {
				oOut.Add(Convert.ToInt32(t.Trim()));
			}

			return oOut;
		}

		public static ArrayList GetArrayListFromCodeString(String pCodes) {
			ArrayList oOut = new ArrayList();
			string[] sOut = pCodes.Split(',');

			foreach ( string t in sOut ) {
				oOut.Add(t.Trim());
			}

			return oOut;
		}

		public static string ConvertQuateCodeFromCode(String pCodes) {
			string[] sOut = pCodes.Split(',');
			string oRet = sOut.Aggregate("", (current, t) => current + (string.Format("'{0}', ", t.Trim().Replace("'", ""))));

			return oRet.Substring(0, oRet.Trim().Length - 1);
		}

		public static string ConvertCodeFromQuateCode(String sCodes) {
			return sCodes.Replace("'", "");
		}

		// 문자로된 금액을 포멧형식을 지정하여 반환한다. (ex) 1000 -> 1,000
		public static string ConvertCommaMoneyFromMoney(string sMoney) {
			return string.IsNullOrEmpty(sMoney) ? "" : ConvertCommaMoneyFromMoney(Convert.ToDouble(sMoney.Replace(",", "")));
		}

		public static string ConvertCommaMoneyFromMoney(double mMoney) {
			return String.Format("{0:#,0}", mMoney);
		}
	}
}
