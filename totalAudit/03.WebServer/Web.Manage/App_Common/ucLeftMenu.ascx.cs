using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Manage.App_Common {
	public partial class ucLeftMenu : UserControl {
		private DataTable gMenuList;
		private int gOrder;
		private readonly string[] gIconList = {"fa-gears", "fa-server", "fa-database", "fa-object-group", "fa-edit"};

		protected void Page_Load(object sender, EventArgs e) {
			try {
				fnDisplayMenu();
			} catch ( Exception ex ) {
				masters vMaster = (masters) Page.Master;
				vMaster?.fnWriterLog(ex);
			}
		}


		#region binding layer
		// 메뉴 출력
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
					,	cMenuName	= a.Field<string>("cMenuName")
					,	cExecUrl	= a.Field<string>("cExecUrl")
					,	cIsUsed		= a.Field<bool>("cIsUsed")
					,	cIsView		= a.Field<bool>("cIsView")
					,	cStep		= a.Field<byte>("cStep")
					,	cOrderBy	= a.Field<byte>("cOrderBy2")
				}
			);


			gMenuList = new DataTable();
			MenuList.fnTableStructure(ref gMenuList);

			foreach ( var vRow in vMenuTable ) {
				gMenuList.Rows.Add
				(	vRow.cGroups
				,	vRow.cMenuNo
				,	vRow.cMenuName
				,	vRow.cExecUrl
				,	vRow.cIsUsed
				,	vRow.cIsView
				,	vRow.cStep
				,	vRow.cOrderBy
				);
			}


			DataRow[] vCategory = gMenuList.Select("cOrderBy = 0 and cIsUsed = 1 and cIsView = 1");
			repParent.DataSource = vCategory;
			repParent.DataBind();
		}

		// 대메뉴 아이콘
		protected string fnPrintIcon() {
			return gIconList[gOrder++];
		}

		// 메뉴 그룹 하이라이트 class 추가
		protected string fnSelectedGroup(object pGroup) {
			string vGroup = Request.QueryString["g"];
			return vGroup == pGroup.ToString() ? " active" : "";
		}

		// 선택된 메뉴 하이라이트 class 추가
		protected string fnSelected(object pExecUrl) {
			masters vMaster = (masters) Page.Master;
			return vMaster != null ? vMaster.fnSelected(pExecUrl) : "";
		}
		#endregion binding layer


		#region control layer
		protected void OnCategoryMenuBound(object sender, RepeaterItemEventArgs e) {
			Repeater repChild = e.Item.FindControl("repChild") as Repeater;

			if ( repChild == null ) {
				return;
			}


/** Table structure
 * 0: cGroups
 * 1: cMenuNo
 * 2: cMenuName
 * 3: cExecUrl
 * 4: cUsing
 * 5: cOrderBy
**/
			int vGroups = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "[0]"));
			DataRow[] vMenuInfo = gMenuList.Select($"cGroups = {vGroups} and cOrderBy > 0 and cIsUsed = 1 and cIsView = 1 and cStep = 0");

			repChild.DataSource = vMenuInfo;
			repChild.DataBind();
		}
		#endregion control layer
	}
}
