using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Audit.App_Common {
	public partial class ucLeftMenu : UserControl {
		private const string C_WEB_RESOURCE = "~/App_Common/ucLeftMenuTable.ascx";
		private DataTable gMenuList;

		protected void Page_Load(object sender, EventArgs e) {
			try {
				DisplayAdminMenu();
			} catch ( Exception ) {
				Response.Redirect(Page.Request.Url.ToString().Replace("index.aspx", ""));
			}
		}


		#region binding layer
		// 메뉴 출력
		private void DisplayAdminMenu() {
			AuthAccountInfo vAuthInfo = AuthorityManager.GetAuthAccountInfo();
			DataTable vMenuList = MenuList.fnSetMenuList;
			DataTable vAuthList = MenuList.fnSetAuthList;

			var vMenuTable = (
				from a in vMenuList.AsEnumerable()
				join b in vAuthList.AsEnumerable()
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
				,	vRow.cOrderBy
				);
			}


			DataRow[] vCategory = gMenuList.Select("cOrderBy = 0");
			rptParent.DataSource = vCategory;
			rptParent.DataBind();
		}

		protected string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}
		#endregion binding layer


		#region control layer
		protected void OnCategoryMenuBound(object sender, RepeaterItemEventArgs e) {
			Repeater rptChild = e.Item.FindControl("rptChild") as Repeater;

			if ( rptChild == null ) {
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
			DataRow[] vMenuInfo = gMenuList.Select($"cGroups = {vGroups} and cOrderBy > 0 and cIsUsed = 1 and cIsView = 1");

			rptChild.DataSource = vMenuInfo;
			rptChild.DataBind();
		}
		#endregion control layer
	}
}
