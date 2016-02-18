using System;
using System.Data;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Audit.site {
	public partial class menuList : BasePage {
		private const string vZero = "0";
		readonly string gConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/menuList.aspx";

			if ( IsPostBack )
				return;


			try {
				fnInitDrpMenuList();
				fnDisplayMenuList();
			} catch ( Exception ex) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}


		#region initialize layer
		// 메뉴 종류 DropDownList에 입력
		protected void fnInitDrpMenuList() {
			if ( txtMenuGrp.Text == "" )
				txtMenuGrp.Text = Convert.ToString("1001");
			if ( txtSiteGrpNo.Text == "" )
				txtSiteGrpNo.Text = Convert.ToString("1001");


			KWP00101_SG_WS_GRP_MENU_DRPDN_R oDTO = new KWP00101_SG_WS_GRP_MENU_DRPDN_R
			{	pSiteGroup	= Convert.ToInt16(txtSiteGrpNo.Text)
			,	pMode		= 2
			};
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			// 검색부분
			drpMenuGrp.DataSource		= vResult;
			drpMenuGrp.DataTextField	= "cGroupName";
			drpMenuGrp.DataValueField	= "cMenuGroup";
			drpMenuGrp.DataBind();

			// 입력부분
			drpMenuGrpNo.DataSource		= vResult;
			drpMenuGrpNo.DataTextField	= "cGroupName";
			drpMenuGrpNo.DataValueField = "cMenuGroup";
			drpMenuGrpNo.DataBind();

			drpMenuGrp.SelectedIndex = 1;
			drpMenuGrpNo.SelectedIndex = 1;
		}

		// 신규 메뉴 등록 환경 만들기
		private void fnInitNewMemu() {
			txtMenuNo.Text		= "";
			txtMenuName.Text	= "";
			txtExecUrl.Text		= "";
			txtOrderNo.Text		= "";
			txtNoteDesc.Text	= "";

			rdoIsUsed1.Checked = false;
			rdoIsUsed2.Checked = false;
			rdoIsView1.Checked = false;
			rdoIsView2.Checked = false;
			txtOrderNo.Enabled = false;

			drpMenuGrpNo.SelectedValue = drpMenuGrp.SelectedValue;
		}
		#endregion initialize layer


		#region binding layer
		// 메뉴 목록
		private void fnDisplayMenuList() {
			KWP00102_SG_WS_MENU_LIST_R oDTO = new KWP00102_SG_WS_MENU_LIST_R
			{	pSiteGroup	= Convert.ToInt16(txtSiteGrpNo.Text)
			,	pMenuGroup	= Convert.ToInt32(drpMenuGrp.SelectedValue)
			,	pFilterNo	= Convert.ToByte(drpFilter.SelectedValue)
			,	pFilterText	= txtFilter.Text
			};
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}


			DataView dvMenuList = vResult.DefaultView;
			dvMenuList.Sort = "cCommGroup, cOrderBy";
			repMenuList.DataSource = dvMenuList;
			repMenuList.DataBind();

			drpMenuGrpNo.SelectedIndex = drpMenuGrp.SelectedIndex;
		}

		// 메뉴 데이터 읽기
		private void fnDisplayMenuInfo(ref RepeaterItem pItem) {
			txtMenuGrpNo.Text	= ((Literal) pItem.FindControl("cMenuGroup")).Text;
			txtMenuNo.Text		= ((Literal) pItem.FindControl("cMenuNo")).Text;
			txtMenuName.Text	= ((Literal) pItem.FindControl("cMenuName")).Text;
			txtExecUrl.Text		= ((Literal) pItem.FindControl("cExecUrl")).Text;
			txtOrderNo.Text		= ((Literal) pItem.FindControl("cOrderBy")).Text;
			txtOldSeqNo.Text	= ((Literal) pItem.FindControl("cOrderBy")).Text;
			txtNoteDesc.Text	= ((Literal) pItem.FindControl("cNoteText")).Text;

			txtMainNo.Value		= txtMenuNo.Text;
			drpMenuGrpNo.Text	= txtMenuGrpNo.Text;
			txtOrderNo.Enabled	= true;


			bool vIsUsed = Convert.ToBoolean(((Literal) pItem.FindControl("cIsUsed")).Text);
			bool vIsView = Convert.ToBoolean(((Literal) pItem.FindControl("cIsView")).Text);

			rdoIsUsed1.Checked = vIsUsed;
			rdoIsUsed2.Checked = !vIsUsed;
			rdoIsView1.Checked = vIsView;
			rdoIsView2.Checked = !vIsView;
		}
		#endregion binding layer


		#region Control Layer
		// 메뉴 변경내용 저장
		private void fnSaveMenu() {
			if ( txtMenuName.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_01")));
				return;
			}
			if ( txtExecUrl.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_02")));
				return;
			}
			if ( drpMenuGrpNo.SelectedIndex == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_03")));
				return;
			}
			if ( txtOrderNo.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_05")));
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_06")));
				return;
			}
			if ( txtMenuGrpNo.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_07")));
				return;
			}


			KWP00107_SG_WS_MENU_INFO_U oDTO = new KWP00107_SG_WS_MENU_INFO_U
			{	pMenuNo		= Convert.ToInt32(txtMenuNo.Text)
			,	pMenuName	= txtMenuName.Text
			,	pExecUrl	= txtExecUrl.Text
			,	pGroupOld	= Convert.ToInt32(txtMenuGrpNo.Text)
			,	pGroupNew	= Convert.ToInt32(drpMenuGrpNo.SelectedValue)
			,	pIsUsed		= rdoIsUsed1.Checked
			,	pSeqNoOld	= Convert.ToInt32(txtOldSeqNo.Text)
			,	pSeqNoNew	= Convert.ToInt32(txtOrderNo.Text)
			,	pNoteText	= txtNoteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetModifyInfo(gConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Success_01")));
				txtOrderNo.Enabled = true;

				MenuList.fnReloadMenu();
				fnDisplayMenuList();
				fnInitNewMemu();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(MsgValue.MessageEx(vMessage));
			}
		}

		// 신규 메뉴 만들기
		private void fnCreateMenu() {
			if ( txtMenuName.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_01")));
				return;
			}
			if ( txtExecUrl.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_02")));
				return;
			}
			if ( drpMenuGrpNo.SelectedIndex == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_03")));
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_06")));
				return;
			}


			KWP00105_SG_WS_MENU_INFO_C oDTO = new KWP00105_SG_WS_MENU_INFO_C
			{	pMenuName	= txtMenuName.Text
			,	pExecUrl	= txtExecUrl.Text
			,	pMenuGroup	= Convert.ToInt32(drpMenuGrpNo.SelectedValue)
			,	pIsUsed		= rdoIsUsed1.Checked
			,	pIsView		= rdoIsView1.Checked
			,	pNoteText	= txtNoteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetWriteInfo(gConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Success_01")));

				MenuList.fnReloadMenu();
				fnDisplayMenuList();
				fnInitNewMemu();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(MsgValue.MessageEx(vMessage));
			}
		}
		#endregion


		#region button event layer
		// 사이트 변경
		protected void drpSiteGrpNo_OnChanged(object sender, EventArgs e) {
			txtMenuGrp.Text = vZero;
			fnInitDrpMenuList();
			fnDisplayMenuList();
		}

		// 검색하기
		protected void btnSearch_OnClick(object sender, EventArgs e) {
			fnDisplayMenuList();
		}

		// 메뉴 그리드에서 클릭
		protected void repMenuList_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			if ( !e.CommandName.Equals("SELECT") ) return;


			// 분류목록 선택시 상세정보 초기화
			RepeaterItem vItem = e.Item;
			fnDisplayMenuInfo(ref vItem);
		}

		// 신규 메뉴 등록
		protected void btnNew_OnClick(object sender, EventArgs e) {
			fnInitNewMemu();
			txtOrderNo.Enabled = false;
		}

		// 메뉴 저장
		protected void btnSave_OnClick(object sender, EventArgs e) {
			if ( txtMenuNo.Text == "" ) fnCreateMenu();
			else fnSaveMenu();
		}
		#endregion
	}
}
