using System;
using System.Data;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Audit.site {
	public partial class baseCode : BasePage {
		readonly string vConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/baseCode.aspx";

			if ( IsPostBack )
				return;


			try {
				fnDisplaySiteGroupList();
			} catch ( Exception ex ) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}


		#region initialize layer
		// 신규 site group 생성 준비
		protected void fnInitNewSiteGrp() {
			txtSiteGrpNo.Text = "";
			txtSiteGrpNm.Text = "";
			txtSiteDesc.Text = "";
			rdoUseFlag1.Checked = false;
			rdoUseFlag2.Checked = false;

			pnlNewGrp.Visible = false;
			pnlGrpList.Visible = false;
		}

		// 신규 group 생성 준비
		protected void fnInitNewGrp() {
			txtCommGrpNo.Text = "";
			txtCommGrpNm.Text = "";
			txtCommDesc.Text = "";
			rdoUseFlag3.Checked = false;
			rdoUseFlag4.Checked = false;

			pnlNewSite.Visible = false;
			pnlGrpList.Visible = true;
		}

		// 그룹목록 리스트의 DropDownList 내용 채우기
		protected void fnInitDrpIndex(ref DataTable pTable) {
			for ( int i = 0; i < pTable.Rows.Count; i++ ) {
				DropDownList vDropDown = (DropDownList) repGroupList.Items[i].FindControl("drpIndex");

				vDropDown.DataSource		= pTable;
				vDropDown.DataValueField	= pTable.Columns[5].ToString();
				vDropDown.DataTextField		= pTable.Columns[5].ToString();
				vDropDown.DataBind();

				vDropDown.SelectedIndex = i;
			}
		}

		// 신규 사이트 그룹 생성
		protected void fnNewSiteGrp() {
			fnInitNewSiteGrp();
			txtSiteGrpNm.Focus();
		}
		#endregion initialize layer


		#region binding layer
		// 기본코드관리 리스트
		protected void fnDisplaySiteGroupList() {
			gRowNo = 0;
			KWP00102_SG_WS_GRP_SITE_LIST_R oDTO = new KWP00102_SG_WS_GRP_SITE_LIST_R();
			DataTable vResult = oDTO.fnGetResultSet(vConnStr);

			if ( oDTO.oReturnNo != 0 )
				return;
			if ( vResult.Rows.Count <= 0 )
				return;


			repSiteGroupList.DataSource = vResult;
			repSiteGroupList.DataBind();

			pnlGrpList.Visible = false;
			pnlNewGrp.Visible = false;
		}

		// 관리항목 기본정보
		protected void fnDisplaySiteGrpInfo(ref RepeaterItem pItem) {
			bool vUseFlag		= Convert.ToBoolean(((Literal) pItem.FindControl("cIsUsed")).Text);
			txtCommGrpNo.Text	= ((Literal) pItem.FindControl("cSiteGroup")).Text;
			txtSiteGrpNm.Text	= ((Literal) pItem.FindControl("cSiteName")).Text;
			txtSiteDesc.Text	= ((Literal) pItem.FindControl("cNoteText")).Text;

			rdoUseFlag1.Checked = vUseFlag;
			rdoUseFlag2.Checked = !vUseFlag;

			pnlNewSite.Visible	= true;
			pnlNewGrp.Visible	= false;
			pnlGrpList.Visible	= false;
		}

		// 그룹목록 리스트
		protected void fnDisplayCommGrpList(short pGroupNo) {
			gRowNo = 0;
			KWP00102_SG_WS_GRP_COMM_LIST_R oDTO = new KWP00102_SG_WS_GRP_COMM_LIST_R
			{	pSiteGroup = pGroupNo
			};
			DataTable vResult = oDTO.fnGetResultSet(vConnStr);

			if ( oDTO.oReturnNo != 0 )
				return;
			if ( vResult.Rows.Count <= 0 )
				return;


			repGroupList.DataSource = vResult;
			repGroupList.DataBind();

			// 그룹목록의 DropDownList 내용 채우기
			fnInitDrpIndex(ref vResult);
			pnlGrpList.Visible = true;
		}

		// 그룹 상세정보
		protected void fnDisplayCommGrpInfo(ref RepeaterItem pItem) {
			bool vUseFlag		= Convert.ToBoolean(((Literal) pItem.FindControl("cIsUsed")).Text);
			txtCommGrpNm.Text	= ((Literal) pItem.FindControl("cCommName")).Text;
			txtCommDesc.Text	= ((Literal) pItem.FindControl("cNoteText")).Text;

			rdoUseFlag3.Checked = vUseFlag;
			rdoUseFlag4.Checked = !vUseFlag;

			pnlNewSite.Visible	= false;
			pnlNewGrp.Visible	= true;
		}
		#endregion


		#region Control Layer
		// 신규 사이트 그룹 만들기
		protected void fnCreateSiteGrp() {
			if ( txtSiteGrpNm.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_01"));
				return;
			}
			if ( rdoUseFlag1.Checked == false && rdoUseFlag2.Checked == false ) {
				MsgBox(fnMessageKey("msg_Alert_02"));
				return;
			}
			if ( txtSiteDesc.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_03"));
				return;
			}


			KWP00105_SG_WS_GRP_SITE_INFO_C oDTO = new KWP00105_SG_WS_GRP_SITE_INFO_C
			{	pSiteName	= txtSiteGrpNm.Text
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pNoteText	= txtSiteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetWriteInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(fnMessageKey("msg_Success_01"));

				fnInitNewSiteGrp();
				fnDisplaySiteGroupList();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 사이트 그룹 저장
		protected void fnSavaSiteGrp() {
			if ( txtSiteGrpNm.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_01"));
				return;
			}
			if ( rdoUseFlag1.Checked == false && rdoUseFlag2.Checked == false ) {
				MsgBox(fnMessageKey("msg_Alert_02"));
				return;
			}
			if ( txtSiteDesc.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_03"));
				return;
			}


			KWP00107_SG_WS_GRP_SITE_INFO_U oDTO = new KWP00107_SG_WS_GRP_SITE_INFO_U
			{	pSiteGroup	= Convert.ToInt16(txtSiteGrpNo.Text)
			,	pSiteName	= txtSiteGrpNm.Text
			,	pIsUsed		= rdoUseFlag1.Checked
			,	pNoteText	= txtSiteDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetModifyInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(fnMessageKey("msg_Success_01"));

				fnInitNewSiteGrp();
				fnDisplaySiteGroupList();
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 신규 그룹 만들기
		protected void fnCreateCommGrp() {
			if ( txtCommGrpNm.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_01"));
				return;
			}
			if ( rdoUseFlag3.Checked == false && rdoUseFlag4.Checked == false ) {
				MsgBox(fnMessageKey("msg_Alert_02"));
				return;
			}
			if ( txtCommDesc.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_03"));
				return;
			}


			bool vUseFlag = rdoUseFlag3.Checked;
			short vSiteGrpNo = Convert.ToInt16(txtSiteGrpNo.Text);

			KWP00105_SG_WS_GRP_COMM_INFO_C oDTO = new KWP00105_SG_WS_GRP_COMM_INFO_C
			{	pSiteGroup	= vSiteGrpNo
			,	pCommName	= txtCommGrpNm.Text
			,	pIsUsed		= vUseFlag
			,	pNoteText	= txtCommDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetWriteInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(fnMessageKey("msg_Success_01"));

				fnInitNewGrp();
				fnDisplayCommGrpList(vSiteGrpNo);
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 그룹 저장
		protected void fnSavaGroup() {
			if ( txtCommGrpNm.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_01"));
				return;
			}
			if ( rdoUseFlag3.Checked == false && rdoUseFlag4.Checked == false ) {
				MsgBox(fnMessageKey("msg_Alert_02"));
				return;
			}
			if ( txtCommDesc.Text == "" ) {
				MsgBox(fnMessageKey("msg_Alert_03"));
				return;
			}


			bool vUseFlag = rdoUseFlag3.Checked;
			short vSiteGrpNo = Convert.ToInt16(txtSiteGrpNo.Text);
			int vCommGrpNo = Convert.ToInt32(txtCommGrpNo.Text);

			KWP00107_SG_WS_GRP_COMM_INFO_U oDTO = new KWP00107_SG_WS_GRP_COMM_INFO_U
			{	pCommGroup	= vCommGrpNo
			,	pCommName	= txtCommGrpNm.Text
			,	pIsUsed		= vUseFlag
			,	pNoteText	= txtCommDesc.Text
			,	pHostIp		= fnHostIp()
			};
			int oReturnNo = oDTO.fnSetModifyInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(fnMessageKey("msg_Success_01"));

				fnInitNewGrp();
				fnDisplayCommGrpList(vSiteGrpNo);
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(fnMessageText(vMessage));
			}
		}

		// 그룹목록 인덱스 순서 변경
		protected void fnChangeIndex(ref object pSender) {
			DropDownList vDrop = (DropDownList) pSender;
			RepeaterItem vItem = (RepeaterItem) vDrop.NamingContainer;

			if ( vItem == null ) {
				MsgBox(fnMessageKey("msg_Error_01"));
				return;
			}


			int vSelIdxNew = Convert.ToInt32(vDrop.Text);
			int vSelIdxOld = Convert.ToInt32(((Literal) vItem.FindControl("cOrderBy")).Text);
			int vCommGrpNo = Convert.ToInt32(((Literal) vItem.FindControl("cCommGroup")).Text);
			short vSiteGrpNo = Convert.ToInt16(txtSiteGrpNo.Text);

			KWP00107_SG_WS_GRP_COMM_SEQ_U oDTO = new KWP00107_SG_WS_GRP_COMM_SEQ_U
			{	pSiteGroup	= vSiteGrpNo
			,	pCommGroup	= vCommGrpNo
			,	pSeqNoOld	= vSelIdxOld
			,	pSeqNoNew	= vSelIdxNew
			};
			int oReturnNo = oDTO.fnSetModifyInfo(vConnStr);

			if ( oReturnNo == 0 ) {
				MsgBox(fnMessageKey("msg_Success_01"));
				fnDisplayCommGrpList(vSiteGrpNo);
			} else {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), oReturnNo);
				MsgBox(fnMessageText(vMessage));
			}
		}
		#endregion Control Layer


		#region button event layer
		protected void btnSearch_OnClick(object sender, EventArgs e) {
			fnDisplaySiteGroupList();
		}

		// (repSiteGrpList)기본코드관리 Select 버튼 클릭
		protected void repSiteGrpList_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			if ( !e.CommandName.Equals("SELECT") ) return;


			RepeaterItem vItem	= e.Item;
			short vGroupNo		= Convert.ToInt16(((Literal) vItem.FindControl("cSiteGroup")).Text);
			txtSiteGrpNo.Text	= Convert.ToString(vGroupNo);
			txtMainNo.Value		= Convert.ToString(vGroupNo);

			fnDisplaySiteGrpInfo(ref vItem);
			fnDisplayCommGrpList(vGroupNo);
		}

		// 신규 사이트 그룹 생성
		protected void btnNewSite_OnClick(object sender, EventArgs e) {
			pnlNewSite.Visible = true;
			fnNewSiteGrp();
		}

		// 사이트 그룹 저장
		protected void btnSaveSite_OnClick(object sender, EventArgs e) {
			if ( txtSiteGrpNo.Text == "" ) fnCreateSiteGrp();
			else fnSavaSiteGrp();
		}

		// (repGroupList)그룹목록 Select 버튼 클릭
		protected void repGroupList_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			if ( !e.CommandName.Equals("SELECT") ) return;


			RepeaterItem vItem	= e.Item;
			int vGroupNo		= Convert.ToInt32(((Literal) e.Item.FindControl("cCommGroup")).Text);
			txtCommGrpNo.Text	= Convert.ToString(vGroupNo);
			txtListNo.Value		= Convert.ToString(vGroupNo);

			fnDisplayCommGrpInfo(ref vItem);
		}

		// 신규 그룹 생성
		protected void btnNewGrp_Click(object sender, EventArgs e) {
			pnlNewGrp.Visible = true;
			fnInitNewGrp();
		}

		// 그룹 저장
		protected void btnSaveGrp_Click(object sender, EventArgs e) {
			if ( txtCommGrpNo.Text == "" ) fnCreateCommGrp();
			else fnSavaGroup();
		}

		// (repGroupList)정렬순서 DropDownList 변경 버튼
		protected void drpIndex_OnSelectedIndexChanged(object sender, EventArgs e) {
			fnChangeIndex(ref sender);
		}
		#endregion button event layer
	}
}
