var numEngSExp = /^[0-9a-zA-Z_]{6,16}$/;
var imgProfile = $(window.gPrefix +"imgProfile");
var txtNickName = $(window.gPrefix +"txtNickName");
var txtFileExts = $(window.gPrefix +"txtFileExts");
var txtCheckImg = $(window.gPrefix +"txtCheckImg");
var txtImageFile = $(window.gPrefix +"txtImageFile");
var txtNickCheck = $(window.gPrefix +"txtNickCheck");
var txtNickOrgnl = $(window.gPrefix +"txtNickOrgnl");
var drpBirthYear = $(window.gPrefix +"drpYear");
var drpBirthMonth = $(window.gPrefix +"drpMonth");
var drpBirthDay = $(window.gPrefix +"drpDay");
var vDelIcon = "<img src=\"/_common/_images/us/portal/sub/icon_del.jpg\" alt=\"\"/>";
var vChkIcon = "<img src=\"/_common/_images/us/portal/sub/icon_check.jpg\" alt=\"\"/>";

$(document).ready(function() {
	// 파일 업로드 버튼
	$("#btnFileUp").click(function() {
		fnFileUpload();
	});

	// 파일 선택되면 자동 업로드
	$("#txtAttachFile").change(function() {
		fnFileUpload();
	});

	// 작성 중인 데이터가 있는지 확인
	fnLoadTempData();

	//닉네임 체크 시작
	txtNickName.live("blur", function() {
		$("#formCheck").html("");
		$("#NicknameCheck").hide();
		$("#NicknameCheck").html("");
		$("#NicknameCheckImg").html("");

		if ( !gNumEngsExp.test(txtNickName.val()) ) {
			$("#NickNameCheck").show();
			$("#NickNameCheck").html(window.gMessage.Alert_01);
			$("#NickNameCheckImg").html(vDelIcon);
			return;
		}

		if ( txtNickName.val().length > 5 ) {
			var vData = { pNickName : txtNickName.val() };

			$.ajax(
				{	url : "/web/wsSignUp.asmx/fnCheckNickName"
				,	contentType : "application/json; charset=utf-8"
				,	type : "post"
				,	dataType : "json"
				,	data : JSON.stringify(vData)
				,	success : function(pData) {
						fnCheckNickProcess(pData.d);
					}
				,	error : function(pError) {
						txtNickCheck.val("N");
						$("#NickNameCheck").show();
						$("#NickNameCheckImg").html(vDelIcon);
						console.log(pError);
						alert(window.gMessage.Alert_01);
						return;
					}
				}
			);
		} else {
			$("#NickNameCheck").show();
			$("#NickNameCheck").html(window.gMessage.Alert_01);
			return;
		}
	});
});

// 닉네임 체크 후 동작
function fnCheckNickProcess(pResult) {
	$("#NickNameCheck").show();
	$("#NickNameCheckImg").html(vDelIcon);

	if ( pResult === "E1" ) {
		$("#NickNameCheck").html(window.gMessage.Alert_02);
		return false;
	} else if ( pResult === "E2" || pResult === "E3" ) {
		$("#NickNameCheck").html(window.gMessage.Alert_03);
		return false;
	} else if ( pResult === "E4" ) {
		$("#NickNameCheck").html(window.gMessage.Alert_04);
		return false;
	} else if ( pResult === "E5" ) {
		$("#NickNameCheck").html(window.gMessage.Alert_05);
		return false;
	} else if ( pResult === "OK" ) {
		txtNickCheck.val("Y");
		$("#NickNameCheck").hide();
		$("#NickNameCheck").html("");
		$("#NickNameCheckImg").html(vChkIcon);
		return false;
	}

	return true;
}

// file upload
function fnFileUpload() {
	var vUpload = $("#txtAttachFile").get(0);
	var vFiles = vUpload.files;
	var vForms = new FormData();

	for ( var i = 0; i < vFiles.length; ++i ) {
		vForms.append(vFiles[i].name, vFiles[i]);
	}
	vForms.append("pMode", "1");
	vForms.append("pFileNo", window.gFileNo);

	$.ajax(
	{	url : "/web/uploadFile.ashx"
	,	type : "POST"
	,	contentType : false
	,	processData : false
	,	data : vForms
//	,	dataType: "json"
	,	success : function(pResult) {
			if ( pResult.substring(0, 3) !== "msg" ) {
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
	var vFolder = "/FileUp/temp";

	// file ext
	txtFileExts.val(tmpList[1]);
	txtImageFile.val(String.format("{0}/{1}-s.{2}", vFolder, tmpList[0], tmpList[1]));
	imgProfile.attr("src", txtImageFile.val());
	txtCheckImg.val("Y");
}

function fnCheckForm() {
	var rdoGender = $("input:radio[name=ctl00$cpContents$optGender]:checked").val();
	if ( txtNickName.val().length < 6 ) {
		alert(window.gMessage.Alert_01);
		return false;
	}
	if ( txtNickName.val() !== txtNickOrgnl.val() && txtNickCheck.val() === "N" ) {
		alert(window.gMessage.Alert_05);
		return false;
	}
	if ( rdoGender == undefined ) {
		alert(window.gMessage.Alert_07);
		return false;
	}

	// 작성된 데이터 임시 저장
	fnSaveTempData();
	var vBirthDay = String.format(
			"{0}-{1}-{2} 0{3}:00:00"
		,	drpBirthYear.val()
		,	drpBirthMonth.val()
		,	drpBirthDay.val()
		,	$("input:radio[name=ctl00$cpContents$optGender]:checked").val()
		);
	$(window.gPrefix +"txtBirthDay").val(vBirthDay);

	return true;
}

// 이미지 화면에서 가리기 삭제
function fnDropImage() {
	var chkDeleteImage = $(window.gPrefix +"chkDeleteImage");

	if ( chkDeleteImage.prop("checked") || txtImageFile.val().length < 5 ) {
		imgProfile.attr("src", "/_common/_images/con_img/my/profile.jpg");
		txtCheckImg.val("Y");
	} else {
		imgProfile.attr("src", txtImageFile.val());
		txtCheckImg.val("N");
	}
}

// 작성된 데이터 임시 저장
function fnSaveTempData() {
	fnSetCookie2("pNickName"	, txtNickName.val()		, 10);
	fnSetCookie2("pFileExts"	, txtFileExts.val()		, 10);
	fnSetCookie2("pImageFile"	, txtImageFile.val()	, 10);
	fnSetCookie2("pBirthYear"	, drpBirthYear.val()	, 10);
	fnSetCookie2("pBirthMonth"	, drpBirthMonth.val()	, 10);
	fnSetCookie2("pBirthDay"	, drpBirthDay.val()		, 10);
}

// 작성 중인 데이터가 있는지 확인
function fnLoadTempData() {
	if ( fnGetCookie("pNickName") !== "" ) {
		txtNickName.val(fnGetCookie("pNickName"));
		txtFileExts.val(fnGetCookie("pFileExts"));
		txtImageFile.val(fnGetCookie("pImageFile"));
		drpBirthYear.val(fnGetCookie("pBirthYear"));
		drpBirthMonth.val(fnGetCookie("pBirthMonth"));
		drpBirthDay.val(fnGetCookie("pBirthDay"));
		imgProfile.attr("src", txtImageFile.val());
	}
}
