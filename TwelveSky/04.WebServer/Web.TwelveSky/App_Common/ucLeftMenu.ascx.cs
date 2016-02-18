using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Web.TwelveSky.App_Common {
	public partial class ucLeftMenu : UserControl {
		private DataTable gMenuList;
		private byte gBoardType;

		protected void Page_Load(object sender, EventArgs e) {
			try {
				string vBaseUrl = Request.ServerVariables["url"].Replace("index.aspx", "");

				if ( vBaseUrl == "/" ) {
					return;
				}


				masters vMaster = (masters) Page.Master;
				vMaster?.fnSetSelected();

				fnDisplayMenu();
			} catch ( Exception ex ) {
				masters vMaster = (masters) Page.Master;
				vMaster?.fnWriterLog(ex);
			}
		}


		#region binding layer
		private void fnDisplayMenu() {
			AuthAccountInfo vAuthInfo = AuthorityManager.GetAuthAccountInfo();
			DataTable vMenuList = MenuList.fnSetMenuList;
			DataTable vAuthList = MenuList.fnSetAuthList;

			string vMenuNo = Request.QueryString["m"];
			int vGroups = MenuList.fnGetGroups(vMenuNo);

			if ( vGroups == 0 || string.IsNullOrEmpty(vMenuNo) ) {
				return;
			}


			DataRow[] vMenuInfo = MenuList.fnMenuName(vMenuNo);
			lblGroup.Text = vMenuInfo[0]["cFolder"].ToString();
			gBoardType = Convert.ToByte(vMenuInfo[0]["cType"]);

			var vMenuTable = (
				from DataRow a in vMenuList.Rows
				join DataRow b in vAuthList.Rows
					on	a.Field<int>("cMenuNo") equals b.Field<int>("cMenuNo")
				where	b.Field<int>("cAuthGroup") == vAuthInfo.pAuthrity
					&&	a.Field<int>("cMenuGroup") == vGroups
				orderby a.Field<byte>("cOrderBy1")
					,	a.Field<byte>("cOrderBy2")
				select new {
						cMenuNo		= a.Field<int>("cMenuNo")
					,	cAuthNo		= a.Field<int>("cAuthNo")
					,	cMenuName	= a.Field<string>("cMenuName")
					,	cExecUrl	= a.Field<string>("cExecUrl")
					,	cIsUsed		= a.Field<bool>("cIsUsed")
					,	cIsView		= a.Field<bool>("cIsView")
					,	cStep		= a.Field<byte>("cStep")
					,	cOrderBy	= a.Field<byte>("cOrderBy2")
				}
			);

			vMenuList.Dispose();
			vAuthList.Dispose();


			gMenuList = new DataTable();
			MenuList.fnLeftMenuStruct(ref gMenuList);

			foreach ( var vRow in vMenuTable ) {
				gMenuList.Rows.Add
				(	vRow.cMenuNo
				,	vRow.cAuthNo
				,	vRow.cMenuName
				,	vRow.cExecUrl
				,	vRow.cIsUsed
				,	vRow.cIsView
				,	vRow.cStep
				,	vRow.cOrderBy
				);
			}


			DataRow[] vCategory = gMenuList.Select("cOrderBy > 0 and cIsUsed = 1 and cIsView = 1 and cStep = 0");
			repParent.DataSource = vCategory;
			repParent.DataBind();
		}

		protected string fnGetBillingUrl() {
			string vNatCode = ConfigurationManager.AppSettings["cNatCode"];
			return string.Format(ConfigurationManager.AppSettings["wBillURL"], vNatCode);
		}

		// 선택된 메뉴 하이라이트 class 추가
		protected string fnSelected(object pExecUrl) {
			masters vMaster = (masters) Page.Master;
			return vMaster != null ? vMaster.fnSelected(pExecUrl, gBoardType) : "";
		}
		#endregion binding layer


		#region control layer
		protected void OnCategoryMenuBound(object sender, RepeaterItemEventArgs e) {
			Repeater rptChild = e.Item.FindControl("repChild") as Repeater;

			if ( rptChild == null ) {
				return;
			}


/** Table structure
 * 0: cMenuNo
 * 1: cAuthNo
 * 2: cMenuName
 * 3: cExecUrl
 * 4: cIsUsed
 * 5: cIsView
 * 6: cStep
 * 7: cOrderBy
**/
			object vStep = DataBinder.Eval(e.Item.DataItem, "[7]");
			DataRow[] vMenuInfo = gMenuList.Select($"cIsUsed = 1 and cIsView = 1 and cStep = {vStep}");

			rptChild.DataSource = vMenuInfo;
			rptChild.DataBind();
		}
		#endregion control layer
	}
}
