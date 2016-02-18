/*********************************************************************************
 * Class    : CookiePackerBase
 * Remarks  : Cookie Packing module base class.
 * History  :
 *
 * Ver	Date		Author			Description
 * 1.0	2013-03-11	Hoon-Sik,Jin	1. Create.
 ********************************************************************************/
using System.Web;

public abstract class CookiePackerBase<T> {
	public abstract T UnPack(string pData);

	public abstract string Pack(T pCookieObj);

	protected virtual string EncodeValue(string pData) {
		return HttpContext.Current.Server.UrlEncode(pData);
	}

	protected virtual string DecodeValue(string pData) {
		return HttpContext.Current.Server.UrlDecode(pData);
	}
}
