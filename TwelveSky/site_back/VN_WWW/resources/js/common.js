//gnb 
$(function() {
    //GetTime();
    setInterval("$('#localTime').html(getWorldTime(-4));", 1000);
});

function GetTime() {
	$.ajax({
		url : "/Home/GetNowTime",
		type : "POST",
		dataType : "json",
		success : function(data) {
			if ( data != null ) {
				alert(data["nowTime"]);
				$("#localTime").html(data["nowTime"]);
			}
		},
		error : function(data) {
			//alert("An error has occurred while processing the request.");
			alert(data);
		}
	});
	//setTimeout("GetTime()", 30000);
}

function getWorldTime(tzOffset) {
    var now = new Date();
    var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (tzOffset * 3600000);
    now.setTime(tz);

    var s =
            leadingZeros(now.getDate(), 2) + " " +
            changeMon(now.getMonth() + 1) + " " +
            leadingZeros(now.getFullYear(), 4) + ", " +
            leadingZeros(now.getHours(), 2) + ":" +
            leadingZeros(now.getMinutes(), 2);
    return s;
}

function leadingZeros(n, digits) {
	var zero = "";
	n = n.toString();

	if ( n.length < digits ) {
		for ( var i = 0; i < digits - n.length; i++ )
			zero += "0";
	}
	return zero + n;
}

function changeMon(mon) {
    switch (mon) {
        case 1: return "Jan";
        case 2: return "Feb";
        case 3: return "Mar";
        case 4: return "Apr";
        case 5: return "May";
        case 6: return "Jun";
        case 7: return "Jul";
        case 8: return "Aug";
        case 9: return "Sep";
        case 10: return "Oct";
        case 11: return "Nov";
        case 12: return "Dec";
    };

	return "";
}

//window.onload = function () {
//    alert(getWorldTime(-7));

//    setInterval("$('#clock').html(getWorldTime(-7));", 1000);
//}


//네비
$(function() {
	$(".nav .menu_").addClass("active").find("h2 a img").attr("src", function() {
		return $(this).attr("rel2");
	});

	$(".nav li").filter("[menuIndex='']").filter("[subMenuIndex='']").addClass("on").find("img").attr("src", function() {
		return $(this).attr("rel2");
	});
});


//event
var index = 1;

$(function() {
    gameListRolling();
    $(".roll_btn ul li").click(function() {
        index = $(this).index();
        gameListActive();
    });
});

var autoRolling;

function gameListRolling() {
	autoRolling = setInterval(function() {
		if ( index === $(".roll_btn ul li").length ) {
			index = 0;
		}
		gameListActive(index);
		index++;
	}, 5000);
}

// 게임 리스트 롤링
function gameListActive() {
	var li = $(".roll_btn ul li");
	//li.parent().find("img").css('border','none');
	li.removeClass("on");
	li.eq(index).addClass("on");
	$(".roll_img")
		.find("li")
		.filter("li[gametype='" + li.eq(index).attr("gametype") + "']")
		.show()
		.stop()
		.animate({ opacity : "1" }, "slow")
		.siblings()
		.hide()
		.stop()
		.animate({ opacity : "0" }, "slow");
}

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

//serch
$(function() {
	$("#btnSearch").click(function() {
		search();
	});

	$("#keyword").keypress(function(event) {
		if ( event.keyCode === 13 ) {
			search();
		}
	});
});

// 검색하기
function search() {
    //location.href = "/Guide/SearchResultList/?search=4&keyword=" + $("#keyword").val();
}

// popup
function popup(mypage, myname, w, h, scrolli) {
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	var winprops = "height=" + h + ",width=" + w + ",top=" + wint + ",left=" + winl + ",scrollbars=" + scrolli + ",resizable";
	var win = window.open(mypage, myname, winprops);
	win.focus();

	if ( parseInt(navigator.appVersion) >= 4 ) {
		win.window.focus();
	}
}

// 필드 검사
function check_field(ld, msg) {
	var ret = false;
	var fld = document.getElementById(ld);

	if ( (fld.value = trim(fld.value)) === "" ) {
		if ( msg ) {
			error_field(fld);
			alert(msg);
			fld.focus();
		}
	} else {
		clear_field(fld);
		ret = true;
	}

	return ret;
}


// 필드 오류 표시
function error_field(fld) {
	fld.style.background = "#F8F8F8";
}

// 필드를 깨끗하게
function clear_field(fld) {
	fld.style.background = "#FFFFFF";
}

function trim(s) {
	var i, to_pos;
	var from_pos = to_pos = 0;

	for ( i = 0; i < s.length; i++ ) {
		if ( s.charAt(i) === " " )
			continue;
		else {
			from_pos = i;
			break;
		}
	}

	for ( i = s.length; i >= 0; i-- ) {
		if ( s.charAt(i - 1) === " " )
			continue;
		else {
			to_pos = i;
			break;
		}
	}

	var t = s.substring(from_pos, to_pos);
	//alert(from_pos + ',' + to_pos + ',' + t+'.');

	return t;
}
