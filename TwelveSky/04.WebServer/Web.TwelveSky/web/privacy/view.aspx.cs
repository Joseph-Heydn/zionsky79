using System;
using System.Data;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web.privacy {
	public partial class view : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");

		public view() {
			AuthoriyCheckAllow = true;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/view.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();

				fnDisplayArticle();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// parameter 수집
		private void fnInitParameter() {
			pMenu.Value		= Request.QueryString["m"];
			pWrite.Value	= Request.QueryString["w"];
			pReturn.Value	= Request.QueryString["r"];

			// 잘 못된 접근
			if ( string.IsNullOrEmpty(pMenu.Value) || string.IsNullOrEmpty(pWrite.Value) ) {
				Response.Redirect("/");
			}
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
		// 1:1문의 내역 출력
		private void fnDisplayArticle() {
			int vMenuNo		= Convert.ToInt32(pMenu.Value);
			long vWriteNo	= Convert.ToInt64(pWrite.Value);

			uspGetArticleDetailInfo oDTO = new uspGetArticleDetailInfo
			{	pMenuNo		= vMenuNo
			,	pWriteNo	= vWriteNo
			,	pPublisher	= gPublisher
			,	pLanguage	= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pLimitDate	= gLimitDate
			,	pIsQnA		= true
			,	pIsRead		= false
			,	pIsFile		= true
			,	pIsAround	= false
			};
			DataTable vResultSet = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				Response.Redirect(pReturn.Value);
				return;
			}


			lblSubject.Text		= oDTO.oSubject;
			lblNickName.Text	= oDTO.oWriter;
			lblContents.Text	= oDTO.oContents;
			lblContents2.Text	= oDTO.oAnswers;
			lblStatus.Text		= fnLabelText($"lblReply_0{oDTO.oStatus}");
			// 카테고리
			fnDisplayCategory(oDTO.oCate1, oDTO.oCate2);

			// 파일 목록
			repFileList.DataSource = vResultSet;
			repFileList.DataBind();

			if ( vResultSet.Rows.Count > 0 ) {
				lblFile.Visible = true;
			}
			if ( oDTO.oAnswers.Length > 1 ) {
				pnAnswer.Visible = true;
			}
		}

		// 카테고리 출력
		private void fnDisplayCategory(byte pFirst, byte pSecond) {
			if ( pFirst == 0 || pSecond == 0 ) {
				const string vTmp = "UnKnown";
				lblCategoryL.Text = vTmp;
				lblCategoryM.Text = vTmp;
				return;
			}


			uspGetCategoryList oDTO = new uspGetCategoryList
			{	pMenuNo = Convert.ToInt32(pMenu.Value)
			,	pLangNo = Convert.ToByte(ConfigValues.EnvText.cLangNo)
			};
			DataTable vResultSet = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}
			if ( vResultSet.Rows.Count < 0 ) {
				return;
			}


			DataRow[] vRows = vResultSet.Select($"cCategory = {pFirst} and cRefs = 0");
			lblCategoryL.Text = vRows[0]["cCateName"].ToString();

			vRows = vResultSet.Select($"cRefs = {pFirst} and cCategory = {pSecond} and cStep = 2");
			lblCategoryM.Text = vRows[0]["cCateName"].ToString();
		}
		#endregion binding layer
	}
}
