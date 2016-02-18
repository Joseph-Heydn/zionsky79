// 쿠키 생성
function fnSetCookie(pName, pValue, pDay) {
	var vExpire = new Date();
	var vCookies = pName +"="+ escape(pValue) +"; path=/"; // 한글 깨짐을 막기위해 escape(pValue)를 합니다.
	vExpire.setDate(vExpire.getDate() + pDay);

	if ( typeof pDay != "undefined" ) {
		vCookies += "; expires="+ vExpire.toGMTString() +";";
	}

	document.cookie = vCookies;
}

// 쿠키 가져오기
function fnGetCookie(pName) {
	pName = pName +"=";
	var vCookieData = document.cookie;
	var vStart = vCookieData.indexOf(pName);
	var pValue = "";

	if ( vStart !== -1 ) {
		vStart += pName.length;
		var vEnd = vCookieData.indexOf(";", vStart);
		if ( vEnd === -1 ) vEnd = vCookieData.length;
		pValue = vCookieData.substring(vStart, vEnd);
	}

	return unescape(pValue);
}

/**
 * 쿠키 삭제
 * @param cookieName 삭제할 쿠키명
**/
function fnDelCookie(pName) {
	var vExpire = new Date();

	// 어제 날짜를 쿠키 소멸 날짜로 설정한다.
	vExpire.setDate(vExpire.getDate() - 1);
	document.cookie = pName +"= ; expires="+ vExpire.toGMTString() +"; path=/";
}

/*####################################################################
 ●Function	: fnDateAdd(pDate, pDateType, iNum)
	- 사용 방법 ex:  fnDateAdd('2014-03-02','d',30)
 ●설 명		:  날짜 dateadd 함수 
		- pDateType : "y" - 연도
		- pDateType : "m" - 월
		- pDateType : "d" - 일
		- iNum : 더해질 수
###################################################################*/
function fnDateAdd(pDate, pDateType, pNum) {
	var aDate = pDate.split("-");
	var iYar = Number(aDate[0]);
	var iMonth = Number(aDate[1]) - 1;
	var iDay = Number(aDate[2]);

	switch ( pDateType ) {
		case "y":
			iYar = iYar + pNum;
			break;
		case "m":
			iMonth = iMonth + pNum;
			break;
		case "d":
			iDay = iDay + pNum;
			break;
		default:
	}

	var now = new Date(iYar, iMonth, iDay);
	var year = now.getFullYear();
	var mon = (now.getMonth() + 1) > 9 ? ""+ (now.getMonth() + 1) : "0"+ (now.getMonth() + 1);
	var day = now.getDate() > 9 ? ""+ now.getDate() : "0"+ now.getDate();

	return String.format("{0}-{1}-{2}", year, mon, day);
}

/*####################################################################
 ●Function	: String.format
	- 사용 방법 ex:  String.format("가{0}다{1}마","나","라") => "가나다라마"
 ●설 명		:  문자 치환
###################################################################*/
String.format = function () {
	var s = arguments[0];
	for ( var i=0; i < arguments.length - 1; i++ ) {
		var reg = new RegExp("\\{"+ i +"\\}", "gm");
		s = s.replace(reg, arguments[i + 1]);
	}

	return s;
}

/*####################################################################
 ●Function	: String.nowDate 
	- 사용 방법 ex:  String.nowDate() => "2014-08-28"
 ●설 명		:  현재 일자 반환
###################################################################*/
String.nowDate = function () {
	var now = new Date();
	var year = now.getFullYear();
	var mon = (now.getMonth() + 1) > 9 ? ""+ (now.getMonth() + 1) : "0"+ (now.getMonth() + 1);
	var day = now.getDate() > 9 ? ""+ now.getDate() : "0"+ now.getDate();

	//return String.format(year+mon+day);
	return String.format("{0}-{1}-{2}", year, mon, day);
}

// Ajax Json 구현
var fnAjaxSend = function(pUrl, pData, pFunction) {
	var oXML = new XMLHttpRequest();

	oXML.responseJSON = null;
	oXML.open("post", window.gBaseUrl + pUrl, true);
	oXML.responseType = "text";
	oXML.setRequestHeader("Content-Type", "application/json");

	oXML.addEventListener("load", function() {
		oXML.responseJSON = JSON.parse(oXML.responseText);
		pFunction(oXML.responseJSON, oXML);
	});
	oXML.send(JSON.stringify(pData));

	return oXML;
};

function fnMoveBilling(pPage) {
	$(location).attr("href", window.gBill + pPage);
}

function fnPolicy(pWrite) {
	$(location).attr("href", String.format("/web/privacy/policy.aspx?pMenu=1000020&pWrite={0}", pWrite));
}
