using System;
using System.Data;
using System.Linq;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web.privacy {
	public partial class contatct : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private static string gThisPage = "contatct.aspx?m={0}";

		public contatct() {
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

				fnDisplayCategory();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// parameter 수집
		private void fnInitParameter() {
			pMenu.Value = Request.QueryString["m"];

			// 잘 못된 접근
			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}


			gThisPage = string.Format(gThisPage, pMenu.Value);
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect("/");
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);
			bool vIsWrite = Convert.ToBoolean(vMenuInfo[0]["cIsWrite"]);

			if ( vMenuInfo[0]["cType"].ToString() != "8" || !vIsWrite ) {
				Response.Redirect("/");
				return;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		// 게시판 카테고리 출력
		private void fnDisplayCategory() {
			uspGetCategoryList oDTO = new uspGetCategoryList
			{	pMenuNo = Convert.ToInt32(pMenu.Value) - 1
			,	pLangNo = Convert.ToByte(ConfigValues.EnvText.cLangNo)
			};
			DataTable vResultSet = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				return;
			}


			DataRow[] vCategory = vResultSet.Select("cStep = 1");
			txtCategoryL.Value = vCategory.Aggregate(
					txtCategoryL.Value, (vText, vRow)
				=>	vText + $"{vRow["cOrderBy"]}|{vRow["cCategory"]}|{vRow["cCateName"]}$$"
				);

			vCategory = vResultSet.Select("cStep = 2");
			txtCategoryM.Value = vCategory.Aggregate(
					txtCategoryM.Value, (vText, vRow)
				=>	vText + $"{vRow["cRefs"]}|{vRow["cOrderBy"]}|{vRow["cCategory"]}|{vRow["cCateName"]}$$"
				);

			txtNickName.Text = AuthInfo.pAccountNm;
		}
		#endregion binding layer


		#region control layer
		// 글 저장
		private void fnSaveArticle() {
			string vMenuNo = pMenu.Value;
			if ( string.IsNullOrEmpty(vMenuNo) ) {
				throw new Exception(fnLabelText("msgError_06"));
			}
			vMenuNo = (Convert.ToInt32(pMenu.Value) - 1).ToString();


			string vPath = Server.MapPath("~/FileUp");
			string[] vFileInfo = new string[6];

			vFileInfo[0] = txtRawFiles.Value;	// 유저가 선택한 파일 원래 이름 (확장자 포함)
			vFileInfo[1] = txtNewFiles.Value;	// 디비 & 서버에 저장할 이름
			vFileInfo[2] = txtFileExts.Value;	// 확장자
			vFileInfo[3] = txtFileSize.Value;	// 파일 크기
			vFileInfo[4] = txtFileList.Value;	// Listbox에 남아있는 파일 (경로 포함 : /FileUp/temp/7000000001.jpg)
			vFileInfo[5] = txtAllFiles.Value;	// 유저가 업로드 했던 모든 파일 (경로 포함)


			fileProcess vProcess = new fileProcess();
			string vSummary = "", vMainImage = "0", vFileExt = "";
			string[] vImageFile = vProcess.fnImageFiles(vPath, vMenuNo, vFileInfo);

			// 대표 이미지
			if ( !string.IsNullOrEmpty(vImageFile[0]) && vImageFile[0].Length > 1 ) {
				vMainImage = vImageFile[1].Split('|')[0];
				vFileExt = vImageFile[2].Split('|')[0];
			}


			long vWriteNo = fnNewArticle(vMenuNo, vSummary, vMainImage, vFileExt);

			// 이미지 정보 저장
			if ( vMainImage != "0" ) {
				fnSaveFileInfo(vMenuNo, vWriteNo, vImageFile);
			}
		}

		// 게시물 추가
		private long fnNewArticle(string pMenuNo, string pSummary, string pImage, string pExt) {
			uspSetArticleWrite oDTO = new uspSetArticleWrite
			{	pGameNo 	= gGameNo
			,	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pPublisher	= gPublisher
			,	pLanguage	= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pCate1		= Convert.ToByte(txtCategoryL.Value)
			,	pCate2		= Convert.ToByte(txtCategoryM.Value)
			,	pAccountNo	= AuthInfo.pAccountNo
			,	pAccountId	= AuthInfo.pAccountId
			,	pWriter		= fnReplaceXSS(txtNickName.Text)
			,	pEmail		= AuthInfo.pEmail
			,	pAgree		= false
			,	pMainImage	= Convert.ToInt64(pImage)
			,	pFileExt	= pExt
			,	pExtLink	= ""
			,	pHostIp		= fnHostIp()
			,	pSubject	= fnReplaceXSS(txtSubjects.Text)
			,	pSummary	= pSummary
			,	pContents	= txtContents.Text.Replace("src=\"../../FileUp/temp/", $"src=\"/FileUp/{pMenuNo}/")
			};
			int oReturn = oDTO.fnSetWriteInfo(gConnStr);

			if ( oReturn == 0 ) {
				return oDTO.oWriteNo;
			}


			string vMessage = $"new[{oReturn}]";
			throw new Exception(vMessage);
		}

		// 이미지 정보 저장
		private void fnSaveFileInfo(string pMenuNo, long pWriteNo, string[] pImageFile) {
			uspSetFileWrite oDTO = new uspSetFileWrite
			{	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pWriteNo	= pWriteNo
			,	pFileName	= pImageFile[0]
			,	pSaveName	= pImageFile[1]
			,	pFileExts	= pImageFile[2]
			,	pFileSize	= pImageFile[3]
			};
			int oReturn = oDTO.fnSetWriteInfo(gConnStr);

			if ( oReturn == 0 ) {
				return;
			}


			string vMessage = $"{fnLabelText("msgError_07")} [{oReturn}]";
			throw new Exception(vMessage);
		}
		#endregion control layer


		#region button event layer
		// 저장 버튼
		protected void btnSave_Click(object sender, EventArgs e) {
			try {
				fnSaveArticle();

				Response.Redirect($"history.aspx?m={Convert.ToInt32(pMenu.Value) - 1}");
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
