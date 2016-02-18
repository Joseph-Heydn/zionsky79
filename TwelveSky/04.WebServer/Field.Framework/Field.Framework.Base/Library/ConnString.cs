/*********************************************************************************
 * Class    : ConnString
 * Remarks  :
 * History  :
 *
 * Ver	Date		Author			Description
 *----	----------	--------------	----------------------------------------------
 * 1.0	2015-02-10	Hoon-Sik,Jin	1.Create
*********************************************************************************
 * 1. [참고] 시스템코드를 UI에서 하드코딩하지 않고 Static Method를 사용합니다.
 * 2. [규칙] 각 메소드명은 중복되지 않습니다.
 * 3. [확장] 차후 XML에서 로드한뒤 캐쉬등록처리 합니다.
 ********************************************************************************/

using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Collections.Generic;

public class ConnString {
	private static Dictionary<string, string> fnConnections {
		get {
			Dictionary<string, string> oTable = (Dictionary<string, string>) HttpContext.Current.Cache["tConnString"];
			if ( oTable != null ) {
				return oTable;
			}


			oTable = WebConfigurationManager.ConnectionStrings.Cast<ConnectionStringSettings>().ToDictionary(
				vSetting => vSetting.Name
			,	vSetting => vSetting.ConnectionString
			);
			HttpContext.Current.Cache["tConnString"] = oTable;

			return oTable;
		}
	}

	// return db connection string
	public static string fnGetName(string pName) {
		string oValue;
		Dictionary<string, string> vTable = fnConnections;

		if ( !vTable.TryGetValue(pName, out oValue) ) {
			oValue = "";
		}

		return oValue;
	}

	// return db name list
	public static List<string> fnConnectionList() {
		Dictionary<string, string> vTable = fnConnections;
		return vTable.Select(vName => vName.Key).ToList();
	}
}
