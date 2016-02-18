using System;
using System.Data;
using System.Web.UI.WebControls;

using Field.TwelveWebAppTier.Dal;

namespace Web.Manage.web.board {
	public partial class write : BasePage {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private static string gThisPage = "write.aspx?m={0}&w={1}&r={2}";
		private static byte gBoardType;

		public write() {
			AuthoriyCheckAllow = true;
		}

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/board/write.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();

				if ( string.IsNullOrEmpty(pWrite.Value) ) {
					return;
				}


				txtIsModify.Value	= "1";
				btnDrop.Visible		= true;

				fnDisplayArticle();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageText(vMessage);
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// initialize parameter
		private void fnInitParameter() {
			pReturn.Value	= Request.QueryString["r"];
			pMenu.Value		= Request.QueryString["m"];
			pWrite.Value	= Request.QueryString["w"];
			pKey.Value		= Request.QueryString["k"];
			pTxt.Value		= Request.QueryString["t"];

			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}
			if ( string.IsNullOrEmpty(pReturn.Value) ) {
				pReturn.Value = $"list.aspx?m={pMenu.Value}";
			}


			gThisPage = string.Format(gThisPage, pMenu.Value, pWrite.Value, pReturn.Value);
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect(pReturn.Value);
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);
			gBoardType = Convert.ToByte(vMenuInfo[0]["cType"]);

			// 동영상인 경우 파일 업로드 숨김
			if ( gBoardType == 4 ) {
				tdFiles.Visible = false;
				tdMovie.Visible = true;
			}


			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}
		#endregion initialize layer


		#region binding layer
		// 게시물 출력
		private void fnDisplayArticle() {
			uspGetArticleDetailInfo oDTO = new uspGetArticleDetailInfo
			{	pMenuNo		= Convert.ToInt32(pMenu.Value)
			,	pPublisher 	= gPublisher
			,	pLanguage	= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pWriteNo   	= Convert.ToInt64(pWrite.Value)
			,	pLimitDate 	= gLimitDate
			,	pIsRead    	= true
			,	pIsAround  	= false
			,
			};
			DataTable vResultSet = oDTO.fnGetResultSet(gConnStr);

			if ( oDTO.oReturnNo != 0 ) {
				fnMessageKeyBack("msgError_06", pReturn.Value);
				return;
			}


			// 제목, 내용 바인딩
			txtSubjects.Text = oDTO.oSubject;
			txtContents.Text = oDTO.oContents;


			string[] vFileInfo = {"","","","",""};

			// 파일 리스트 채우기
			for ( int i = 0; vResultSet.Rows.Count > i; ++i ) {
				string vValue = $"/FileUp/{vResultSet.Rows[i]["cMenuNo"]}/{vResultSet.Rows[i]["cFileNo"]}{{0}}.{vResultSet.Rows[i]["cFileExt"]}";
				lstAttachList.Items.Add(new ListItem(vResultSet.Rows[i]["cFileName"].ToString(), vValue));

				vFileInfo[0] += $"{vResultSet.Rows[i]["cFileName"]}|";
				vFileInfo[1] += $"{vResultSet.Rows[i]["cFileNo"]}|";
				vFileInfo[2] += $"{vResultSet.Rows[i]["cFileExt"]}|";
				vFileInfo[3] += "0|";
				vFileInfo[4] += $"{vValue}|";
			}

			txtRawFiles.Value = vFileInfo[0];	// 유저가 선택한 파일 원래 이름 (확장자 포함)
			txtNewFiles.Value = vFileInfo[1];	// 디비 & 서버에 저장할 이름
			txtFileExts.Value = vFileInfo[2];	// 확장자
			txtFileSize.Value = vFileInfo[3];	// 파일 크기
			txtAllFiles.Value = vFileInfo[4];	// 유저가 업로드 했던 모든 파일 (경로 포함 : /FileUp/1000007/7000000001{0}.jpg)
		}
		#endregion binding layer


		#region control layer
		// 글 저장
		private void fnSaveArticle() {
			string vMenuNo = pMenu.Value;
			if ( vMenuNo == "" ) {
				throw new Exception(fnLabelText("msgError_06"));
			}


			string vPath = Server.MapPath("~/FileUp");
			string[] vFileInfo = new string[6];

			vFileInfo[0] = txtRawFiles.Value;	// 유저가 선택한 파일 원래 이름 (확장자 포함)
			vFileInfo[1] = txtNewFiles.Value;	// 디비 & 서버에 저장할 이름
			vFileInfo[2] = txtFileExts.Value;	// 확장자
			vFileInfo[3] = txtFileSize.Value;	// 파일 크기
			vFileInfo[4] = txtFileList.Value;	// Listbox에 남아있는 파일 (경로 포함 : /FileUp/temp/7000000001.jpg)
			vFileInfo[5] = txtAllFiles.Value;	// 유저가 업로드 했던 모든 파일 (경로 포함)


			fileProcess vProcess = new fileProcess();
			long vWriteNo;
			string vSummary = "", vMainImage = "0", vFileExt = "";
			string[] vImageFile = vProcess.fnImageFiles(vPath, vMenuNo, vFileInfo);

			// 본문 미리보기
			if ( gBoardType == 6 || gBoardType == 7 ) {
				vSummary = txtContents.Text.Length < 300 ? txtContents.Text : txtContents.Text.Substring(0, 300);
			}
			// 대표 이미지
			if ( !string.IsNullOrEmpty(vImageFile[0]) && vImageFile[0].Length > 1 ) {
				vMainImage = vImageFile[1].Split('|')[0];
				vFileExt = vImageFile[2].Split('|')[0];
			}
			// 유튜브 동영상 링크
			if ( txtYoutube.Text.Length > 0 && txtYoutube.Text.IndexOf("youtu", StringComparison.Ordinal) > 0 ) {
				const string vYoutube = "https://youtu.be";
				string vLink = txtYoutube.Text.Substring(txtYoutube.Text.LastIndexOf('/') + 1).Replace("watch?v=","");
				txtYoutube.Text = $"{vYoutube}/{vLink}";
			}


			// 신규 & 변경
			if ( txtIsModify.Value == "1" ) {
				vWriteNo = Convert.ToInt64(pWrite.Value);
				fnFixArticle(vMenuNo, vWriteNo, vSummary, vMainImage, vFileExt);
			} else {
				vWriteNo = fnNewArticle(vMenuNo, vSummary, vMainImage, vFileExt);
			}

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
			,	pAccountNo	= AuthInfo.pAccountNo
			,	pAccountId	= AuthInfo.pAccountId
			,	pWriter		= AuthInfo.pAccountNm
			,	pEmail		= ""
			,	pAgree		= false
			,	pMainImage	= Convert.ToInt64(pImage)
			,	pFileExt	= pExt
			,	pExtLink	= txtYoutube.Text
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

		// 게시물 수정
		private void fnFixArticle(string pMenuNo, long pWriteNo, string pSummary, string pImage, string pExt) {
			uspSetArticleModify oDTO = new uspSetArticleModify
			{	pGameNo		= gGameNo
			,	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pWriteNo	= pWriteNo
			,	pPublisher	= gPublisher
			,	pLanguage	= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pAccountNo	= AuthInfo.pAccountNo
			,	pAgree		= false
			,	pMainImage	= Convert.ToInt64(pImage)
			,	pFileExt	= pExt
			,	pExtLink	= txtYoutube.Text
			,	pHostIp		= fnHostIp()
			,	pSubject	= fnReplaceXSS(txtSubjects.Text)
			,	pSummary	= pSummary
			,	pContents	= txtContents.Text.Replace("src=\"../../FileUp/temp/", $"src=\"/FileUp/{pMenuNo}/")
			};
			int oReturn = oDTO.fnSetModifyInfo(gConnStr);

			if ( oReturn == 0 ) {
				return;
			}


			string vMessage = $"fix[{oReturn}]";
			throw new Exception(vMessage);
		}

		// 게시물 삭제
		private void fnDropArticle() {
			uspSetArticleDelete oDTO = new uspSetArticleDelete
			{	pMenuNo		= Convert.ToInt32(pMenu.Value)
			,	pWriteNo	= Convert.ToInt64(pWrite.Value)
			,	pPublisher	= gPublisher
			,	pLangNo		= Convert.ToByte(ConfigValues.EnvText.cLangNo)
			,	pAccountNo	= AuthInfo.pAccountNo
			};
			int oReturn = oDTO.fnSetDeleteInfo(gConnStr);

			if ( oReturn == 0 ) {
				return;
			}


			string vMessage = $"drop[{oReturn}]";
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

		// 파일 삭제
		private void fnDropFile() {
			string vPath = Server.MapPath("~/FileUp");
			string[] vFileList = txtAllFiles.Value.Split('|');
			fileProcess vProcess = new fileProcess();

			// 파일 삭제
			foreach ( string vFile in vFileList ) {
				vProcess.fnDeleteFile(vPath, vFile);
			}
		}
		#endregion control layer


		#region button event layer
		// 저장 버튼
		protected void btnSave_Click(object sender, EventArgs e) {
			try {
				fnSaveArticle();


				string vMovePage = pReturn.Value;
				string vBasePage = Request.ServerVariables["url"];

				if ( txtIsModify.Value == "1" ) {
					vMovePage = $"{vBasePage}?m={pMenu.Value}";
				} else {
					if ( string.IsNullOrEmpty(vMovePage) ) {
						vMovePage = $"{vBasePage}?m={pMenu.Value}";
					}
				}

				Response.Redirect(vMovePage);
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}

		// 삭제 버튼
		protected void btnDrop_Click(object sender, EventArgs e) {
			try {
				fnDropArticle();
				// 파일 삭제
				fnDropFile();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_08")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
