using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Web.TwelveSky.App_Common {
	public partial class ucHeader : UserControl {
		protected readonly string C_LANG_CODE = ConfigValues.EnvText.cLangCode;
		protected int gMenuCnt = 1;
		private byte gBoardType = 0;
		private DataTable gMenuList;

		protected void Page_Load(object sender, EventArgs e) {
			try {
				masters vMaster = (masters) Page.Master;
				vMaster?.fnSetSelected();

				fnDisplayMenu();
			} catch ( Exception ex ) {
				masters vMaster = (masters) Page.Master;
				vMaster?.fnWriterLog(ex);
			}
		}


		#region binding layer
		// 상단 메뉴
		private void fnDisplayMenu() {
			AuthAccountInfo vAuthInfo = AuthorityManager.GetAuthAccountInfo();
			DataTable vMenuList = MenuList.fnSetMenuList;
			DataTable vAuthList = MenuList.fnSetAuthList;

			var vMenuTable = (
				from DataRow a in vMenuList.Rows
				join DataRow b in vAuthList.Rows
					on	a.Field<int>("cMenuNo") equals b.Field<int>("cMenuNo")
				where	b.Field<int>("cAuthGroup") == vAuthInfo.pAuthrity
				orderby a.Field<byte>("cOrderBy1")
					,	a.Field<byte>("cOrderBy2")
				select new {
						cGroups		= a.Field<int>("cMenuGroup")
					,	cMenuNo		= a.Field<int>("cMenuNo")
					,	cAuthNo		= a.Field<int>("cAuthNo")
					,	cMenuName	= a.Field<string>("cMenuName")
					,	cExecUrl	= a.Field<string>("cExecUrl")
					,	cImage		= a.Field<string>("cImageUrl")
					,	cIsUsed		= a.Field<bool>("cIsUsed")
					,	cIsView		= a.Field<bool>("cIsView")
					,	cStep		= a.Field<byte>("cStep")
					,	cOrderBy	= a.Field<byte>("cOrderBy2")
				}
			);


			gMenuList = new DataTable();
			MenuList.fnTopMenuStruct(ref gMenuList);

			foreach ( var vRow in vMenuTable ) {
				gMenuList.Rows.Add
				(	vRow.cGroups
				,	vRow.cMenuNo
				,	vRow.cAuthNo
				,	vRow.cMenuName
				,	vRow.cExecUrl
				,	vRow.cImage
				,	vRow.cIsUsed
				,	vRow.cIsView
				,	vRow.cStep
				,	vRow.cOrderBy
				);
			}


			string vMenuNo = Request.QueryString["m"];
			if ( !string.IsNullOrEmpty(vMenuNo) ) {
				DataRow[] vMenuInfo = MenuList.fnMenuName(vMenuNo);
				gBoardType = Convert.ToByte(vMenuInfo[0]["cType"]);
			}

			DataRow[] vCategory = gMenuList.Select("cOrderBy = 0 and cIsUsed = 1 and cIsView = 1 and cImage <> ''");
			repParent.DataSource = vCategory;
			repParent.DataBind();
		}

		// 이미지 출력
		protected string fnPrintImage(object pImageUrl, bool pMouseOver) {
			string vImage = $"/_common/_images/img/{C_LANG_CODE}/{pImageUrl}";
			return pMouseOver ? vImage.Replace(".png","_on.png") : vImage;
		}

		// 선택된 메뉴 하이라이트 class 추가
		protected string fnSelected(object pExecUrl) {
			masters vMaster = (masters) Page.Master;
			return vMaster != null ? vMaster.fnSelected(pExecUrl, gBoardType) : "";
		}

		// 결제 사이트 주소
		protected string fnGetBillingUrl() {
			string vNatCode = ConfigurationManager.AppSettings["cNatCode"];
			return string.Format(ConfigurationManager.AppSettings["wBillURL"], vNatCode);
		}
		#endregion binding layer


		#region control layer
		// 하위 메뉴
		protected void OnCategoryMenuBound(object sender, RepeaterItemEventArgs e) {
			Repeater rptChild = e.Item.FindControl("repChild") as Repeater;

			if ( rptChild == null ) {
				return;
			}


/** Table structure
 * 0: cGroups
 * 1: cMenuNo
 * 2: cAuthNo
 * 3: cMenuName
 * 4: cExecUrl
 * 5: cImage
 * 6: cIsUsed
 * 7: cIsView
 * 8: cStep
 * 9: cOrderBy
**/
			object vGroups = DataBinder.Eval(e.Item.DataItem, "[0]");
			DataRow[] vMenuInfo = gMenuList.Select($"cGroups = {vGroups} and cOrderBy > 0 and cIsUsed = 1 and cIsView = 1 and cStep = 0");

			rptChild.DataSource = vMenuInfo;
			rptChild.DataBind();
		}
		#endregion control layer
	}
}
