var drpLarge = $(window.gPrefix +"drpLarge");
var drpDetail = $(window.gPrefix +"drpDetail");
var txtCategoryL = $(window.gPrefix +"txtCategoryL");
var txtCategoryM = $(window.gPrefix +"txtCategoryM");

$(document).ready(function() {
	fnSetCategoryL();
	fnInitCategoryM();
	fnSetCategoryM(1);
});


var vLargeCnt = 0;

// 대분류 세팅
function fnSetCategoryL() {
	var i;
	var vValue = new Array();
	var vText = new Array();
	var vTemp = txtCategoryL.val().split("$$");

	for ( i = 0; i < vTemp.length - 1; ++i, ++vLargeCnt ) {
		var vRow = vTemp[i].split("|");
		vValue[vRow[0]-1] = vRow[1];
		vText[vRow[0]-1] = vRow[2];
	}

	for ( i = 0; i < vValue.length; ++i ) {
		drpLarge.append(String.format("<option value=\"{0}\">{1}</option>", vValue[i], vText[i]));
	}
}

var vDetailValue = new Array();
var vDetailText = new Array();

// 중분류 초기화
function fnInitCategoryM() {
	var vTemp = txtCategoryM.val().split("$$");

	for ( var i = 0; i < vTemp.length - 1; ++i ) {
		var vRow = vTemp[i].split("|");

		if ( i < vLargeCnt ) {
			vDetailValue[i + 1] = new Array();
			vDetailText[i + 1] = new Array();
		}

		vDetailValue[vRow[0]][vRow[1]-1] = vRow[2];
		vDetailText[vRow[0]][vRow[1]-1] = vRow[3];
	}
}

// 중분류 세팅
function fnSetCategoryM(pCateNo) {
	drpDetail.empty();

	for ( var i = 0; i < vDetailValue[pCateNo].length; ++i ) {
		drpDetail.append(String.format("<option value=\"{0}\">{1}</option>", vDetailValue[pCateNo][i], vDetailText[pCateNo][i]));
	}
}

// 입력폼 확인
function fnCheckForm() {
	txtCategoryL.val(drpLarge.val());
	txtCategoryM.val(drpDetail.val());

	fnGetContents();
}
