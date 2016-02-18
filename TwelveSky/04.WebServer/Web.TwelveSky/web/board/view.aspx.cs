using System;
using System.Data;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web.board {
	public partial class view : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private bool gIsWrite;

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/board/view.aspx";

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
		private void fnInitParameter() {
			pMenu.Value		= Request.QueryString["m"];
			pPage.Value		= Request.QueryString["p"];	// 현재 페이지 번호
			pWrite.Value	= Request.QueryString["w"];	// 게시물 번호
			pReturn.Value	= Request.QueryString["r"];

			// 잘 못된 접근
			if ( string.IsNullOrEmpty(pMenu.Value) || string.IsNullOrEmpty(pWrite.Value) ) {
				Response.Redirect("/");
			}
			if ( string.IsNullOrEmpty(pReturn.Value) ) {
				pReturn.Value = $"list.aspx?m={pMenu.Value}";
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);
			bool vIsPubs = Convert.ToBoolean(vMenuInfo[0]["cIsPubs"]);
			gIsWrite = Convert.ToBoolean(vMenuInfo[0]["cIsWrite"]);

			if ( vMenuInfo.Length < 1 ) {
				Response.Redirect(pReturn.Value);
				return;
			}
			if ( !vIsPubs ) {
				Response.Redirect(pReturn.Value);
				return;
			}
			switch ( vMenuInfo[0]["cType"].ToString() ) {
				case "1":
				case "2":
				case "7":
				case "9":
				case "10":
					Response.Redirect("/");
					return;
			}


			// 덧글 영역 활성화
			if ( Convert.ToBoolean(vMenuInfo[0]["cIsReply"]) && AuthInfo.pAccountNo > 0 ) {
				lblCommtTitle.Visible	= true;
				txtCommtArea.Visible	= true;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		private void fnDisplayArticle() {
			int vMenuNo		= Convert.ToInt32(pMenu.Value);
			long vWriteNo	= Convert.ToInt64(pWrite.Value);

			uspGetArticleDetailInfo oDTO = new uspGetArticleDetailInfo
			{	pMenuNo		= vMenuNo
			,	pWriteNo	= vWriteNo
			,	pPublisher	= gPublisher
			,	pLanguage	= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pLimitDate	= gLimitDate
			,	pIsRead		= false
			,	pIsAround	= false
			,	pIsFile		= true
			};
			DataTable vResultSet = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				Response.Redirect(pReturn.Value);
				return;
			}


			// 수정, 삭제 버튼 활성화
			if ( gIsWrite && AuthInfo.pAccountNo > 0 && AuthInfo.pAccountNo == oDTO.oAccountNo ) {
				liEdit.Visible = true;
				liDrop.Visible = true;
			}

			txtSubject.Text		= oDTO.oSubject;
			txtWriter.Text		= oDTO.oWriter;
			txtDate.Text		= $"{oDTO.oCreateTime:yyyy-MM-dd HH:mm:ss}";
			txtHits.Text		= oDTO.oViewCnt.ToString();
			txtContents.Text	= oDTO.oContents;
			btnLike.Text		= oDTO.oRecmdCnt.ToString();
			btnHate.Text		= oDTO.oAgnstCnt.ToString();

			if ( AuthInfo.pAccountNo > 0 && AuthInfo.pAccountNo != oDTO.oAccountNo ) {
				btnLike.OnClientClick = "return fnReport(1)";
				btnHate.OnClientClick = "return fnReport(3)";
			}

			// 파일 목록
			repFileList.DataSource = vResultSet;
			repFileList.DataBind();

			if ( vResultSet.Rows.Count > 0 ) {
				dvFileList.Visible = true;
			}
		}
		#endregion binding layer
	}
}
