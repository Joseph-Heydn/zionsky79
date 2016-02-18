using System;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;

using Field.SiteManagerAppTier.Dal;

namespace Web.Manage.site {
	public partial class actionLog : BasePage {
		readonly string gConnStr = ConnString.fnGetName("SiteManager");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/site/actionLog.aspx";

			if ( IsPostBack )
				return;


			try {
				fnInitAdminList();
				fnInitDrpMenu();
				fnInit();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{ex.Message}]";
				fnMessageText(vMessage);
			}
		}


		#region initialize layer
		// 검색 조건 초기화
		protected void fnInit() {
			// 기본 검색 날짜는 오늘
			txtStartDate.Text = DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd");
			txtLimitDate.Text = DateTime.Today.AddDays(0).ToString("yyyy-MM-dd");
			drpAdmin.SelectedIndex = -1;
		}

		// 관리자 목록 초기화
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
					string vMessage = $"{fnLabelText("msg_Error_01")} [{Convert.ToString(oDTO.oReturnNo)}]";
					MsgBox(MsgValue.MessageEx(vMessage));
				}
				if ( vResult.Rows.Count <= 0 ) {
					return;
				}


				drpAdmin.DataSource		= vResult;
				drpAdmin.DataValueField = "cAdminNo";
				drpAdmin.DataTextField	= "cAdminId";
				drpAdmin.DataBind();
			} catch ( Exception e ) {
				MsgBox(MsgValue.MessageEx(fnLabelText("msg_Error_01")) + e.Message);
			}
		}

		// 메뉴 목록 바인딩
		protected void fnInitDrpMenu() {
			DataTable vResult = MenuList.fnSetMenuList;
			if ( vResult.Rows.Count == 0 ) {
				drpMenu.DataSource = new DataTable();
				drpMenu.DataBind();
				return;
			}


			DataTable vTable = new DataTable();
			vTable.Columns.Add(new DataColumn("cMenuNo"		, typeof(int)));
			vTable.Columns.Add(new DataColumn("cMenuName"	, typeof(string)));
			string vGroupName = "";

			foreach ( DataRow vRow in vResult.Rows ) {
				if ( Convert.ToInt32(vRow["cOrderBy2"]) == 0 ) {
					vGroupName = vRow["cMenuName"].ToString();
				}

				DataRow vNewRow = vTable.NewRow();
				vNewRow["cMenuNo"]		= vRow["cMenuNo"];
				vNewRow["cMenuName"]	= $"{vGroupName} > {vRow["cMenuName"]}";

				vTable.Rows.Add(vNewRow);
			}

			drpMenu.DataSource		= vTable;
			drpMenu.DataValueField	= "cMenuNo";
			drpMenu.DataTextField	= "cMenuName";
			drpMenu.DataBind();
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


			KWP00102_SG_WS_MANGR_LOG_LIST_R oDTO = new KWP00102_SG_WS_MANGR_LOG_LIST_R
			{	pStartDate	= Convert.ToInt32(vStartDate.ToString("yyyyMMdd"))
			,	pFinishDate	= Convert.ToInt32(vLimitDate.ToString("yyyyMMdd"))
			,	pAdminNo	= Convert.ToInt32(drpAdmin.SelectedValue)
			,	pMenuNo		= Convert.ToInt32(drpMenu.SelectedValue)
			};
			DataTable vResult = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				string vMessage = $"{fnLabelText("msg_Error_01")} [{oDTO.oReturnNo}]";
				fnMessageText(vMessage);
				return;
			}


			fnGridBind(ref vResult);
		}

		// 관리자 작업 내역 바인딩
		private void fnGridBind(ref DataTable pResult) {
			if ( pResult == null ) {
				pnGrid.Visible = false;
				return;
			}


			DataView vDataView = new DataView(pResult)
			{	Sort = "cLogs desc"
			};
			repActionLog.DataSource = vDataView;
			repActionLog.DataBind();

			pnGrid.Visible = true;
		}

		/// <summary>
		/// 작업 상세 정보 중 Get 매개변수를 Grid로 바인딩
		/// </summary>
		/// <param name="pData">http_params 내용</param>
		/// <returns>Get 매개변수 DataTable</returns>
		private DataTable fnGetParams(string pData) {
			NameValueCollection vNameValues = HttpUtility.ParseQueryString(pData);
			DataTable oTable = new DataTable();

			oTable.Columns.Add(new DataColumn("cKey"	, typeof(string)));
			oTable.Columns.Add(new DataColumn("cValue"	, typeof(string)));

			if ( vNameValues.Count <= 0 )
				return oTable;


			foreach ( string vKey in vNameValues.Keys ) {
				// 보여줄 필요없는 데이터는 제외
				if ( vKey == null ) break;
				if ( vKey.StartsWith("__") ) continue;


				DataRow vRow = oTable.NewRow();
				vRow["cKey"]	= vKey;
				vRow["cValue"]	= vNameValues[vKey];

				oTable.Rows.Add(vRow);
			}

			return oTable;
		}

		/// <summary>
		/// 작업 상세 정보 중 Post 매개변수를 Grid로 바인딩
		/// </summary>
		/// <param name="pData">http_params 내용</param>
		/// <returns>Post 매개변수 DataTable</returns>
		private DataTable fnPostParams(string pData) {
			NameValueCollection vNameValues = HttpUtility.ParseQueryString(pData);
			DataTable oTable = new DataTable();

			oTable.Columns.Add(new DataColumn("cKey"	, typeof(string)));
			oTable.Columns.Add(new DataColumn("cValue"	, typeof(string)));

			if ( vNameValues.Count <= 0 ) {
				return oTable;
			}


			foreach ( string vKey in vNameValues.Keys ) {
				// 보여줄 필요없는 데이터는 제외
				if ( vKey == null ) break;
				if ( vKey.StartsWith("__") ) continue;
				if ( vKey.StartsWith("btn") ) continue;
				if ( vKey.StartsWith("Button") ) continue;
				if ( vKey == "VALIDATION" ) continue;


				DataRow vRow = oTable.NewRow();
				vRow["cKey"]	= vKey;
				vRow["cValue"]	= vNameValues[vKey];

				oTable.Rows.Add(vRow);
			}

			return oTable;
		}

		/// <summary>
		/// 관리자 작업 상세 정보 바인딩
		/// </summary>
		/// <param name="pItem">관리자 작업 내역에서 선택된 항목</param>
		private void fnDetailBind(ref RepeaterItem pItem) {
			litIptTime.Text		= ((Literal) pItem.FindControl("cCreateTime")).Text;
			litAdminId.Text		= ((Literal) pItem.FindControl("cAdminId")).Text;
			litMenuName.Text	= ((Literal) pItem.FindControl("cMenuName")).Text;
			litMenuNo.Text		= $"({((Literal) pItem.FindControl("cMenuNo")).Text})";
			litIPAddr.Text		= ((Literal) pItem.FindControl("cHostIp")).Text;

			string vParam = ((Literal) pItem.FindControl("cHttpGet")).Text.Trim();
			repGetParams.DataSource = fnGetParams(vParam);
			repGetParams.DataBind();

			vParam = ((Literal) pItem.FindControl("cHttpPost")).Text.Trim();
			repPostParams.DataSource = fnPostParams(vParam);
			repPostParams.DataBind();

		//	litHttpParams.Text	= rpGetParams.Items.Count == 0 && rpPostParams.Items.Count == 0 ? vParam : string.Empty;
			litHttpParams.Text	= vParam;
			litReferer.Text		= ((Literal) pItem.FindControl("cReferer")).Text;

			pnDetail.Visible = true;
		}
		#endregion binding layer


		#region button event layer
		/// <summary>
		/// 목록에서 항목 클릭
		/// </summary>
		/// <param name="source"></param>
		/// <param name="e"></param>
		protected void repActionLog_OnItemCommand(object source, RepeaterCommandEventArgs e) {
			try {
				RepeaterItem vItem = e.Item;
				txtMainNo.Value = ((Literal) vItem.FindControl("cLogs")).Text;

				switch ( e.CommandName ) {
					// 목록에서 날짜를 클릭하면 해당 날짜로 작업 내역 조회
					case "SELECT_DATE":
						string vWorkDate = ((Literal) vItem.FindControl("cCreateTime")).Text.Substring(0, 10);
						txtStartDate.Text = vWorkDate;
						txtLimitDate.Text = vWorkDate;
						break;
					// 목록에서 관리자를 클릭하면 해당 관리자의 작업 내역 조회
					case "SELECT_ADMIN":
						drpAdmin.SelectedValue = ((Literal) vItem.FindControl("cAdminNo")).Text;
						break;
					// 목록에서 메뉴를 클릭하면 해당 메뉴로 작업 내역 조회
					case "SELECT_MENU":
						drpMenu.SelectedValue = ((Literal) vItem.FindControl("cMenuNo")).Text;
						break;
					// 선택한 작업의 상세 정보 조회
					case "SELECT":
						fnDetailBind(ref vItem);
						return;
					default:
						return;
				}

				fnSearch();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}

		/// <summary>
		/// 검색 버튼 클릭
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnSearch_Click(object sender, EventArgs e) {
			try {
				pnGrid.Visible = false;
				pnDetail.Visible = false;
				fnSearch();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}

		/// <summary>
		/// 검색 초기화 버튼 클릭
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnInit_Click(object sender, EventArgs e) {
			pnGrid.Visible = false;
			pnDetail.Visible = false;
			fnInit();
		}
		#endregion button event layer
	}
}
