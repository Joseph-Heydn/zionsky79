using System;
using System.IO;
using System.Web;
using System.Linq;
using System.Collections.Generic;

using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web {
	public class uploadFile : IHttpHandler {
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private readonly List<string> gFullName = new List<string>();

		public void ProcessRequest(HttpContext pContext) {
			string vMode = pContext.Request.Form["pMode"];
			string vFileNo = pContext.Request.Form["pFileNo"];

			// 로그인 체크
			if ( !AuthorityManager.fnCheckLogin() ) {
				return;
			}

			if ( vMode == "1" ) {
				fnSaveFile(ref pContext, vFileNo);
			} else {
				fnSaveFiles(ref pContext);
			}
		}


		#region Profile에서 단일 이미지 파일 업로드
		private void fnSaveFile(ref HttpContext pContext, string pFileNo) {
			try {
				const double vLimitSize = (1024 * 100) * 5.01;

				if ( pFileNo == "0" ) {
					pContext.Response.Write("msgAlert_06");
					return;
				}
				if ( pContext.Request.Files.Count > 1 || pContext.Request.Files.Count == 0 ) {
					pContext.Response.Write("msgAlert_05");
					return;
				}


				HttpFileCollection vFiles = pContext.Request.Files;
				int vSize = vFiles[0].ContentLength;

				if ( vSize > vLimitSize || vSize == 0 ) {
					pContext.Response.Write("msgAlert_07");
					return;
				}

				string vExt = ImageHandler.fnFileExt(vFiles[0].ContentType);
				if ( vExt == "error" ) {
					fnOnError_DeleteFile();
					pContext.Response.Write("msgAlert_08");
					return;
				}


				byte[] vFileByte = new byte[vSize];
				vFiles[0].InputStream.Read(vFileByte, 0, vSize);

				/**
				 * 파일 업로드
				 * 클라이언트에서 웹서버로 파일 업로드
				 * 원본 크기로 저장
				 * vFullName 데이터를 처리하던 중 오류 발생시 삭제를 위한 값
				**/
				string vFilePath = pContext.Server.MapPath("~/FileUp/temp/");
				string vFullName = $"{vFilePath}{pFileNo}.{vExt}";
				if ( File.Exists(vFullName) ) {
					File.Delete(vFullName);
				}
				if ( File.Exists($"{vFilePath}{pFileNo}-s.{vExt}") ) {
					File.Delete($"{vFilePath}{pFileNo}-s.{vExt}");
				}

				gFullName.Add(vFullName);
				fnWriteFile(vFullName, vFileByte);

				/**
				 * 파일 크기 조정
				 * -s 리스트에서 보여줄 크기
				**/
				gFullName.Add($"{vFilePath}{pFileNo}-s.{vExt}");
				ImageHandler.fnSaveImage(vFilePath, pFileNo, vExt, "-s", 200, 200, 100);


				pContext.Response.ContentType = "text/plain";
				pContext.Response.Write($"{pFileNo}$${vExt}");
			} catch ( Exception ex ) {
				fnOnError_DeleteFile();
				pContext.Response.Write(ex.Message);
			}
		}
		#endregion Profile에서 단일 이미지 파일 업로드


		#region 게시판에서 다수 이미지 파일 업로드
		private void fnSaveFiles(ref HttpContext pContext) {
			try {
				const string vTmp = "{0}|";
				const double vLimitSize = (1024 * 1024) * 5.01;
				string vFileList = "", vExtList = "", vSizeList = "";
				string vBrowser = HttpContext.Current.Request.Browser.Browser.ToUpper();

				if ( pContext.Request.Files.Count > 5 || pContext.Request.Files.Count == 0 ) {
					pContext.Response.Write("msgAlert_01");
					return;
				}


				HttpFileCollection vFiles = pContext.Request.Files;
				string vFileNo = fnGetNewFileNo(Convert.ToByte(vFiles.Count));

				if ( vFileNo.IndexOf('|') < 0 ) {
					pContext.Response.Write("msgError_03");
					return;
				}


				// 파일 번호 배열로 전환
				string[] vNewFileNo = vFileNo.Split('|');
				string vFilePath = pContext.Server.MapPath("~/FileUp/temp/");

				for ( int i = 0; i < vFiles.Count; ++i ) {
					string vFile;
					int vSize = vFiles[i].ContentLength;
					vSizeList += string.Format(vTmp, vSize);

					if ( vSize > vLimitSize || vSize == 0 ) {
						pContext.Response.Write("msgAlert_02");
						return;
					}

					string vExt = ImageHandler.fnFileExt(vFiles[0].ContentType);
					if ( vExt == "error" ) {
						fnOnError_DeleteFile();
						pContext.Response.Write("msgAlert_08");
						return;
					}


					byte[] vFileByte = new byte[vSize];
					HttpPostedFile vAttach = vFiles[i];

					if ( vBrowser == "IE" || vBrowser == "INTERNETEXPLORER" ) {
						string[] vTmpFiles = vAttach.FileName.Split('\\');
						vFile = vTmpFiles[vTmpFiles.Length - 1];
					} else {
						vFile = vAttach.FileName;
					}

					// 파일 이름 수집
					vExtList += string.Format(vTmp, vExt);
					vFileList += string.Format(vTmp, vFile);
					vFiles[i].InputStream.Read(vFileByte, 0, vSize);

					/**
					 * 파일 업로드
					 * 클라이언트에서 웹서버로 파일 업로드
					 * 원본 크기로 저장
					 * vFullName 데이터를 처리하던 중 오류 발생시 삭제를 위한 값
					**/
				//	gFullName.Clear();
					string vFullName = $"{vFilePath}{vNewFileNo[i]}.{vExt}";
					gFullName.Add(vFullName);
					fnWriteFile(vFullName, vFileByte);

					/**
					 * 파일 크기 조정
					 * -s 리스트에서 보여줄 크기
					 * -m 본문에서 보여줄 크기
					**/
					gFullName.Add($"{vFilePath}{vNewFileNo[i]}-s.{vExt}");
					ImageHandler.fnSaveImage(vFilePath, vNewFileNo[i], vExt, "-s", 200, 200, 50);
					gFullName.Add($"{vFilePath}{vNewFileNo[i]}-m.{vExt}");
					ImageHandler.fnSaveImage(vFilePath, vNewFileNo[i], vExt, "-m", 680, 680, 100);
				}

				pContext.Response.ContentType = "text/plain";
				pContext.Response.Write($"{vFileList}$${vFileNo}$${vExtList}$${vSizeList}");
			} catch ( Exception ex ) {
				fnOnError_DeleteFile();
				pContext.Response.Write(ex.Message);
			}
		}
		#endregion 게시판에서 다수 이미지 파일 업로드


		#region 파일 컨트롤
		// 저장될 파일이름 숫자로 변환
		private string fnGetNewFileNo(byte pFileCnt) {
			uspGetNewFileNo oDTO = new uspGetNewFileNo
			{	pFileCnt = pFileCnt
			};
			int oReturnNo = oDTO.fnGetResultInfo(gConnStr);

			return oReturnNo != 0 ? fnLabelText("msgError_04") : oDTO.oFileNo;
		}

		// 클라이언트에서 웹서버로 파일 업로드
		private static void fnWriteFile(string pFileName, byte[] pBuf) {
			if ( File.Exists(pFileName) ) {
				File.Delete(pFileName);
			}

			FileStream fs = new FileStream(pFileName, FileMode.CreateNew);
			fs.Write(pBuf, 0, pBuf.Length);
			fs.Close();
		}

		// 파일 저장 중 오류 발생 시 업로드 된 파일 삭제
		private void fnOnError_DeleteFile() {
			foreach ( string vFile in gFullName.Where(File.Exists) ) {
				File.Delete(vFile);
			}
		}

		// 라벨에 텍스트 입력
		protected string fnLabelText(string pKey) {
			const string V_WEB_RESOURCE = "/web/board/write.aspx";
			return ResourceValues.AppResourceText(V_WEB_RESOURCE, pKey);
		}
		#endregion 파일 컨트롤


		public bool IsReusable => false;
	}
}
