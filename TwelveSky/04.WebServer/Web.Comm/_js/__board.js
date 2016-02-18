var gParam = new Array();
var gParamList;
var gCommParam = "";
var gChkCnt = 0;

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
