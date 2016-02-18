using System.Web.Services;

using Field.AuthorityAppTier.Dal;

namespace Web.TwelveSky.web {
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.Web.Script.Services.ScriptService]
	public class wsSignUp : WebService {
		private readonly string gConnStr = ConnString.fnGetName("Authority");

		[WebMethod]
		public string fnCheckAccountId(string pAccountId) {
			if ( string.IsNullOrEmpty(pAccountId) ) {
				return "E2";
			}


			uspGetCheckDupAccountId oDTO = new uspGetCheckDupAccountId
			{	pAccountId = pAccountId
			};
			int vReturn = oDTO.fnGetResultInfo(gConnStr);

			return vReturn != 0 ? "E4" : "OK";
		}

		[WebMethod]
		public string fnCheckNickName(string pNickName) {
			if ( string.IsNullOrEmpty(pNickName) ) {
				return "E2";
			}


			uspGetCheckDupNickName oDTO = new uspGetCheckDupNickName
			{	pNickName = pNickName
			};
			int vReturn = oDTO.fnGetResultInfo(gConnStr);

			return vReturn != 0 ? "E4" : "OK";
		}
	}
}
