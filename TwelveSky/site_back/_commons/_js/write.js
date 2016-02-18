var txtRawFiles = $(window.gPrefix +"txtRawFiles");
var txtNewFiles = $(window.gPrefix +"txtNewFiles");
var txtFileExts = $(window.gPrefix +"txtFileExts");
var txtFileSize = $(window.gPrefix +"txtFileSize");
var txtAllFiles = $(window.gPrefix +"txtAllFiles");
var txtFileList = $(window.gPrefix +"txtFileList");
var txtSubjects = $(window.gPrefix +"txtSubjects");
var txtContents = $(window.gPrefix +"txtContents");
var txtOnlyText = $(window.gPrefix +"txtOnlyText");
var txtContents2 = window.gPrefix2 +"txtContents";
var txtContents3 = window.gPrefix +"txtContents";
var lstAttachList = window.gPrefix +"lstAttachList";
var pReturn = $(window.gPrefix +"pReturn").val();

$(document).ready(function() {
	fnSetEditor();

	// 파일 업로드 버튼
	$("#btnFileUp").click(function() {
		fnFileUpload();
	});

	// 파일 업로드 이미지 클릭 -> 파일 선택버튼 동작
	$("#btnAttachFile").click(function () {
		$("#txtAttachFile").trigger("click");
	});

	// 파일 선택되면 자동 업로드
	$("#txtAttachFile").change(function() {
		fnFileUpload();
	//	$("#btnFileUp").trigger("click");
	});
});

// TinyMCE 적용
function fnSetEditor() {
	tinymce.init({
		selector : txtContents3
	,	plugins : ["advlist autolink lists link image preview media table paste textcolor colorpicker textpattern imagetools searchreplace fullscreen"]
	,	toolbar : "table | bold italic | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link media searchreplace"
	,	toolbar_items_size : "small"
//	,	menubar : false
	,	force_br_newlines : true
	,	force_p_newlines : false
	,	forced_root_block : false
	,	default_link_target : "_blank"
	,	content_css : "/_common/_css/layout.css"
	});
}

function fnFileUpload() {
	var vUpload = $("#txtAttachFile").get(0);
	var vFiles = vUpload.files;
	var vForms = new FormData();

	for ( var i = 0; i < vFiles.length; ++i ) {
		vForms.append(vFiles[i].name, vFiles[i]);
	}
	vForms.append("pMode", "0");

	$.ajax(
	{	url : "/web/uploadFile.ashx"
	,	type : "POST"
	,	contentType : false
	,	processData : false
	,	data : vForms
//	,	dataType: "json"
	,	success : function(pResult) {
			if ( pResult.substring(0,3) !== "msg" ) {
				fnSetFileList(pResult);
			} else {
				alert(pResult);
			}
		}
	,	error : function(pError) {
			console.log(pError);
			alert(pError.statusText);
		}
	});
}

// 업로드 된 파일 리스트에 추가
function fnSetFileList(pFileList) {
	var tmpList = pFileList.split("$$");
	var vList = new Array();
	var vFileInfo = [];
	var vFolder = "/FileUp/temp";

	vList[0] = tmpList[0].split("|");	// raw file name
	vList[1] = tmpList[1].split("|");	// new file name
	vList[2] = tmpList[2].split("|");	// file ext
	vList[3] = tmpList[3].split("|");	// file size

	// 기존 텍스트에 신규 텍스트 추가
	txtRawFiles.val(txtRawFiles.val() + tmpList[0]);
	txtNewFiles.val(txtNewFiles.val() + tmpList[1]);
	txtFileExts.val(txtFileExts.val() + tmpList[2]);
	txtFileSize.val(txtFileSize.val() + tmpList[3]);


	/**
	 * json 형태로 배열 만들어서 list box에 넣기
	 * script로 추가된 데이터는 behind code에서 읽지 못함ㅜ,.ㅠ
	 * 저장 버튼을 누를 때 리스트에 있는 데이터를 text field로 이동해야 함.
	**/
	var vCodeList = "";
	for ( var i = 0; i < vList[0].length - 1; i++ ) {
		var vCode = String.format("{0}/{1}[0].{2}", vFolder, vList[1][i], vList[2][i]).replace("[0]", "{0}");
		vCodeList += String.format("{0}|", vCode);

		vFileInfo.push(
			{	"code" : vCode
			,	"name" : vList[0][i]
			}
		);
	}

	txtAllFiles.val(txtAllFiles.val() + vCodeList);
	$.each(vFileInfo, function(pKey, pValue) {   
		$("<option/>")
			.val(pValue.code)
			.text(pValue.name)
			.appendTo(lstAttachList);
	});
}

// naver 에디터 내용을 히든 필드에 담기
// btnSave 이벤트시 호출 하는 Javascript Function
function fnGetContents() {
	if ( txtSubjects.val().length < 3 ) {
		alert(window.gMessage.Alert_03);
		txtSubjects.focus();
		return false;
	}


	try {
		tinymce.triggerSave();
		txtOnlyText.val(tinymce.activeEditor.getContent({format : "text"}));

		if ( txtContents.val().length < 1 ) {
			alert(window.gMessage.Alert_04);
			return false;
		}

		// 동영상인 경우 패스
		if ( $(lstAttachList) != undefined ) {
			fnGetImageList();
		}
	} catch ( e ) {
		alert(e.description);
		return false;
	}

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
	if ( $(lstAttachList +" :selected").length < 1 ) {
		alert(window.gMessage.Alert_09);
		return;
	}

	$(lstAttachList).find("option:selected").each(function() {
		var vImage = String.format("<img src=\"{0}\" alt=\"\"/>", String.format($(this).val(), "-m"));
		tinymce.execCommand("mceInsertContent", false, vImage);
	});
}

// 이미지 삭제
function fnDeleteImage() {
	if ( $(lstAttachList +" :selected").length < 1 ) {
		alert(window.gMessage.Alert_10);
		return;
	}

	$(lstAttachList +" option:selected").remove();
	$("#imgAttachFile").attr("src", "/_common/_images/logo20.png");
}

// 현재 Listbox에 남아 있는 이미지 수집
function fnGetImageList() {
	// 이미지 리스트 모두 선택
	$(lstAttachList +" option").prop("selected", true);

	var vImages = "";
	$(lstAttachList +" :selected").each(function(i, pSelected) {
		var tmp = $(pSelected).val();
	//	tmp = tmp.substring(tmp.lastIndexOf("/") + 1);
	//	tmp = tmp.substring(0, tmp.indexOf("."));

		vImages += String.format("{0}|", tmp);
	});

	txtFileList.val(vImages);
}

function fnReplaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}

// 리스트
function fnList() {
	$(location).attr("href", gReturn);
}
