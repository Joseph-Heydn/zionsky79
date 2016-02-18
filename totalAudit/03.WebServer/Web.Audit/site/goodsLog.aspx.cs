using System;
using System.Data;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Audit.site {
	public partial class goodsLog : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/goodsLog.aspx";

			if ( IsPostBack )
				return;


			try {
				fnInitAdminList();
				fnInitActionList();
				fnInitSearchDate();
			} catch ( Exception ex) {
				string vMessage = string.Format("{0} [{1}]", fnLabelText("msg_Error_01"), ex.Message);
				MsgBox(fnMessageText(vMessage));
			}
		}


		#region initialize layer
		// 검색 조건 초기화
		protected void fnInitSearchDate() {
			// 기본 검색 날짜는 오늘
			txtStartDate.Text = DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd");
			txtLimitDate.Text = DateTime.Today.AddDays(0).ToString("yyyy-MM-dd");

			drpAdmin.SelectedIndex = -1;
			drpAction.SelectedIndex = -1;
		}

		protected void fnInitAdminList() {
			try {
				// 전체 부서 목록
				// 조회자의 관리자 아이디
				// 전체 관리자 목록
				KWP00102_SG_WS_ADMIN_LIST_R oDTO = new KWP00102_SG_WS_ADMIN_LIST_R
				{	pAuthGroup	= AuthInfo.pAuthrity
				,	pCommGroup	= 0
				,	pAdminNo	= AuthInfo.pAccountNo
				,	pFilterNo	= 0
				,	pFilterText = string.Empty
				};
				DataTable vResult = oDTO.fnGetResultSet(gConnStr);

				if ( oDTO.oReturnNo != 0 ) {
					fnMsgBox("msg_Error_01", Convert.ToString(oDTO.oReturnNo));
					return;
				}
				if ( vResult.Rows.Count == 0 ) {
					return;
				}


				drpAdmin.DataSource		= vResult;
				drpAdmin.DataValueField = "cAdminNo";
				drpAdmin.DataTextField = "cAdminId";
				drpAdmin.DataBind();
			} catch ( Exception e ) {
				fnMsgBox("msg_Error_01", e.ToString());
			}
		}

		// 지급작업 목록 데이터
		public DataTable fnGoodsResourceMatching() {
			DataTable oTable = Cache["tGoods"] as DataTable;

			if ( oTable != null )
				return oTable;


			DataTable vTable = new DataTable();
			vTable.Columns.Add("cKey"	, typeof(string));
			vTable.Columns.Add("cValue"	, typeof(string));

			for ( int i = 1; i <= 131; i++ ) {
				string vKey		= Convert.ToString(i);
				string vValue	= fnMessageKey(vKey);

				if ( string.IsNullOrEmpty(vValue) )
					continue;


				DataRow vRow	= vTable.NewRow();
				vRow["cKey"]	= vKey;
				vRow["cValue"]	= vValue;
				vTable.Rows.Add(vRow);
			}

			vTable.DefaultView.Sort = "cValue";
			oTable = vTable.Copy();
			Cache["tGoods"] = oTable;

			return oTable;
		}

		// 지급작업 목록 바인딩
		protected void fnInitActionList() {
			drpAction.DataSource = fnGoodsResourceMatching();
			drpAction.DataValueField = "cKey";
			drpAction.DataTextField = "cValue";
			drpAction.DataBind();
		}
		#endregion initialize layer


		#region binding layer
		// 검색 변수 입력
		private void fnSearch() {
			DateTime vStartDate, vLimitDate;
			if ( !DateTime.TryParse(txtStartDate.Text, out vStartDate) ) {
				vStartDate = DateTime.Today.AddDays(-1);
				txtStartDate.Text = vStartDate.ToString("yyyy-MM-dd");
			}
			if ( !DateTime.TryParse(txtLimitDate.Text, out vLimitDate) ) {
				vLimitDate = vStartDate;
				txtLimitDate.Text = vLimitDate.ToString("yyyy-MM-dd");
			}


			KWP00102_SG_WS_GOODS_LOG_LIST_R oDTO = new KWP00102_SG_WS_GOODS_LOG_LIST_R
			{	pStartDate	= Convert.ToInt32(vStartDate.ToString("yyyyMMdd"))
			,	pFinishDate = Convert.ToInt32(vLimitDate.ToString("yyyyMMdd"))
			,	pAdminNo	= Convert.ToInt32(drpAdmin.SelectedValue)
			,	pAction		= Convert.ToByte(drpAction.SelectedValue)
			};
			fnGridBind(ref oDTO);
		}

		/// <summary>
		/// 관리자 작업 내역 바인딩
		/// </summary>
		/// <param name="oDTO"></param>
		protected void fnGridBind(ref KWP00102_SG_WS_GOODS_LOG_LIST_R oDTO) {
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);
			if ( vResult == null || vResult.Rows.Count == 0 ) {
				pnGrid.Visible = false;
				return;
			}


			repActionLog.DataSource = vResult;
			repActionLog.DataBind();

			pnGrid.Visible = true;
		}

		/// <summary>
		/// 로그 형태를 알아볼 수 있는 이름으로 변환
		/// </summary>
		/// <param name="pActionNo">지급 형태</param>
		/// <returns>로그 형태 이름</returns>
		public string fnGetActionName(object pActionNo) {
			if ( pActionNo == null )
				return string.Empty;


			string action_nm = fnLabelText(Convert.ToString(pActionNo));
			return string.IsNullOrEmpty(action_nm) ? string.Empty : action_nm;
		}

		// 메시지 박스로 출력
		protected void fnMsgBox(string pKey, string pText) {
			string vMessage = string.Format("{0} [{1}]", fnLabelText(pKey), pText);
			MsgBox(MsgValue.MessageEx(vMessage));
		}
		#endregion binding layer


		#region button event layer
		/// <summary>
		/// 목록에서 항목 클릭
		/// </summary>
		/// <param name="source"></param>
		/// <param name="e"></param>
		protected void repActionLog_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			RepeaterItem vItem = e.Item;
			DateTime vCreateTime = Convert.ToDateTime(((Literal) vItem.FindControl("ipt_time")).Text);
			txtMainNo.Value = string.Format("{0:yyyyMMddHHmmss}", vCreateTime);

			switch ( e.CommandName ) {
				// 목록에서 날짜를 클릭하면 해당 날짜로 작업 내역 조회
				case "SELECT_DATE":
					string vWorkDate	= ((Literal) vItem.FindControl("ipt_time")).Text.Substring(0,10);
					txtStartDate.Text	= vWorkDate;
					txtLimitDate.Text	= vWorkDate;
					pnDetail.Visible	= false;
					break;
				// 목록에서 관리자를 클릭하면 해당 관리자의 작업 내역 조회
				case "SELECT_ADMIN":
					drpAdmin.SelectedValue = ((Literal) vItem.FindControl("admin_no")).Text;
					pnDetail.Visible = false;
					break;
				// 목록에서 메뉴를 클릭하면 해당 메뉴로 작업 내역 조회
				case "SELECT_ACTION":
					drpAction.SelectedValue = ((Literal) vItem.FindControl("action_no")).Text;
					pnDetail.Visible = false;
					break;
				// 선택한 작업의 상세 정보 조회
				case "SELECT":
					litIptTime.Text		= ((Literal) vItem.FindControl("ipt_time")).Text;
					litServerNo.Text	= ((Literal) vItem.FindControl("server_no")).Text;
					litNickName.Text	= ((Literal) vItem.FindControl("nick_name")).Text;
					litAccountNo.Text	= ((Literal) vItem.FindControl("account_no")).Text;
					litPublishNo.Text	= ((Literal) vItem.FindControl("publish_no")).Text;
					litActionNo.Text	= ((Literal) vItem.FindControl("action_no")).Text;
					litActionName.Text	= ((Literal) vItem.FindControl("action_nm")).Text;
					litValuesOld.Text	= ((Literal) vItem.FindControl("values_old")).Text;
					litValuesNew.Text	= ((Literal) vItem.FindControl("values_new")).Text;
					litAdminNo.Text		= ((Literal) vItem.FindControl("admin_no")).Text;
					litAdminId.Text		= ((Literal) vItem.FindControl("admin_id")).Text;
					litMailNo.Text		= ((Literal) vItem.FindControl("mail_no")).Text;
					litTryCnt.Text		= ((Literal) vItem.FindControl("try_cnt")).Text;
					litIPAddr.Text		= ((Literal) vItem.FindControl("ip_addr")).Text;
					litUptTime.Text		= ((Literal) vItem.FindControl("upt_time")).Text;
					pnDetail.Visible	= true;
					return;
				default:
					return;
			}

			fnSearch();
		}

		/// <summary>
		/// 검색 버튼 클릭
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnSearch_Click(object sender, EventArgs e) {
			pnGrid.Visible = false;
			pnDetail.Visible = false;

			fnSearch();
		}

		/// <summary>
		/// 검색 초기화 버튼 클릭
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnInit_Click(object sender, EventArgs e) {
			pnGrid.Visible = false;
			pnDetail.Visible = false;

			fnInitSearchDate();
		}
		#endregion button event layer
	}
}
