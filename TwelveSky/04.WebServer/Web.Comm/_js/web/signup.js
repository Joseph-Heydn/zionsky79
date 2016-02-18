var gNumEngsExp = /^[0-9a-zA-Z_]{6,16}$/;
var gEmailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

var txtAccountId	= $(window.gPrefix +"txtAccountId");
var txtAccountId2	= $(window.gPrefix +"txtAccountId2");
var txtPassword		= $(window.gPrefix +"txtPassword");
var txtPassword2	= $(window.gPrefix +"txtPassword2");
var txtSecEmail		= $(window.gPrefix +"txtSecurityEmail");
var txtNickName		= $(window.gPrefix +"txtNickName");
var chkReceiveMail	= $(window.gPrefix +"chkIsEmailOk");
var txtAccountCheck = $(window.gPrefix +"txtAccountCheck");
var txtNickCheck	= $(window.gPrefix +"txtNickCheck");

$(document).ready(function() {
	var vDelIcon = "<img src=\"/_common/_images/us/portal/sub/icon_del.jpg\" alt=\"\"/>";
	var vChkIcon = "<img src=\"/_common/_images/us/portal/sub/icon_check.jpg\" alt=\"\"/>";

	// 작성 중인 데이터가 있는지 확인
	fnLoadTempData();


	// 계정 체크 시작
	txtAccountId.live("blur", function() {
		$("#formCheckMsg").html("");
		txtAccountCheck.val("N");
		$("#AccountIdCheck").hide();
		$("#AccountIdCheckImg").html("");
		$("#AccountIdCheckOk").hide();
		$("#AccountIdCheckOk").html("");
		$("#AccountIdCheckOkImg").html("");

		if ( !gEmailExp.test(txtAccountId.val()) ) {
			$("#AccountIdCheck").show();
			$("#AccountIdCheck").html(window.gMessage.Error_01);
			$("#AccountIdCheckImg").html(vDelIcon);
			return;
		}


		if ( txtAccountId.val().length > 5 && txtAccountId.val().length < 50 ) {
			var vData = { pAccountId : txtAccountId.val() };

			$.ajax(
				{	url : "/web/wsSignUp.asmx/fnCheckAccountId"
				,	contentType : "application/json; charset=utf-8"
				,	type : "post"
				,	dataType : "json"
				,	data : JSON.stringify(vData)
				,	success : function(pData) {
						var vResult = pData.d;

						$("#AccountIdCheck").show();
						$("#AccountIdCheckImg").html(vDelIcon);

						if ( vResult === "E1" ) {
							$("#AccountIdCheck").html(window.gMessage.Error_02);
							return;
						} else if ( vResult === "E2" || vResult === "E3" ) {
							$("#AccountIdCheck").html(window.gMessage.Error_03);
							return;
						} else if ( vResult === "E4" ) {
							$("#AccountIdCheck").html(window.gMessage.Error_04);
							return;
						} else if ( vResult === "E5" ) {
							$("#AccountIdCheck").html(window.gMessage.Error_01);
							return;
						} else if ( vResult === "OK" ) {
							txtAccountCheck.val("Y");
							$("#AccountIdCheck").hide();
							$("#AccountIdCheck").html("");
							$("#AccountIdCheckImg").html(vChkIcon);
							return;
						}
					}
				,	error : function(pError) {
						txtAccountCheck.val("N");
						$("#AccountIdCheck").show();
						$("#AccountIdCheckImg").html(vDelIcon);
						console.log(pError);
						alert(window.gMessage.Error_19);
						return;
					}
				}
			);
		} else {
			$("#AccountIdCheck").show();
			$("#AccountIdCheck").html(window.gMessage.Error_01);
			$("#AccountIdCheckImg").html(vDelIcon);
			return;
		}
	});
	// 계정 체크 끝

	// 계정 확인 체크 시작
	txtAccountId2.live("keyup", function() {
		$("#formCheckMsg").html("");
		$("#AccountIdCheckOk").hide();
		$("#AccountIdCheckOk").html("");
		$("#AccountIdCheckOkImg").html("");

		if ( txtAccountId.val().length === txtAccountId2.val().length && txtAccountId.val() === txtAccountId2.val() ) {
			$("#AccountIdCheckOk").hide();
			$("#AccountIdCheckOk").html("");
			$("#AccountIdCheckOkImg").html(vChkIcon);
			return;
		} else {
			$("#AccountIdCheckOk").show();
			$("#AccountIdCheckOk").html(window.gMessage.Error_07);
			$("#AccountIdCheckOkImg").html(vDelIcon);
			return;
		}
	});
	// 계정 확인 체크 종료

	// 패스워드 체크 시작
	txtPassword.live("keyup", function() {
		$("#formCheckMsg").html("");
		$("#PasswordCheck").hide();
		$("#PasswordCheck").html("");
		$("#PasswordCheckImg").html("");
		$("#PasswordCheckOk").hide();
		$("#PasswordCheckOk").html("");
		$("#PasswordCheckOkImg").html("");

		if ( !fnCheckAlpha(txtPassword.val()) ) {
			$("#PasswordCheck").show();
			$("#PasswordCheck").html(window.gMessage.Error_08);
			$("#PasswordCheckImg").html(vDelIcon);
			return;
		}
		if ( txtPassword.val().length < 8 ) {
			$("#PasswordCheck").show();
			$("#PasswordCheck").html(window.gMessage.Error_09);
			$("#PasswordCheckImg").html(vDelIcon);
			return;
		}
		if ( txtPassword.val().length > 16 ) {
			$("#PasswordCheck").show();
			$("#PasswordCheck").html(window.gMessage.Error_09);
			$("#PasswordCheckImg").html(vDelIcon);
			return;
		}

		$("#PasswordCheck").hide();
		$("#PasswordCheck").html("");
		$("#PasswordCheckImg").html(vChkIcon);
		return;
	});
	// 패스워드 체크 종료

	// 패스워드 확인 체크 시작ConfirmPassword
	txtPassword2.live("keyup", function() {
		$("#PasswordCheckOk").hide();
		$("#PasswordCheckOk").html("");
		$("#PasswordCheckOkImg").html("");

		if ( txtPassword.val().length === txtPassword2.val().length && txtPassword.val() === txtPassword2.val() ) {
			$("#PasswordCheckOk").hide();
			$("#PasswordCheckOk").html("");
			$("#PasswordCheckOkImg").html(vChkIcon);
			return;
		} else {
			$("#PasswordCheckOk").show();
			$("#PasswordCheckOk").html(window.gMessage.Error_10);
			$("#PasswordCheckOkImg").html(vDelIcon);
			return;
		}
	});
	// 패스워드 확인 체크 종료

	// 발송 전용 메일 체크
	txtSecEmail.live("keyup", function() {
		$("#SecurityEmailCheck").hide();
		$("#SecurityEmailCheck").html("");
		$("#SecurityEmailCheckImg").html("");

		if ( !gEmailExp.test(txtSecEmail.val()) ) {
			$("#SecurityEmailCheck").show();
			$("#SecurityEmailCheck").html(window.gMessage.Error_01);
			$("#SecurityEmailCheckImg").html(vDelIcon);
			return;
		}


		if ( txtSecEmail.val().length > 5 ) {
			if ( !gEmailExp.test(txtSecEmail.val()) ) {
				$("#SecurityEmailCheck").show();
				$("#SecurityEmailCheck").html(window.gMessage.Error_05);
				$("#SecurityEmailCheckImg").html(vDelIcon);
				return;
			}
			if ( txtSecEmail.val() === txtAccountId.val() ) {
				$("#SecurityEmailCheck").show();
				$("#SecurityEmailCheck").html(window.gMessage.Error_06);
				$("#SecurityEmailCheckImg").html(vDelIcon);
			}

			$("#SecurityEmailCheckImg").html(vChkIcon);
		} else {
			$("#SecurityEmailCheck").show();
			$("#SecurityEmailCheck").html(window.gMessage.Error_01);
			$("#SecurityEmailCheckImg").html(vDelIcon);
			return;
		}
	});
	// 발송 전용 메일 체크 종료

	// 닉네임 체크 시작
	txtNickName.live("blur", function() {
		$("#formCheckMsg").html("");
		txtNickCheck.val("N");
		$("#NickNameCheck").hide();
		$("#NickNameCheck").html("");
		$("#NickNameCheckImg").html("");

		if ( !gNumEngsExp.test(txtNickName.val()) ) {
			$("#NickNameCheck").show();
			$("#NickNameCheck").html(window.gMessage.Error_11);
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
						var vResult = pData.d;

						$("#NickNameCheck").show();
						$("#NickNameCheckImg").html(vDelIcon);

						if ( vResult === "E1" ) {
							$("#NickNameCheck").html(window.gMessage.Error_02);
							return;
						} else if ( vResult === "E2" || vResult === "E3" ) {
							$("#NickNameCheck").html(window.gMessage.Error_12);
							return;
						} else if ( vResult === "E4" ) {
							$("#NickNameCheck").html(window.gMessage.Error_13);
							return;
						} else if ( vResult === "E5" ) {
							$("#NickNameCheck").html(window.gMessage.Error_11);
							return;
						} else if ( vResult === "OK" ) {
							txtNickCheck.val("Y");
							$("#NickNameCheck").hide();
							$("#NickNameCheck").html("");
							$("#NickNameCheckImg").html(vChkIcon);
							return;
						}
					}
				,	error : function(pError) {
						txtNickCheck.val("N");
						$("#NickNameCheck").show();
						$("#NickNameCheckImg").html(vDelIcon);
						console.log(pError);
						alert(window.gMessage.Error_19);
						return;
					}
				}
			);
		} else {
			$("#NickNameCheck").show();
			$("#NickNameCheck").html(window.gMessage.Error_11);
			return;
		}
	});
	// 닉네임 체크 끝
	// 가입 폼 체크 끝
});

// 가입 폼 체크 시작
function fnCheckForm() {
	$("#formCheckMsg").html("");
	// *계정 체크
	// 빈값체크 확인
	if ( txtAccountId.val() === "" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_01);
		txtAccountId.focus();
		return false;
	}
	// 이메일 형식 체크
	if ( !gEmailExp.test(txtAccountId.val()) ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_01);
		txtAccountId.focus();
		return false;
	}
	// 이메일 길이 제한
	if ( txtAccountId.val().length > 32 ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_01);
		txtAccountId.focus();
		return false;
	}
	// 중복체크 확인
	if ( txtAccountCheck.val() !== "Y" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_14);
		txtAccountId.focus();
		return false;
	}
	// 계정 확인이랑 동일한지 체크
	if ( txtAccountId.val() !== txtAccountId2.val() ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_07);
		txtAccountId.focus();
		return false;
	}
	// 패스워드 체크
	if ( txtPassword.val() === "" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_09);
		txtPassword.focus();
		return false;
	}
	// 패스워드 규칙 체크
	if ( txtPassword.val().length < 8 ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_09);
		txtPassword.focus();
		return false;
	}
	if ( txtPassword.val().length > 16 ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_09);
		txtPassword.focus();
		return false;
	}
	// 패스워드 확인 체크
	if ( txtPassword.val() !== txtPassword2.val() ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_10);
		txtPassword.focus();
		return false;
	}
	// 발송 전용 메일 체크
	if ( txtSecEmail.val() === "" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_15);
		txtSecEmail.focus();
		return false;
	}
	// 발송 전용 메일 형식 체크
	if ( !gEmailExp.test(txtSecEmail.val()) ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_16);
		txtSecEmail.focus();
		return false;
	}
	// *닉네임 체크
	// 빈값 체크 확인
	if ( txtNickName.val() === "" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_12);
		txtNickName.focus();
		return false;
	}
	// 형식 체크
	if ( !gNumEngsExp.test(txtNickName.val()) ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_11);
		txtNickName.focus();
		return false;
	}
	// 중복 체크 확인
	if ( txtNickCheck.val() !== "Y" ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_17);
		txtNickName.focus();
		return false;
	}
	// *약관 동의 체크
	if ( !$("#chkIsAgree").is(":checked") ) {
		$("#formCheckMsg").show();
		$("#formCheckMsg").html(window.gMessage.Error_18);
		return false;
	}

	// 작성된 데이터 임시 저장
	fnSaveTempData();

	return true;
}


function fnCheckAlpha(checkStr) {
	var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	for ( var j = 0; j < checkOK.length; j++ ) {
		for ( var k = 0; k < checkStr.length; k++ ) {
			if ( checkStr.charAt(k).indexOf(checkOK.charAt(j)) > -1 ) {
				return true;
			}
		}
	}

	return false;
}

// 작성된 데이터 임시 저장
function fnSaveTempData() {
	fnSetCookie2("pAccountId"	, txtAccountId.val(), 10);
	fnSetCookie2("pSecurity"	, txtSecEmail.val()	, 10);
	fnSetCookie2("pNickName"	, txtNickName.val()	, 10);
}

// 작성 중인 데이터가 있는지 확인
function fnLoadTempData() {
	if ( fnGetCookie("pAccountId") !== "" ) {
		txtAccountId.val(fnGetCookie("pAccountId"));
		txtAccountId2.val(fnGetCookie("pAccountId"));
		txtSecEmail.val(fnGetCookie("pSecurity"));
		txtNickName.val(fnGetCookie("pNickName"));
	}
}
