using System;
using System.IO;

using Field.TwelveWebAppTier.Dal;

namespace Web.Manage._common._smartEditor.photo_uploader.popup {
	public partial class file_uploader_html5 : PopUpBasePage {
		readonly string gConnStr = ConnString.fnGetName("FieldWeb");

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			Response.Write(fnUploadFiles(sender));
			Response.End();
		}


		#region Control layer
		public string fnUploadFiles(object pObj) {
		//	const string vTmp = "{0}|";
		//	string vFileExt		= string.Empty;
		//	string vFileName	= Request.Headers["file-name"]; 
		//	string vFileSize	= string.Format(vTmp, (Request.Headers["file-size"]));  
			string vExt;
			string vFilePath	= $"{Server.MapPath("~/FileUp")}\\temp\\";
			string vFileType	= Request.Headers["file-type"];
			string vSaveName	= fnGetSaveFileNo(1);
			string vMenuNo		= Request.QueryString["m"];
			// 파일 업로드 경로
			string vDirectory = $"{Server.MapPath("~/FileUp")}\\{vMenuNo}\\";

			// 폴더 없으면 생성
			if ( !Directory.Exists(vDirectory) ) {
				Directory.CreateDirectory(vDirectory);
			}


			switch ( vFileType ) {
				case "image/bmp":
					vExt = "bmp";
					break;
				case "image/gif":
					vExt = "gif";
					break;
				case "image/jpeg":
				case "image/pjpeg":
					vExt = "jpg";
					break;
				case "image/png":
				case "image/x-png":
					vExt = "png";
					break;
				default:
					//MsgBox(fnMessageText(fnLabelText("msg_Error_04")));
					return "error";
			}

			int length = Request.ContentLength;
			byte[] bytes = new byte[length];
			Request.InputStream.Read(bytes, 0, length); 

			string vSaveToFileLoc = $"{vFilePath}\\{vSaveName}.{vExt}"; 

			//파일 저장 
			FileStream fileStream = new FileStream(vSaveToFileLoc, FileMode.Create);
			fileStream.Write(bytes, 0, length);
			fileStream.Close();

			ImageHandler.fnSaveImage(vDirectory, vSaveName, vExt, "-s", 200, 200, 50);
			ImageHandler.fnSaveImage(vDirectory, vSaveName, vExt, "-m", 500, 500, 100);

			return $"&bNewLine=true&sFileName={vSaveName}&sFileURL={vSaveName}"; 
		}

		// 저장할 파일 번호 받기
		private string fnGetSaveFileNo(byte pFileCnt) {
			uspGetNewFileNo oDTO = new uspGetNewFileNo
			{	pFileCnt = pFileCnt
			};
			int oReturnNo = oDTO.fnGetResultInfo(gConnStr);

			if ( oReturnNo == 0 ) {
				return oDTO.oFileNo;
			}


			string vMessage = $"{"msg_Error_06"} [{oDTO.oReturnNo}]";
			MsgBox(vMessage);

			return "";
		}

		// 클라이언트에서 웹서버로 파일 업로드
/*		private static void fnWriteFile(string pFileName, byte[] pBuf) {
			if ( File.Exists(pFileName) ) {
				File.Delete(pFileName);
			}

			FileStream fs = new FileStream(pFileName, FileMode.CreateNew);
			fs.Write(pBuf, 0, pBuf.Length);
			fs.Close();
		}*/
		#endregion Control layer
	}
}
