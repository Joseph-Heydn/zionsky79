using System;
using System.Data;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web.privacy {
	public partial class history : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");

		public history() {
			AuthoriyCheckAllow = true;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/history.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();

				fnDisplayArticleList();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// parameter 수집
		private void fnInitParameter() {
			pReturn.Value	= fnReturnPage(true);
			pMenu.Value		= Request.QueryString["m"];
			pPage.Value		= Request.QueryString["p"];	// 현재 페이지 번호
			pRowCnt.Value	= Request.QueryString["c"];	// 다음 블럭에 게시물이 있는지 확인
			pJumpNo.Value	= Request.QueryString["j"];	// 건너뛴 페이지 수
			pLastNo.Value	= Request.QueryString["l"];	// 페이지 내 마지막 게시물 번호
			pIsNext.Value	= Request.QueryString["n"];	// 다음블럭 클릭
			pIsFind.Value	= Request.QueryString["f"];	// 검색버튼 클릭

			// 잘 못된 접근
			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
				return;
			}
			if ( string.IsNullOrEmpty(pReturn.Value) ) {
				pReturn.Value = $"history.aspx?m={pMenu.Value}";
			}


			pPage.Value		= pPage.Value == "" ? "1" : pPage.Value;
			pRowCnt.Value	= pRowCnt.Value == "" ? "0" : pRowCnt.Value;
			pJumpNo.Value	= pJumpNo.Value == "" ? "0" : pJumpNo.Value;
			pLastNo.Value	= pLastNo.Value == "" ? "9223372036854775000" : pLastNo.Value;
			pIsNext.Value	= pIsNext.Value == "" ? "0" : pIsNext.Value;
			pIsFind.Value	= pIsFind.Value == "" ? "0" : pIsFind.Value;
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect("/");
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);
			if ( vMenuInfo[0]["cType"].ToString() != "8" ) {
				Response.Redirect("/");
				return;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		// 게시물 목록
		private void fnDisplayArticleList() {
			int vMenuNo			= Convert.ToInt32(pMenu.Value);
			short vPageNo		= Convert.ToInt16(pPage.Value);
			int vRowCnt			= Convert.ToInt32(pRowCnt.Value);
			sbyte vJumpSize		= Convert.ToSByte(pJumpNo.Value);
			sbyte vIsNext		= Convert.ToSByte(pIsNext.Value);
			long vBaseMoveNo	= Convert.ToInt64(pLastNo.Value);
			byte vIsSubmit		= Convert.ToByte(pIsFind.Value);

			byte vBlockSize = Convert.ToByte(ConfigValues.EnvPage.nBlockSize);
			byte vPageSize	= Convert.ToByte(ConfigValues.EnvPage.nPageSize);
			int vCheckNext	= (vPageSize * vBlockSize) + 1;


			// 페이징 값 초기화
			Paging cPaging = new Paging
			{	pPageNo		= vPageNo
			,	pPageSize	= vPageSize
			,	pJumpSize	= vJumpSize
			,	pBlockSize	= vBlockSize
			,	pIsNext		= vIsNext
			,	pCheckNext	= vCheckNext
			};
			cPaging.fnSetParam();

			// 검색 버튼 클릭 확인
			if ( vIsSubmit == 0 ) {
				pIsFind.Value = "0";
			}
			// seek를 시작할 게시물 번호
			if ( vBaseMoveNo == 0 ) {
				vBaseMoveNo = 9223372036854775807;
			}


			uspGetArticleList oDTO = new uspGetArticleList
			{	pMenuNo			= vMenuNo
			,	pPublisher		= gPublisher
			,	pPageSize		= cPaging.pPageSize
			,	pJumpSize		= cPaging.pJumpSize
			,	pCheckNext		= cPaging.pCheckNext
			,	pLastWriteNo	= vBaseMoveNo
			,	pFilterKey		= 0
			,	pFilterTxt		= ""
			};
			DataTable vArticleList = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{oDTO.oReturnNo}]";
				fnMessageBack(vMessage, pReturn.Value);
				return;
			}


			// 글 목록 바인딩
			repArticleList.DataSource = vArticleList;
			repArticleList.DataBind();


			int vNextBlock = oDTO.oBlockCnt;
			int vRecordCnt = vArticleList.Rows.Count;

			// 데이터 없음
			if ( vRecordCnt == 0 ) {
				const string vTmp = "<a href=\"javascript:;\" class=\"on\">1</a>";
				lblPaging.Text = vTmp;
				pnEmptyList.Visible = true;

				return;
			}


			cPaging.pRecordCnt	= vRowCnt;
			cPaging.pCheckBlock	= 1;
			cPaging.pFirstNo	= Convert.ToInt64(vArticleList.Rows[0][0]);
			cPaging.pLimitNo	= Convert.ToInt64(vArticleList.Rows[vRecordCnt-1][0]);
		//	cPaging.pLimitNo	= Convert.ToInt64(vArticleList.Compute("min(cWriteNo)", string.Empty));

			lblPaging.Text	= cPaging.fnPaging(vNextBlock);
			pRowCnt.Value	= Convert.ToString(cPaging.pRecordCnt + vPageSize);
			pLastNo.Value	= Convert.ToString(cPaging.pFirstNo+1);

			vArticleList.Dispose();
		}

		// 진행 상태
		protected string fnReplyStatus(object cRecep, object pReady, object pReply) {
			const string vTmp = "<span style=\"color:{0};\">{1}</span>";
			string vStatus = string.Format(vTmp, "red", fnLabelText("lblReply_01"));

			if ( Convert.ToBoolean(cRecep) ) {
				vStatus = string.Format(vTmp, "green", fnLabelText("lblReply_02"));
			} else if ( Convert.ToBoolean(pReply) ) {
				vStatus = string.Format(vTmp, "blue", fnLabelText("lblReply_03"));
			} else if ( Convert.ToBoolean(pReply) ) {
				vStatus = string.Format(vTmp, "black", fnLabelText("lblReply_04"));
			}

			return vStatus;
		}
		#endregion binding layer
	}
}
