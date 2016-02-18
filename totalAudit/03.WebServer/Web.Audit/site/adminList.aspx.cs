using System;
using System.Data;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Audit.site {
	public partial class adminList : BasePage {
		readonly string vConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/adminList.aspx";

			if ( IsPostBack )
				return;


			try {
				fnInitPageLoad();
				fnDisplayAdminList();
			} catch ( Exception ex) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}


		#region initialize layer
		// 드롭다운 리스트 초기화
		protected void fnInitPageLoad() {
			fnAuthGrpDropDownList();
			fnDeptGrpDropDownList();
		//	fnAuthGrpDropDownList2();
		}

		// 검색폼 권한 그룹 리스트
		protected void fnAuthGrpDropDownList() {
			KWP00101_SG_WS_GRP_AUTH_DRPDN_R oDTO = new KWP00101_SG_WS_GRP_AUTH_DRPDN_R
			{	pAdminNo	= AuthInfo.pAccountNo
			,	pModeNo		= 0
			};
			DataTable vResult = oDTO.fnGetResultSet(vConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			// 권한 그룹 리스트
			drpAuthGrp.SelectedIndex	= 0;
			drpAuthGrp.DataSource		= vResult;
			drpAuthGrp.DataTextField	= "cAuthName";
			drpAuthGrp.DataValueField	= "cAuthGroup";
			drpAuthGrp.DataBind();

			// 권한 그룹 리스트
			drpAuthList.SelectedIndex	= 0;
			drpAuthList.DataSource		= vResult;
			drpAuthList.DataTextField	= "cAuthName";
			drpAuthList.DataValueField	= "cAuthGroup";
			drpAuthList.DataBind();
		}

		// 부서 그룹 리스트
		protected void fnDeptGrpDropDownList() {
			// 부서 그룹 리스트
			KWP00101_SG_WS_GRP_DEPT_DRPDN_R oDTO = new KWP00101_SG_WS_GRP_DEPT_DRPDN_R();
			DataTable vResult = oDTO.fnGetResultSet(vConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			// 부서 그룹 리스트
			drpDeptList.SelectedIndex	= 0;
			drpDeptList.DataSource		= vResult;
			drpDeptList.DataTextField	= "cDeptName";
			drpDeptList.DataValueField	= "cDeptNo";
			drpDeptList.DataBind();

			drpDeptList.SelectedValue = txtUserGroup.Value;
		}

		// 신규 유저 등록을 위한 컨트롤 초기화
		protected void fnInitNewUser() {
			txtAdminNo.Text = "";
			txtAdminNm.Text = "";
			txtAdminId.Text = "";
			txtAdminPw.Text = "";
			txtNoteDesc.Text = "";

			txtAdminId.Enabled	= true;
			rdoUseFlag1.Checked = false;
			rdoUseFlag2.Checked = false;

			drpDeptList.SelectedIndex = 0;
			drpAuthList.SelectedIndex = 0;
		}

		// 입력폼 권한 그룹 리스트 (사용안함)
		protected void fnAuthGrpDropDownList2() {
			KWP00101_SG_WS_GRP_AUTH_DRPDN_R oDTO = new KWP00101_SG_WS_GRP_AUTH_DRPDN_R
			{	pAdminNo	= AuthInfo.pAccountNo
			,	pModeNo		= 1
			};
			DataTable vResult = oDTO.fnGetResultSet(vConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			// 권한 그룹 리스트
			drpAuthList.SelectedIndex	= 0;
			drpAuthList.DataSource		= vResult;
			drpAuthList.DataTextField	= "cAuthName";
			drpAuthList.DataValueField	= "cAuthGroup";
			drpAuthList.DataBind();
		}
		#endregion initialize layer


		#region binding layer
		// 관리자 리스트
		protected void fnDisplayAdminList() {
			try {
				KWP00102_SG_WS_ADMIN_LIST_R oDTO = new KWP00102_SG_WS_ADMIN_LIST_R
				{	pAuthGroup	= Convert.ToInt32(drpAuthGrp.SelectedValue)
				,	pAdminNo	= AuthInfo.pAccountNo
				,	pFilterNo	= Convert.ToByte(drpFilter.SelectedValue)
				,	pFilterText = txtFilter.Text
				};
				DataTable vResult = oDTO.fnGetResultSet(vConnStr);

				if ( oDTO.oReturnNo != 0 ) {
					string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oDTO.oReturnNo);
					MsgBox(MsgValue.MessageEx(vMessage));
				}
				if ( vResult.Rows.Count == 0 ) {
					string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), vResult.Rows.Count);
					MsgBox(MsgValue.MessageEx(vMessage));
				}


				vResult.DefaultView.Sort = "cOrderBy, cAdminName";
				repAdminList.DataSource = vResult;
				repAdminList.DataBind();
			} catch ( Exception e ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Error_01")) + e.Message);
			}
		}

		// 선택한 관리자 보기
		protected void fnDisplayAdminInfo(ref RepeaterItem pItem) {
			bool vIsUsed	= Convert.ToBoolean(((Literal) pItem.FindControl("cIsUsed")).Text);
			txtAdminNo.Text = ((Literal) pItem.FindControl("cAdminNo")).Text;
			txtAdminNm.Text = ((Literal) pItem.FindControl("cAdminName")).Text;
			txtAdminId.Text = ((Literal) pItem.FindControl("cAdminId")).Text;
			txtNoteDesc.Text = ((Literal) pItem.FindControl("cNoteText")).Text;

			rdoUseFlag1.Checked = vIsUsed;
			rdoUseFlag2.Checked = !vIsUsed;

			drpDeptList.Text = ((Literal) pItem.FindControl("cDeptNo")).Text;
			drpAuthList.Text = ((Literal) pItem.FindControl("cAuthGroup")).Text;

			txtAdminId.Enabled = false;
		}
		#endregion binding layer


		#region Control Layer
		// 신규 유저 생성
		protected void fnCreateUser() {
			if ( txtAdminNm.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_02")));
				return;
			}
			if ( txtAdminId.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_03")));
				return;
			}
			if ( txtAdminPw.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_04")));
				return;
			}
			if ( drpDeptList.SelectedIndex == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_05")));
				return;
			}
			if ( drpAuthList.SelectedIndex == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_06")));
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_07")));
				return;
			}


			KWP00105_SG_WS_ADMIN_INFO_C oDTO = new KWP00105_SG_WS_ADMIN_INFO_C
			{	pAdminId	= txtAdminId.Text
			,	pPassword	= PasswordManager.GetPassword(txtAdminId.Text, txtAdminPw.Text)
			,	pAdminName	= txtAdminNm.Text
			,	pAuthGroup	= Convert.ToInt32(drpAuthList.SelectedValue)
			,	pDeptNo		= Convert.ToInt32(drpDeptList.SelectedValue)
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pHostIp		= fnHostIp()
			,	pNoteText	= txtNoteDesc.Text
			};
			int oReturnNo = oDTO.fnSetWriteInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Success_01")));

				fnInitNewUser();
				fnDisplayAdminList();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(MsgValue.MessageEx(vMessage));
			}
		}

		// 유저 변경내용 저장
		protected void fnSaveUserInfo() {
			string vPassword = "";
			if ( txtAdminNo.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_01")));
				return;
			}
			if ( txtAdminNm.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_02")));
				return;
			}
			if ( txtAdminId.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_03")));
				return;
			}
			if ( drpAuthList.SelectedIndex == -1 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_06")));
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Alert_07")));
				return;
			}
			if ( txtAdminPw.Text != "" ) {
				vPassword = PasswordManager.GetPassword(txtAdminId.Text, txtAdminPw.Text);
			}


			KWP00107_SG_WS_ADMIN_INFO_U oDTO = new KWP00107_SG_WS_ADMIN_INFO_U
			{	pAdminNo	= Convert.ToInt32(txtAdminNo.Text)
			,	pAdminName	= txtAdminNm.Text
			,	pPassword	= vPassword
			,	pAuthGroup	= Convert.ToInt32(drpAuthList.SelectedValue)
			,	pDeptNo		= Convert.ToInt32(drpDeptList.SelectedValue)
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pHostIp		= fnHostIp()
			,	pNoteText	= txtNoteDesc.Text
			};
			int oReturnNo = oDTO.fnSetModifyInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Success_01")));

				fnInitNewUser();
				fnDisplayAdminList();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oDTO.oReturnNo);
				MsgBox(MsgValue.MessageEx(vMessage));
			}
		}
		#endregion Control Layer


		#region button event layer
		// 관리자 검색
		protected void btnSearch_OnClick(object sender, EventArgs e) {
			try {
				fnDisplayAdminList();
			} catch ( Exception ex ) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// repAdminList에서 클릭
		protected void repAdminList_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			if ( e.CommandName != "SELECT" ) return;


			try {
				RepeaterItem vItem = e.Item;
				fnDisplayAdminInfo(ref vItem);
			} catch ( Exception ex ) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 신규 유저 생성 환경 만들기
		protected void btnNew_OnClick(object sender, EventArgs e) {
			try {
				fnInitNewUser();
			} catch ( Exception ex ) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 유저 변경내용 저장 및 생성
		protected void btnSave_OnClick(object sender, EventArgs e) {
			try {
				if ( txtAdminNo.Text == "" ) fnCreateUser();
				else fnSaveUserInfo();
			} catch ( Exception ex ) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}
		#endregion button event layer
	}
}
