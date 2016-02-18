using System;
using System.Data;
using System.Web;
using System.Configuration;

using Field.SiteManagerAppTier.Dal;
using Field.TwelveWebAppTier.Dal;

public class MenuList {
	private static readonly string gConnStr = ConnString.fnGetName("SiteManager");
	private static readonly short gSite = Convert.ToInt16(ConfigurationManager.AppSettings["cSiteKey"]);	
	private static readonly byte gLangNo = Convert.ToByte(ConfigurationManager.AppSettings["cLangNo"]);

	// 메뉴 테이블
	public static DataTable fnSetMenuList {
		get {
			DataTable oMenu = (DataTable) HttpContext.Current.Cache["tMenuList"];
			if ( oMenu != null && oMenu.Rows.Count > 1 ) {
				return oMenu;
			}


			KWP00102_SG_WS_MENU_AUTH_LIST_R oDTO = new KWP00102_SG_WS_MENU_AUTH_LIST_R
			{	pType = 0
			,	pSite = gSite
			,	pLangNo = gLangNo
			};
			DataTable vTable = oDTO.fnGetResultSet(gConnStr);
			HttpContext.Current.Cache["tMenuList"] = vTable;

			return vTable;
		}
	}

	// 권한 테이블
	public static DataTable fnSetAuthList {
		get {
			DataTable oAuth = (DataTable) HttpContext.Current.Cache["tAuthList"];
			if ( oAuth != null && oAuth.Rows.Count > 1 ) {
				return oAuth;
			}


			KWP00102_SG_WS_MENU_AUTH_LIST_R oDTO = new KWP00102_SG_WS_MENU_AUTH_LIST_R
			{	pType = 1
			,	pSite = gSite
			,	pLangNo = gLangNo
			};
			DataTable vTable = oDTO.fnGetResultSet(gConnStr);
			HttpContext.Current.Cache["tAuthList"] = vTable;

			return vTable;
		}
	}

	// 메뉴별 권한
	public static DataTable fnSetMenuDetail {
		get {
			DataTable oMenu = (DataTable) HttpContext.Current.Cache["tMenuDetail"];
			if ( oMenu != null && oMenu.Rows.Count > 1 ) {
				return oMenu;
			}


			uspGetFieldMenuList oDTO = new uspGetFieldMenuList
			{	pGameNo = Convert.ToInt32(ConfigValues.EnvText.cGameNo)
			};
			DataTable vTable = oDTO.fnGetResultSet(ConnString.fnGetName("FieldWeb"));
			HttpContext.Current.Cache["tMenuDetail"] = vTable;

			return vTable;
		}
	}

	// 상단 메뉴 테이블 구조 정의
	public static void fnTopMenuStruct(ref DataTable oTable) {
		oTable.Columns.Add("cGroups"	, typeof(int));	
		oTable.Columns.Add("cMenuNo"	, typeof(int));
		oTable.Columns.Add("cAuthNo"	, typeof(int));
		oTable.Columns.Add("cMenuName"	, typeof(string));
		oTable.Columns.Add("cExecUrl"	, typeof(string));
		oTable.Columns.Add("cImage"		, typeof(string));
		oTable.Columns.Add("cIsUsed"	, typeof(bool));
		oTable.Columns.Add("cIsView"	, typeof(bool));
		oTable.Columns.Add("cStep"		, typeof(byte));
		oTable.Columns.Add("cOrderBy"	, typeof(byte));
	}

	// 좌측 메뉴 테이블 구조 정의
	public static void fnLeftMenuStruct(ref DataTable oTable) {
		oTable.Columns.Add("cMenuNo"	, typeof(int));
		oTable.Columns.Add("cAuthNo"	, typeof(int));
		oTable.Columns.Add("cMenuName"	, typeof(string));
		oTable.Columns.Add("cExecUrl"	, typeof(string));
		oTable.Columns.Add("cIsUsed"	, typeof(bool));
		oTable.Columns.Add("cIsView"	, typeof(bool));
		oTable.Columns.Add("cStep"		, typeof(byte));
		oTable.Columns.Add("cOrderBy"	, typeof(byte));
	}

	// 관리 사이트 메뉴 테이블 구조 정의
	public static void fnTableStructure(ref DataTable oTable) {
		oTable.Columns.Add("cGroups"	, typeof(int));
		oTable.Columns.Add("cMenuNo"	, typeof(int));
		oTable.Columns.Add("cMenuName"	, typeof(string));
		oTable.Columns.Add("cExecUrl"	, typeof(string));
		oTable.Columns.Add("cIsUsed"	, typeof(bool));
		oTable.Columns.Add("cIsView"	, typeof(bool));
		oTable.Columns.Add("cStep"		, typeof(byte));
		oTable.Columns.Add("cOrderBy"	, typeof(sbyte));
	}

	// 메뉴 리로드
	public static void fnReloadMenu() {
		HttpContext.Current.Cache.Remove("tMenuList");
	}

	// 권한 리로드
	public static void fnReloadAuth() {
		HttpContext.Current.Cache.Remove("tAuthList");
	}

	// 권한 리로드
	public static void fnReloadDetail() {
		HttpContext.Current.Cache.Remove("tMenuDetail");
	}

	// 메뉴 그룹 확인
	public static int fnGetGroups(string pMenuNo) {
	//	fnReloadMenu();
		DataRow[] oMenuTable = fnSetMenuList.Select($"cAuthNo = {pMenuNo}");
		return oMenuTable.Length == 0 ? 0 : Convert.ToInt32(oMenuTable[0]["cMenuGroup"]);
	}

	// 메뉴 번호 확인
	public static int fnGetMenuNo(string pExecUrl) {
	//	fnReloadMenu();
		DataRow[] oMenuTable = fnSetMenuList.Select($"cExecUrl = '{pExecUrl}'");
		return oMenuTable.Length == 0 ? 0 : Convert.ToInt32(oMenuTable[0]["cMenuNo"]);
	}

	// 메뉴 권한
	public static DataRow[] fnMenuAuthority(int pAuthNo, int pMenuNo) {
	//	fnReloadAuth();
		return fnSetAuthList.Select($"cAuthGroup = {pAuthNo} and cMenuNo = {pMenuNo}");
	}

	// 메뉴 이름 찾기
	public static DataRow[] fnMenuName(string pMenuNo) {
	//	fnReloadDetail();
		return fnSetMenuDetail.Select($"cMenuNo = {pMenuNo}");
	}
}
