var txtNewPassword = $(window.gPrefix +"txtNewPassword");
var txtConfirmPass = $(window.gPrefix +"txtConfirmPass");

$(document).ready(function() {
	//패스워드 체크 시작
	txtNewPassword.live("blur", function() {
		if ( txtNewPassword.val().length < 8 ) {
			$("#CheckMessage").show();
			$("#CheckMessage").html(window.gMessage.Alert_02);
			return;
		}
		if ( txtNewPassword.val().length > 16 ) {
			$("#CheckMessage").show();
			$("#CheckMessage").html(window.gMessage.Alert_02);
			return;
		}
		if ( !fnCheckAlpha(txtNewPassword.val()) ) {
			$("#CheckMessage").show();
			$("#CheckMessage").html(window.gMessage.Alert_01);
			return;
		}

		$("#CheckMessage").hide();
		$("#CheckMessage").html("");

		return;
	});
	//패스워드 체크 종료

	//패스워드 확인 체크 시작ConfirmPassword
	txtConfirmPass.live("keyup", function() {
		$("#CheckMessage").hide();
		$("#CheckMessage").html("");

		if ( txtNewPassword.val().length !== txtConfirmPass.val().length && txtNewPassword.val() !== txtConfirmPass.val() ) {
			$("#CheckMessage").show();
			$("#CheckMessage").html(window.gMessage.Alert_03);
		}
	});
	//패스워드 확인 체크 종료
});

function fnCheckForm() {
	var txtAccountId = $(window.gPrefix +"txtAccountId");
	var txtPassword = $(window.gPrefix +"txtPassword");

	if ( txtAccountId.val() === "" ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_04);
		return false;
	}
	if ( txtPassword.val() === "" ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_05);
		return false;
	}
	if ( txtNewPassword.val() === "" ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_05);
		return false;
	}
	if ( txtConfirmPass.val() === "" ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_06);
		return false;
	}
	if ( txtNewPassword.val().length < 8 ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_07);
		return false;
	}
	if ( txtNewPassword.val().length > 16 ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_07);
		return false;
	}
	if ( txtNewPassword.val() !== txtConfirmPass.val() ) {
		$("#CheckMessage").show();
		$("#CheckMessage").html(window.gMessage.Alert_03);
		return false;
	}

	return true;
}

function fnCheckAlpha(pCheckStr) {
	var vTemp = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for ( var j = 0; j < vTemp.length; j++ ) {
		for ( var k = 0; k < pCheckStr.length; k++ ) {
			if ( pCheckStr.charAt(k).indexOf(vTemp.charAt(j)) > -1 ) {

				return (true);
			}
		}
	}

	return (false);
}
