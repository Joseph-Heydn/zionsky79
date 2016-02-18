using System;
using System.Data;
using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web.board {
	public partial class items : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/board/items.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();

				fnDisplayTabList();
				fnDisplayArticleList();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		private void fnInitParameter() {
			pMenu.Value		= Request.QueryString["m"];
			pPage.Value		= Request.QueryString["p"];
			pRowCnt.Value	= Request.QueryString["c"];
			pJumpNo.Value	= Request.QueryString["j"];
			pLastNo.Value	= Request.QueryString["l"];
			pIsNext.Value	= Request.QueryString["n"];
			pIsFind.Value	= Request.QueryString["f"];

			// 잘 못된 접근
			if ( pMenu.Value == "" ) {
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
			bool vIsPubs = Convert.ToBoolean(vMenuInfo[0]["cIsPubs"]);

			if ( vMenuInfo.Length < 1 | !vIsPubs ) {
				Response.Redirect("/");
				return;
			}
			if ( vMenuInfo[0]["cType"].ToString() != "6" ) {
				Response.Redirect("/");
				return;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		private void fnDisplayTabList() {
			DataTable vMenuList = MenuList.fnSetMenuList;
			DataRow[] vTabList = vMenuList.Select("cMenuGroup = 1001007 and cOrderBy2 > 1 and cOrderBy2 < 6");
/**
 * 4 : cMenuName
 * 5 : cExecUrl
**/
			repTabList.DataSource = vTabList;
			repTabList.DataBind();

			vMenuList.Dispose();
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


			repArticleList.DataSource = vArticleList;
			repArticleList.DataBind();


			int vNextBlock = oDTO.oBlockCnt;
			int vRecordCnt = vArticleList.Rows.Count;

			// 데이터 없음
			if ( vRecordCnt == 0 ) {
				const string vTmp = "<a href=\"javascript:;\" class=\"on\">1</a>";
				dvEmptyList.Visible = true;
				lblPaging.Text = vTmp;
				return;
			}


			cPaging.pRecordCnt	= vRowCnt;
			cPaging.pCheckBlock	= 1;
			cPaging.pFirstNo	= Convert.ToInt64(vArticleList.Rows[0][0]);
			cPaging.pLimitNo	= Convert.ToInt64(vArticleList.Rows[vRecordCnt-1][0]);

			lblPaging.Text	= cPaging.fnPaging(vNextBlock);
			pRowCnt.Value	= Convert.ToString(cPaging.pRecordCnt + vPageSize);
			pLastNo.Value	= Convert.ToString(cPaging.pFirstNo+1);

			vArticleList.Dispose();
		}

		// 메뉴 css 선택
		protected string fnCheckPage(object pExecUrl) {
			string[] vParams = pExecUrl.ToString().Substring(pExecUrl.ToString().IndexOf('?') + 1).Replace("&","=").Split('=');
			return pMenu.Value == vParams[1] ? "class=\"on\"" : "";
		}

		// 이미지
		protected string fnImageUrl(object cFolder, object cImage, object cExts) {
			return $"<img src=\"/FileUp/{cFolder}/{cImage}.{cExts}\" alt=\"\"/>";
		}
		#endregion binding layer
	}
}
