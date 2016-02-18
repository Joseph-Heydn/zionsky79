/*********************************************************************************
 * Class	: UnicodeHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Text;

namespace Field.Framework {
	public class UnicodeHelper {
		/// <summary>
		/// 시스템의 현재 ANSI 코드 페이지로 인코딩을 한다.
		/// </summary>
		/// <param name="unicodeData"></param>
		/// <returns></returns>
		public static byte[] ToAsciiBytes(string unicodeData) {
			//Encoding.Defualt : 시스템의 현재 ANSI 코드 페이지에 대한 인코딩을 가져옵니다.
			return Encoding.Default.GetBytes(unicodeData);
		}

		public static byte[] ToUnicodeBytes(string unicodeData) {
			return Encoding.Unicode.GetBytes(unicodeData);
		}
	}
}
