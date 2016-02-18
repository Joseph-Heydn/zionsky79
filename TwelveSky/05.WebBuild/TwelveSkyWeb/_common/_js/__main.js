function fnEnterEvent() {
	if ( e.keyCode === 13 ) {
		window.__doPostBack("btnLogin", "");
	}
}

function fnWebLogin() {
	var txtAccountId = $(window.gObject.txtAccountId);
	var txtPassword = $(window.gObject.txtPassword);

	if ( txtAccountId.val() === "" ) {
		alert(window.gMessage.Alert_01);
		txtAccountId.focus();
		return false;
	}
	if ( txtPassword.val() === "" ) {
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
