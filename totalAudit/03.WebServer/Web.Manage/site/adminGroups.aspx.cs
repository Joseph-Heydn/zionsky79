using System;
using System.Data;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Manage.site {
	public partial class adminGroups : BasePage {
		private const int gSiteNo = 10002;
		readonly string gConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/adminGroups.aspx";

			if ( IsPostBack )
				return;


			try {
				fnInitDropDownList();
				fnDisplayGroupList();	
			} catch ( Exception ex) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{ex.Message}]";
				fnMessageText(vMessage);
			}
			
		}


		#region initialize layer
		protected void fnInitDropDownList() {
			if ( txtSiteGrpNo.Text == "" ) {
				txtSiteGrpNo.Text = Convert.ToString("1001");
			}


			KWP00101_SG_WS_GRP_MENU_DRPDN_R oDTO = new KWP00101_SG_WS_GRP_MENU_DRPDN_R
			{	pSiteGroup	= Convert.ToInt16(txtSiteGrpNo.Text)
			,	pMode		= 1
			};
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			drpSiteGrpNo.DataSource		= vResult;
			drpSiteGrpNo.DataTextField	= "cSiteName";
			drpSiteGrpNo.DataValueField = "cSiteGroup";
			drpSiteGrpNo.DataBind();

			drpSiteGrpNo.SelectedIndex = 0;
			drpSiteGrpNo.SelectedValue = txtSiteGrpNo.Text;
		}

		// 신규 그룹 생성 환경 만들기
		protected void fnNewGroup() {
			txtCommGrpNo.Text	= "";
			txtCommGrpNm.Text	= "";
			txtNoteDesc.Text	= "";

			rdoUseFlag1.Checked = false;
			rdoUseFlag2.Checked = false;

			// 권한 그룹 패널 닫기
			panelGroupInfo.Visible = false;
		}
		#endregion initialize layer


		#region binding layer
		// (repGroupList)그룹목록 리스트
		protected void fnDisplayGroupList() {
			KWP00102_SG_WS_GRP_COMM_LIST_R oDTO = new KWP00102_SG_WS_GRP_COMM_LIST_R
			{	pSiteGroup = 2001
			};
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResult.Rows.Count <= 0 ) {
				return;
			}


			repGroupList.DataSource = vResult;
			repGroupList.DataBind();
		}

		// 그룹 기본정보
		protected void fnDisplayAuthGrpInfo() {
			KWP00102_SG_WS_GRP_AUTH_LIST_R oDTO = new KWP00102_SG_WS_GRP_AUTH_LIST_R
			{	pSiteGroup = Convert.ToInt16(txtSiteGrpNo.Text)
			,	pCommGroup = Convert.ToInt32(txtAuthGrpNo.Text)
			};
			DataSet vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}


/*			txtCommGrpNo.Text	= Convert.ToString(oDTO.oAuthGroup);
			txtCommGrpNm.Text	= oDTO.oAuthName;
			txtNoteDesc.Text	= oDTO.oNoteText;

			rdoUseFlag1.Checked = oDTO.oIsUsed;
			rdoUseFlag2.Checked = !oDTO.oIsUsed;
*/
			// 구성원 관리 (비 구성원)
			repAdminLeft.DataSource = vResult.Tables[0];
			repAdminLeft.DataBind();

			// 구성원 관리 (구성원)
			repAdminRight.DataSource = vResult.Tables[1];
			repAdminRight.DataBind();

			// 메뉴권한 관리 (미 등록)
			repAuthLeft.DataSource = vResult.Tables[2];
			repAuthLeft.DataBind();

			// 메뉴권한 관리 (등록)
			repAuthRight.DataSource = vResult.Tables[3];
			repAuthRight.DataBind();

			lblAdminLeft.Text	= Convert.ToString(vResult.Tables[0].Rows.Count);
			lblAdminRight.Text	= Convert.ToString(vResult.Tables[1].Rows.Count);
			lblAuthLeft.Text	= Convert.ToString(vResult.Tables[2].Rows.Count);
			lblAuthRight.Text	= Convert.ToString(vResult.Tables[3].Rows.Count);


			// 권한 그룹 패널 열기
			panelGroupInfo.Visible = true;
		}
		#endregion binding layer


		#region control layer
		// 그룹 변경내용 저장하기
		protected void fnSaveGroup() {
			if ( txtCommGrpNo.Text == "" ) {
				fnMessageKey("msg_Alert_01");
				return;
			}
			if ( txtCommGrpNm.Text == "" ) {
				fnMessageKey("msg_Alert_02");
				return;
			}
			if ( rdoUseFlag1.Checked == false && rdoUseFlag2.Checked == false ) {
				fnMessageKey("msg_Alert_03");
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				fnMessageKey("msg_Alert_04");
				return;
			}


			KWP00107_SG_WS_GRP_AUTH_INFO_U oDTO = new KWP00107_SG_WS_GRP_AUTH_INFO_U
			{	pSiteGroup	= gSiteNo
			,	pCommGroup	= Convert.ToInt32(txtCommGrpNo.Text)
			,	pCommName	= txtCommGrpNm.Text
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pNoteText	= txtNoteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int vReturn = oDTO.fnSetModifyInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}


			fnMessageKey("msg_Success_01");
			fnDisplayGroupList();
		}

		// 신규 그룹 만들기
		protected void fnCreateGroup() {
			if ( txtCommGrpNm.Text == "" ) {
				fnMessageKey("msg_Alert_02");
				return;
			}
			if ( rdoUseFlag1.Checked == false && rdoUseFlag2.Checked == false ) {
				fnMessageKey("msg_Alert_03");
				return;
			}
			if ( txtNoteDesc.Text == "" ) {
				fnMessageKey("msg_Alert_04");
				return;
			}


			KWP00105_SG_WS_GRP_AUTH_INFO_C oDTO = new KWP00105_SG_WS_GRP_AUTH_INFO_C
			{	pSiteGroup	= gSiteNo
			,	pCommName	= txtCommGrpNm.Text
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pNoteText	= txtNoteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int vReturn = oDTO.fnSetWriteInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}

			fnMessageKey("msg_Success_01");
			fnDisplayGroupList();
		}

		// 구성원에 포함
		protected void fnApplyMembers() {
			int vRowCnt = Convert.ToInt32(lblAdminLeft.Text);
			if ( vRowCnt < 1 ) {
				fnMessageKey("msg_Alert_05");
				return;
			}


			// 선택 된 항목 찾기
			txtSelected.Text = "";
			fnSelectedList(ref repAdminLeft, vRowCnt, 1);

			if ( txtSelected.Text == "" ) {
				fnMessageKey("msg_Alert_06");
				return;
			}


			KWP00105_SG_WS_GRP_USER_AUTH_C oDTO = new KWP00105_SG_WS_GRP_USER_AUTH_C
			{	pAuthGroup	= Convert.ToInt32(txtCommGrpNo.Text)
			,	pAdminList	= txtSelected.Text
			};
			int vReturn = oDTO.fnSetWriteInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}


			fnMessageKey("msg_Success_01");
			fnDisplayAuthGrpInfo();
		}

		// 구성원에서 제외
		protected void fnRemoveMembers() {
			int vRowCnt = Convert.ToInt32(lblAdminRight.Text);
			if ( vRowCnt < 1 ) {
				fnMessageKey("msg_Alert_05");
				return;
			}


			// 선택 된 항목 찾기
			txtSelected.Text = "";
			fnSelectedList(ref repAdminRight, vRowCnt, 1);

			if ( txtSelected.Text == "" ) {
				fnMessageKey("msg_Alert_06");
				return;
			}


			KWP00106_SG_WS_GRP_AUTH_LIST_D oDTO = new KWP00106_SG_WS_GRP_AUTH_LIST_D
			{	pAuthGroup	= Convert.ToInt32(txtCommGrpNo.Text)
			,	pAdminList	= txtSelected.Text
			};
			int vReturn = oDTO.fnSetDeleteInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}


			fnMessageKey("msg_Success_01");
			fnDisplayAuthGrpInfo();
		}

		// 메뉴 권한에 포함
		protected void fnApplyMenus() {
			int vRowCnt = Convert.ToInt32(lblAuthLeft.Text);
			if ( vRowCnt < 1 ) {
				fnMessageKey("msg_Alert_05");
				return;
			}


			// 선택 된 항목 찾기
			txtSelected.Text = "";
			txtSelected2.Text = "";
			fnSelectedList(ref repAuthLeft, vRowCnt, 2);

			if ( txtSelected.Text == "" ) {
				fnMessageKey("msg_Alert_06");
				return;
			}


			KWP00105_SG_WS_GRP_MENU_AUTH_C oDTO = new KWP00105_SG_WS_GRP_MENU_AUTH_C
			{	pAdminNo	= AuthInfo.pAccountNo
			,	pSiteGroup	= 1001
			,	pAuthGroup	= Convert.ToInt32(txtCommGrpNo.Text)
			,	pMenuList	= txtSelected.Text
			,	pWriteList	= txtSelected2.Text
			};
			int vReturn = oDTO.fnSetWriteInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}


			fnMessageKey("msg_Success_01");
			fnDisplayAuthGrpInfo();
			MenuList.fnReloadAuth();
		}

		// 메뉴 권한에서 제외
		protected void fnRemoveMenus() {
			int vRowCnt = Convert.ToInt32(lblAuthRight.Text);
			if ( vRowCnt < 1 ) {
				fnMessageKey("msg_Alert_05");
				return;
			}


			// 선택 된 항목 찾기
			txtSelected.Text = "";
			fnSelectedList(ref repAuthRight, vRowCnt, 1);

			if ( txtSelected.Text == "" ) {
				fnMessageKey("msg_Alert_06");
				return;
			}


			KWP00106_SG_WS_GRP_MENU_LIST_D oDTO = new KWP00106_SG_WS_GRP_MENU_LIST_D
			{	pAuthGroup	= Convert.ToInt32(txtCommGrpNo.Text)
			,	pMenuList	= txtSelected.Text
			};
			int vReturn = oDTO.fnSetDeleteInfo(gConnStr);

			if ( vReturn != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{vReturn}]";
				fnMessageText(vMessage);
				return;
			}


			fnMessageKey("msg_Success_01");
			fnDisplayAuthGrpInfo();
			MenuList.fnReloadAuth();
		}

		// 그리드에 선택된 컨트롤의 값 가져오기
		protected void fnSelectedList(ref Repeater pRepeater, int pRowCnt, int pMode) {
			const string vTmp = "{0}|";

			if ( pMode == 1 ) {
				StringBuilder vSelected = new StringBuilder();

				for ( int i = 0; i < pRowCnt; i++ ) {
					HtmlInputCheckBox ckSelect = (HtmlInputCheckBox) pRepeater.Items[i].FindControl("chkSelect");
					if ( ckSelect.Checked ) {
						vSelected.Append(string.Format(vTmp, ckSelect.Value));
					}
				}

				txtSelected.Text = vSelected.ToString();
			} else {
				StringBuilder vSelected		= new StringBuilder();
				StringBuilder vSelected2	= new StringBuilder();

				for ( int i = 0; i < pRowCnt; i++ ) {
					HtmlInputCheckBox ckSelect = (HtmlInputCheckBox) pRepeater.Items[i].FindControl("chkSelect");
					if ( ckSelect.Checked ) {
						vSelected.Append(string.Format(vTmp, ckSelect.Value));
					}

					ckSelect = (HtmlInputCheckBox) pRepeater.Items[i].FindControl("chkWriteFlag");
					if ( ckSelect.Checked ) {
						vSelected2.Append(string.Format(vTmp, ckSelect.Value));
					}
				}

				txtSelected.Text	= vSelected.ToString();
				txtSelected2.Text	= vSelected2.ToString();
			}

			// 마지막 vSplit 문자 제거
			if ( txtSelected.Text.Length > 0 ) {
				txtSelected.Text = txtSelected.Text.Substring(0, txtSelected.Text.Length - 1);
			}
			if ( txtSelected2.Text.Length > 0 ) {
				txtSelected2.Text = txtSelected2.Text.Substring(0, txtSelected2.Text.Length - 1);
			}
		}
		#endregion control layer


		#region button event layer
		// 검색하기
		protected void btnSearch_Click(object sender, EventArgs e) {
			fnDisplayGroupList();
		}

		// 그룹 목록에서 그룹 선택
		protected void repGroupList_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			if ( !e.CommandName.Equals("SELECT") ) return;


			txtAuthGrpNo.Text	= ((Literal) e.Item.FindControl("cCommGroup")).Text;
			txtCommGrpNo.Text	= txtAuthGrpNo.Text;
			txtMainNo.Value		= txtAuthGrpNo.Text;
			fnDisplayAuthGrpInfo();
		}

		// 신규 그룹 생성 환경 만들기
		protected void btnNewGroup_OnClick(object sender, EventArgs e) {
			fnNewGroup();
		}

		// 신규 그룹 생성, 변경내용 저장하기
		protected void btnSaveGroup_OnClick(object sender, EventArgs e) {
			if ( txtCommGrpNo.Text == "" ) fnCreateGroup();
			else fnSaveGroup();
		}

		// 구성원에 포함
		protected void btnApplyMember_OnClick(object sender, EventArgs e) {
			fnApplyMembers();
			chkAdminLeft.Checked = false;
		}

		// 구성원에서 제외
		protected void btnRemoveMember_OnClick(object sender, EventArgs e) {
			fnRemoveMembers();
			chkAdminRight.Checked = false;
		}

		// 사이트 변경
		protected void drpSiteGrpNo_OnChanged(object sender, EventArgs e) {
			fnDisplayAuthGrpInfo();
		}

		// 메뉴 권한에 포함
		protected void btnApplyMenu_OnClick(object sender, EventArgs e) {
			fnApplyMenus();
			chkAuthLeft.Checked = false;
		}

		// 메뉴 권한에서 제외
		protected void btnRemoveMenu_OnClick(object sender, EventArgs e) {
			fnRemoveMenus();
			chkAuthRight.Checked = false;
		}
		#endregion button event layer
	}
}
