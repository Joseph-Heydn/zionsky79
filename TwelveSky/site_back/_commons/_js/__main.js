function fnEnterEvent(e) {
	if ( e.keyCode === 13 ) {
		if ( !fnWebLogin() ) {
			return false;
		}

		var obj = document.getElementById(window.gObjectId.btnLogin);
		obj.click();

		return true;
	}

	return true;
}

function fnWebLogin() {
	var txtAccountId = $(window.gObjectId.txtAccountId);
	var txtPassword = $(window.gObjectId.txtPassword);

	if ( txtAccountId.val().length < 3 ) {
		alert(window.gMessage.Alert_01);
		txtAccountId.focus();
		return false;
	}
	if ( txtPassword.val().length < 3 ) {
		alert(window.gMessage.Alert_02);
		txtPassword.focus();
		return false;
	}

	return true;
}

function fnWebLogOut() {
	if ( confirm(window.gMessage.Alert_03) ) {
		return true;
	}

	return false;
}

function fnDownload() {
	alert(window.gMessage.Alert_04);
	$(window.gObjectId.txtAccountId).focus();
}


// main event image rolling
var index = 1;
var autoRolling;

$(function() {
    gameListRolling();
    $(".roll_btn ul li").click(function() {
        index = $(this).index();
        gameListActive();
    });
});

function gameListRolling() {
	autoRolling = setInterval(function() {
		if ( index === $(".roll_btn ul li").length ) {
			index = 0;
		}
		gameListActive(index);
		index++;
	}, 5000);
}

// rolling image list
function gameListActive() {
	var li = $(".roll_btn ul li");

	//li.parent().find("img").css("border","none");
	li.removeClass("on");
	li.eq(index).addClass("on");

	$(".roll_img")
		.find("li")
		.filter("li[gametype='"+ li.eq(index).attr("gametype") +"']")
		.show()
		.stop()
		.animate({ opacity : "1" }, "slow")
		.siblings()
		.hide()
		.stop()
		.animate({ opacity : "0" }, "slow");
}

// slide image
function moveMenu(changeValue) {
	var li = $(".roll_btn ul li");
	index += changeValue;

	if ( index < 0 ) {
		index = li.length - 1;
	}
	if ( index >= li.length ) {
		index = 0;
	}

	clearInterval(autoRolling);
	gameListActive();
	gameListRolling();
}
