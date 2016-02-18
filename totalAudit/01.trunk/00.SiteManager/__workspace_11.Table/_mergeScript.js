// Title	: TextFile Merge
// Author	: Choi ji-hwan
// Date		: 2011-07-21
function MergeFile(folderSpec, fileSpec, outFile, mergeBatchFile) {
	var nonFiltered;
	var fso, f, fc, s
	var fileName = new String();
	var fileExt = new String();

	if ( fileSpec.length > 0 ) {
		nonFiltered = false ;
	} else {
		nonFiltered = true;
	}


	fso = new ActiveXObject("Scripting.FileSystemObject");
	f = fso.GetFolder(folderSpec);
	fc = new Enumerator(f.files);

	for ( s = ""; !fc.atEnd(); fc.moveNext() ) {
		fileName = fc.item().Name;
		fileExt = fileName.substr(fileName.length - fileSpec.length, fileSpec.length);

		//파일필터링
		if ( fileExt.toLowerCase() == fileSpec.toLowerCase() || nonFiltered ) {
			if ( s.length == 0 ) {
				s += fileName;
			} else {
				s += "+"+ fileName;
			}
		}
	}

	if ( s.length != 0 ) {
		var shell = new ActiveXObject("WScript.Shell");
		//var makeMergeBatchCmd = "echo copy "+ s +" "+ outFile +" /b > "+ mergeBatchFile;
		var makeMergeBatchCmd = "copy "+ s +" "+ outFile +" /b ";
		WScript.Echo("");
		WScript.Echo("Merge command : ");
		WScript.Echo(makeMergeBatchCmd);
		WScript.Echo("");

		var ins = shell.Exec("cmd /c "+ makeMergeBatchCmd);
		while ( ins.Status==0 ) {
			WScript.Echo("Merging...");
			WScript.Sleep(100);
		}
		WScript.Echo("Outfile : "+ outFile);
		WScript.Echo("End!");

//		var ins = shell.Exec("cmd /c "+ mergeBatchFile);
//		while ( ins.Status == 0 ) {
//			WScript.Echo("merging...");
//			WScript.Sleep(100);
//		}
	} else {
		WScript.Echo("File(s) is not found.");
	}

	return 0;
}

function main() {
	var TargetPath = WScript.arguments(0);		//파일찾는 폴더
	var TargetFiles = WScript.arguments(1);		//*.sql 파일
	var OutFile = WScript.arguments(2);			//출력파일
	var MergeBatchFile = WScript.arguments(3);	//생성할 머지배치파일

	WScript.Echo("Start!");
	if ( TargetPath.length == 0 ) {
		WScript.Echo("0 argument error!")
		return;
	}

	WScript.Echo(TargetPath);
	if ( OutFile.length == 0 ) {
		OutFile = TargetPath +"00.patch_all.sql";
	}

	var cmd = MergeFile(TargetPath, TargetFiles, OutFile, MergeBatchFile);

	WScript.Echo("1 초 후에 자동 종료됩니다.")
	WScript.Sleep(1000);
}

main();
