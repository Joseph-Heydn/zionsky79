using System;
using System.Configuration;
using System.Data;

using Field.TwelveWebAppTier.Dal;

namespace Web.Manage.web.board {
	public partial class list : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private byte gBoardType;

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/board/list.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();

				/**
				 *	1	폐쇄형		basic
				 *	5	자유			basic
				 *	9	읽기전용		basic

				 *	2	FAQ			faq
				 *	8	1:1문의		inquire

				 *	3	이미지		image
				 * 12	사진+폐쇄	image
				 *	4	동영상		movie
				 * 11	영상+폐쇄	movie

				 *	6	미리보기		preview
				 *	7	미리+폐쇄	preview
				**/
				if ( gBoardType == 5 ) {
					fnDisplayNoticeList();
					fnDisplayBest5List();
				}

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


			pPage.Value		= pPage.Value == "" ? "1" : pPage.Value;
			pRowCnt.Value	= pRowCnt.Value == "" ? "0" : pRowCnt.Value;
			pJumpNo.Value	= pJumpNo.Value == "" ? "0" : pJumpNo.Value;
			pLastNo.Value	= pLastNo.Value == "" ? "9223372036854775000" : pLastNo.Value;
			pIsNext.Value	= pIsNext.Value == "" ? "0" : pIsNext.Value;
			pIsFind.Value	= pIsFind.Value == "" ? "0" : pIsFind.Value;
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);
			gBoardType = Convert.ToByte(vMenuInfo[0]["cType"]);

			if ( vMenuInfo.Length < 1 ) {
				Response.Redirect("/");
				return;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		// 공지사항 출력
		private void fnDisplayNoticeList() {
			short vPageNo	= Convert.ToInt16(pPage.Value);
			int vMenuNo		= Convert.ToInt32(pMenu.Value);

			if ( vPageNo > 1 ) {
				return;
			}


			uspGetNoticeList oDTO = new uspGetNoticeList
			{	pMenuNo		= vMenuNo
			,	pPublisher	= gPublisher
			};
			DataTable vNoticeList = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{oDTO.oReturnNo}]";
				fnMessageText(vMessage);
				return;
			}


			repNoticeList.DataSource = vNoticeList;
			repNoticeList.DataBind();

			vNoticeList.Dispose();
		}

		// 인기글 5개 출력
		private void fnDisplayBest5List() {
			short vPageNo	= Convert.ToInt16(pPage.Value);
			int vMenuNo		= Convert.ToInt32(pMenu.Value);

			if ( vPageNo > 1 ) {
				return;
			}


			uspGetBest5List oDTO = new uspGetBest5List
			{	pMenuNo		= vMenuNo
			,	pPublisher	= gPublisher
			};
			DataTable vBest5List = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{oDTO.oReturnNo}]";
				fnMessageText(vMessage);
				return;
			}


			repBest5List.DataSource = vBest5List;
			repBest5List.DataBind();

			vBest5List.Dispose();
		}

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
			if ( gBoardType == 6 || gBoardType == 7 ) {
				vPageSize = Convert.ToByte(ConfigurationManager.AppSettings["sPageSizeS"]);
			}
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
				fnMessageText(vMessage);
				return;
			}


			/**
			 *	1	폐쇄형		basic
			 *	5	자유		basic
			 *	9	읽기전용	basic

			 *	2	FAQ			faq
			 *	8	1:1문의		inquire

			 *	3	이미지		image
			 *	4	동영상		movie

			 *	6	미리보기	preview
			 *	7	미리+폐쇄	preview
			**/
			switch ( gBoardType ) {
				case 1:
				case 5:
				case 9:
					dvList.Visible = true;
					repArticleList.DataSource = vArticleList;
					repArticleList.DataBind();
					break;
				case 2:
				case 8:
					break;
				case 3:
				case 4:
					repMediaList.DataSource = vArticleList;
					repMediaList.DataBind();
					dvMedia.Visible = true;
					break;
				case 6:
				case 7:
					repPreviewList.DataSource = vArticleList;
					repPreviewList.DataBind();
					dvPreview.Visible = true;
					break;
			}


			int vNextBlock = oDTO.oBlockCnt;
			int vRecordCnt = vArticleList.Rows.Count;

			// 데이터 없음
			if ( vRecordCnt == 0 ) {
				const string vTmp = "<a href=\"javascript:;\" class=\"on\">1</a>";
				lblPaging.Text = vTmp;

				switch ( gBoardType ) {
					case 1:
					case 5:
					case 9:
						pnEmptyList.Visible = true;
						break;
					case 2:
					case 8:
						break;
					case 3:
					case 4:
						pnEmptyMedia.Visible = true;
						break;
					case 6:
					case 7:
						pnEmptyPreview.Visible = true;
						break;
				}

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

		// 동영상(youtube) 이미지
		protected string fnMovieImageUrl(object pLink) {
			if ( DBNull.Value.Equals(pLink) ) {
				return "";
			}


			const string vYoutube = "http://img.youtube.com/vi";
			string vLink = pLink.ToString().Substring(pLink.ToString().LastIndexOf('/') + 1);

			return $"{vYoutube}/{vLink}/0.jpg";
		}

		// 이미지인지 동영상인지 확인
		protected string fnImageUrl(object pFolder, object pImage, object pExt) {
			return DBNull.Value.Equals(pImage) ? "" : $"/FileUp/{pFolder}/{pImage}-s.{pExt}";
		}
		#endregion binding layer
	}
}
