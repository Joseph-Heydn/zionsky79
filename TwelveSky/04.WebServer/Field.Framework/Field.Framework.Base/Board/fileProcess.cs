using System;
using System.IO;

public class fileProcess {
	// 이미지 파일 정리
	public string[] fnImageFiles(string pPath, string pMenuNo, string[] pFileInfo) {
		string[] oImageFile = new string[4];
		string[] vNewFiles = new string[4];
		string[] vRawImage = pFileInfo[0].Split('|');
		string[] vNewImage = pFileInfo[1].Split('|');
		string[] vFileExts = pFileInfo[2].Split('|');
		string[] vFileSize = pFileInfo[3].Split('|');
		string[] vFileList = pFileInfo[4].Split('|');
		string[] vAllFiles = pFileInfo[5].Split('|');

		// 이미지 파일 번호만 분리
		for ( int i = 0; i < vFileList.Length - 1; ++i ) {
			// /FileUp/temp/770000000000148{0}.jpg
			string vItem = vFileList[i];

			vItem = vItem.Substring(vItem.LastIndexOf('/') + 1);	// 770000000000148{0}.jpg
			vItem = vItem.Substring(0, vItem.IndexOf('{'));			// 770000000000148

			vNewFiles[i] = vItem;
		}


		for ( int i = 0; i < vAllFiles.Length - 1; ++i ) {
			// 전체 리스트 중에 삭제된 파일 찾아서 지우기
			// vNewFiles 배열에서 vNewImage[i]의 값이 있는지 찾기
			if ( Array.IndexOf(vNewFiles, vNewImage[i]) < 0 ) {
				// 유저가 삭제한 파일 서버에서 지우기
				fnDeleteFile(pPath, vAllFiles[i]);
			} else {
				// 생존한 파일 메뉴 폴더로 위치 변경
				fnMoveFile(pPath, pMenuNo, vAllFiles[i]);

				oImageFile[0] += $"{vRawImage[i]}|";
				oImageFile[1] += $"{vNewImage[i]}|";
				oImageFile[2] += $"{vFileExts[i]}|";
				oImageFile[3] += $"{vFileSize[i]}|";
			}
		}

		return oImageFile;
	}

	// 파일 이동
	public void fnMoveFile(string pPath, string pMenuNo, string pFileInfo) {
		string[] vFileInfo = pFileInfo.Split('/');
		string vFolder = $"{pPath}\\{pMenuNo}";
		string vSorcFile = $"{pPath}\\{vFileInfo[2]}\\{vFileInfo[3]}";
		string vDestFile = $"{vFolder}\\{vFileInfo[3]}";

		if ( vFileInfo[2] != "temp" ) {
			return;
		}


		// 폴더 없으면 생성
		if ( !Directory.Exists(vFolder) ) {
			Directory.CreateDirectory(vFolder);
		}

		if ( File.Exists(string.Format(vSorcFile,"")) ) {
			File.Move(string.Format(vSorcFile,""), string.Format(vDestFile,""));
		}
		if ( File.Exists(string.Format(vSorcFile,"-s")) ) {
			File.Move(string.Format(vSorcFile,"-s"), string.Format(vDestFile,"-s"));
		}
		if ( File.Exists(string.Format(vSorcFile,"-m")) ) {
			File.Move(string.Format(vSorcFile,"-m"), string.Format(vDestFile,"-m"));
		}
	}

	// 파일 삭제
	public void fnDeleteFile(string pPath, string pFileInfo) {
		string[] vFileInfo = pFileInfo.Split('/');
		string vFile = $"{pPath}\\{vFileInfo[2]}\\{vFileInfo[3]}";

		if ( File.Exists(string.Format(vFile,"")) ) {
			File.Delete(string.Format(vFile,""));
		}
		if ( File.Exists(string.Format(vFile,"-s")) ) {
			File.Delete(string.Format(vFile,"-s"));
		}
		if ( File.Exists(string.Format(vFile,"-m")) ) {
			File.Delete(string.Format(vFile,"-m"));
		}
	}
}
