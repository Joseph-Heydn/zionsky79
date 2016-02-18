var gParam = new Array();
var gParamList;
var gCommParam = "";
var gChkCnt = 0;

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
function fnDropCookie(pName) {
	var vExpire = new Date();

	// 어제 날짜를 쿠키 소멸 날짜로 설정한다.
	vExpire.setDate(vExpire.getDate() - 1);
	document.cookie = pName +"= ; expires="+ vExpire.toGMTString() +"; path=/";
}

// 테이블 컬럼값 찾기
function fnGetTableText(pThis, pTable, pCellNo) {
	var vRows = pThis.parentNode.parentNode.rowIndex;
	var vCell = pTable.rows.item(vRows).cells;

	return vCell[pCellNo].innerHTML;
}

function fnCheckAll(pObj, pClassName) {
	var vColor = "#dfefff";
	var vObj = document.getElementsByClassName(pClassName);

	if ( !pObj.checked ) {
		vColor = "";
	}

	for ( var i = 0; i < vObj.length; i++ ) {
		vObj[i].checked = pObj.checked;
		var opp = vObj[i].parentElement.parentElement.style;
		opp.backgroundColor = vColor;
	}
}

// checkbox 하나 선택
function fnCheckOne(pObj, pTarget) {
	var opp = pObj.parentElement.parentElement.style;

	if ( pObj.checked ) {
		gChkCnt += 1;
		opp.backgroundColor = "#a6d2ff";
	} else {
		gChkCnt -= 1;
		opp.backgroundColor = "";
	}

	if ( pTarget.length > 1 ) {
		document.getElementById(pTarget).innerHTML = gChkCnt;
	}
}

// move page
function fnMovePages(pPrefix, pParams) {
	var vParamVal;
	var vUrl, vAm = "&", vEq = "=";

	vUrl = gParam[0];
	vUrl += gCommParam;

	if ( gCommParam === "" ) {
		vAm = "?";
	}

	for ( var i=0; i < pParams.length; i++ ) {
		vParamVal = document.getElementById(pPrefix + pParams[i]);

		if ( vParamVal == null ) {
			vUrl += vAm + gParamList[i] + vEq + pParams[i];
			vAm = "&";
			continue;
		}

		switch ( vParamVal.tagName ) {
			case "SPAN":
				vParamVal = vParamVal.innerHTML.replace(/[^0-9]/g,"");
				break;
			case "":
				continue;
			default:
				if ( !vParamVal.tagName.indexOf("Date") )
					vParamVal = vParamVal.value.replace(/[^0-9]/g, "");
				else if ( vParamVal.type === "checkbox" )
					vParamVal = vParamVal.checked;
				else
					vParamVal = vParamVal.value;
				break;
		}

		vUrl += vAm + gParamList[i] + vEq + vParamVal;
		vAm = "&";
	}

	location.href = vUrl;
}

// get url parameter
function fnGetParam() {
	var vParams, vTmp;
	var vUrl = decodeURIComponent(location.href);
	vUrl = decodeURIComponent(vUrl);

	// url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
	vTmp = vUrl.substring(0, vUrl.indexOf("?")).split("/");
	if ( vTmp.length === 1 && vTmp[0] === "" ) {
		vTmp = vUrl.split("/");
		gParam[0] = vTmp[vTmp.length-1];
		return;
	}


	gParam[0] = vTmp[vTmp.length - 1];
	vParams = vUrl.substring(vUrl.indexOf("?") + 1, vUrl.length);
	vParams = vParams.split("&");	// 파라미터 구분자("&") 로 분리

	for ( var i=0, j = 1; i < vParams.length; i++ ) {
		vTmp = vParams[i].split("=");
		if ( vTmp[1] !== "" ) {
			gParam[j++] = vParams[i];
		}
	}
}

// setting url parameter
function fnGetCommParam(pLocalParam) {
	var vTmp, vMatch, vLink = "?";
	gParamList = pLocalParam;

	for ( var i=1; i < gParam.length; i++ ) {
		vMatch = 0;
		vTmp = gParam[i].split("=");

		for ( var j=0; j < gParamList.length; j++ ) {
			if ( vTmp[0] === gParamList[j] ) {
				vMatch = 1;
				break;
			}
		}

		if ( vMatch === 0 ) {
			gCommParam += vLink + gParam[i];
			vLink = "&";
		}
	}
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

// IE 인가? isIE()
function isIE() {
	var vAgt = navigator.userAgent.toLowerCase();

	if ( vAgt.indexOf("msie"		) > -1 ) return true;
	if ( vAgt.indexOf("trident/"	) > -1 ) return true;

	if ( vAgt.indexOf("chrome"		) > -1 ) return false;
	if ( vAgt.indexOf("firefox"		) > -1 ) return false;
	if ( vAgt.indexOf("safari"		) > -1 ) return false;
	if ( vAgt.indexOf("netscape"	) > -1 ) return false;
	if ( vAgt.indexOf("opera"		) > -1 ) return false;

	if ( vAgt.indexOf("staroffice"	) > -1 ) return false;
	if ( vAgt.indexOf("webtv"		) > -1 ) return false;
	if ( vAgt.indexOf("beonex"		) > -1 ) return false;
	if ( vAgt.indexOf("chimera"		) > -1 ) return false;
	if ( vAgt.indexOf("netpositive"	) > -1 ) return false;
	if ( vAgt.indexOf("phoenix"		) > -1 ) return false;
	if ( vAgt.indexOf("skipstone"	) > -1 ) return false;
	if ( vAgt.indexOf("mozilla/5.0"	) > -1 ) return false;

//	return (navigator.appName == "Microsoft Internet Explorer" || navigator.appName == "Netscape") && (parseInt(navigator.appVersion) >= 5);
	return vAgt;
}

function fnLogOut() {
	var vLogOut = "ctl00_btnLogout";
	var obj = document.getElementById(vLogOut);
	obj.click();
}

//////////////////// ShowHideLayer function Start ///////////////////////////////
function MM_swapImgRestore() { //v3.0
	var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
}
function MM_preloadImages() { //v3.0
	var d = document; if (d.images) {
		if (!d.MM_p) d.MM_p = new Array();
		var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
			if (a[i].indexOf("#") !== 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
	}
}
function MM_findObj(n, d) { //v4.01
	var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
		d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
	}
	if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
	for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
	if (!x && d.getElementById) x = d.getElementById(n); return x;
}
function MM_swapImage() { //v3.0
	var i, j = 0, x, a = MM_swapImage.arguments;
	document.MM_sr = new Array;
	for (i = 0; i < (a.length - 2) ; i += 3)
		if ( (x = MM_findObj(a[i])) != null ) {
			document.MM_sr[j++] = x;
			if (!x.oSrc) x.oSrc = x.src;
			x.src = a[i + 2];
		}
}
function MM_showHideLayers() { //v9.0
	var i, v, obj, args = MM_showHideLayers.arguments;
	for (i = 0; i < (args.length - 2) ; i += 3)
		with (document) if (getElementById && ((obj = getElementById(args[i])) != null)) {
			v = args[i + 2];
			if (obj.style) { obj = obj.style; v = (v === 'show') ? 'visible' :(v === 'hide') ? 'hidden' :v; }
			if (obj != null) obj.visibility = v;
		}
}
//////////////////// ShowHideLayer function End ///////////////////////////////
