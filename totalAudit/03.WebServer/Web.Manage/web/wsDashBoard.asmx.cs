using System;
using System.Data;
using System.Web.Services;

using Field.Framework;
using Field.AuditAppTier.Dal;

namespace Web.Manage.web {
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.Web.Script.Services.ScriptService]
	public class wsDashBoard : WebService {
		readonly string gConnStr = ConnString.fnGetName("OnAuditWeb");

		// 메인화면 대시보드
		[WebMethod]
		public string fnLoadDashBoard(string pInstence, string pStartDay) {
			uspGetDashBoard oDTO = new uspGetDashBoard
			{	pInstence = pInstence
			,	pStartDay = Convert.ToDateTime(pStartDay)
			};
			DataSet vResultSet = oDTO.fnGetResultSet(gConnStr);

			return Extends.GetJsonString(vResultSet);
		}
	}
}
