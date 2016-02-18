// 에디터 객체
var oEditors = [];

$(document).ready(function() {
	fnSetEditor();

	// 파일 선택버튼 -> 이미지 클릭
	$("#btnAttachFile").click(function () {
		$("#txtAttachFile").trigger("click");
	});

	// 파일 선택되면 자동 업로드
	$("#txtAttachFile").change(function() {
		fnFileUpload();
	//	$("#btnUpload").trigger("click");
	});
});

// 에디터 적용
function fnSetEditor() {
	if ( window.gObjectId.txtContents.val() == null ) {
		return;
	}


	nhn.husky.EZCreator.createInIFrame(
		{	oAppRef: oEditors
		,	elPlaceHolder: window.gObjectId.txtContents2
		,	sSkinURI: "/_common/_smartEditor/SmartEditor2Skin.html"
		,	htParams: {
				bUseToolbar: true
			,	bUseVerticalResizer: true
			,	bUseModeChanger: true
			,	fOnBeforeUnload: function() {}
			}
		}
	);
}

// Ajax fileup
$(function() {
	$("#btnUpload").click(function() {
		fnFileUpload();
	});
});

function fnFileUpload() {
	var vUpload = $("#txtAttachFile").get(0);
	var vFiles = vUpload.files;
	var vForms = new FormData();

	for ( var i = 0; i < vFiles.length; i++ ) {
		vForms.append(vFiles[i].name, vFiles[i]);
	}

	$.ajax(
	{	url : "/web/uploadFile.ashx"
	,	type : "POST"
	,	contentType : false
	,	processData : false
	,	data : vForms
//	,	dataType: "json"
	,	success : function(pResult) {
			fnSetFileList(pResult);
		}
	,	error : function(pError) {
			alert(pError.statusText);
		}
	});
}

// 업로드 된 파일 리스트에 추가
function fnSetFileList(pFileList) {
	var tmpList = pFileList.split("|||");
	var vList = new Array();
	var vRawData = new Array();
	var vFileInfo = [];
	var vFolder = "/FileUp/temp";

	vList[0] = tmpList[0].split("|");	// raw file name
	vList[1] = tmpList[1].split("|");	// new file name
	vList[2] = tmpList[2].split("|");	// file ext
	vList[3] = tmpList[3].split("|");	// file size

	// 기존 텍스트 임시 저장
	vRawData[0] = window.gObjectId.txtRawFiles;
	vRawData[1] = window.gObjectId.txtNewFiles;
	vRawData[2] = window.gObjectId.txtFileExts;
	vRawData[3] = window.gObjectId.txtFileSize;
	vRawData[4] = window.gObjectId.txtAllFiles;

	// 기존 텍스트에 신규 텍스트 추가
	vRawData[0].val(vRawData[0].val() + tmpList[0] +"|");
	vRawData[1].val(vRawData[1].val() + tmpList[1] +"|");
	vRawData[2].val(vRawData[2].val() + tmpList[2] +"|");
	vRawData[3].val(vRawData[3].val() + tmpList[3]);


	/**
	 * json 형태로 배열 만들어서 list box에 넣기
	 * script로 추가된 데이터는 behind code에서 읽지 못함ㅜ,.ㅠ
	 * 저장 버튼을 누를 때 리스트에 있는 데이터를 text field로 이동해야 함.
	**/
	var vCodeList = "";
	for ( var i = 0; i < vList[0].length; i++ ) {
		var vCode = String.format("{0}/{1}[0].{2}", vFolder, vList[1][i], vList[2][i]).replace("[0]", "{0}");
		vCodeList += String.format("{0}|", vCode);

		vFileInfo.push(
			{	"code" : vCode
			,	"name" : vList[0][i]
			}
		);
	}

	vRawData[4].val(vRawData[4].val() + vCodeList);
	$.each(vFileInfo, function(pKey, pValue) {   
		$("<option/>")
			.val(pValue.code)
			.text(pValue.name)
			.appendTo(window.gObjectId.lstAttachList);
	});
}

// 에디터 컨텐츠를 히든 필드에 담기 - btnSave 이벤트시 호출 하는 Javascript Function
function fnGetContents() {
	if ( window.gObjectId.txtSubjects.val().length < 1 ) {
		alert(window.gMessage.Alert_03);
		window.gObjectId.txtSubjects.focus();
		return false;
	}

	var vContents = window.oEditors.getById[window.gObjectId.txtContents2].getIR();
	if ( vContents.length < 1 ) {
		alert(window.gMessage.Alert_04);
		return false;
	}


	window.gObjectId.txtContents.val(vContents);
	fnGetImageList();

	return true;
}

// 리스트에서 이미지 선택시 미리보기
function fnPreviewImage(pObj) {
	var vImage = $(pObj).find("option:selected").val();
	if ( vImage === undefined ) {
		return;
	}


	$("#imgAttachFile").attr("src", String.format(vImage,"-s"));
}

// 리스트에서 선택한 이미지 본문에 삽입
function fnSetImage2Document() {
	$(window.gObjectId.lstAttachList).find("option:selected").each(function() {
		var vImage = String.format("<img src=\"{0}\" alt=\"\"/>", String.format($(this).val(), "-m"));
		window.oEditors.getById[window.gObjectId.txtContents2].exec("PASTE_HTML", [vImage]);
	});
}

// 이미지 삭제
function fnDeleteImage() {
	$(window.gObjectId.lstAttachList +" option:selected").remove();
	$("#imgAttachFile").attr("src", "/_common/_images/logo20.png");
}

// 현재 Listbox에 남아 있는 이미지 수집
function fnGetImageList() {
	// 이미지 리스트 모두 선택
	$(window.gObjectId.lstAttachList +" option").prop("selected", true);

	var vImages = "";
	$(window.gObjectId.lstAttachList +" :selected").each(function(i, pSelected) {
		var tmp = $(pSelected).val();
	//	tmp = tmp.substring(tmp.lastIndexOf("/") + 1);
	//	tmp = tmp.substring(0, tmp.indexOf("."));

		vImages += String.format("{0}|", tmp);
	});

	window.gObjectId.txtFileList.val(vImages);
}

function fnReplaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}
