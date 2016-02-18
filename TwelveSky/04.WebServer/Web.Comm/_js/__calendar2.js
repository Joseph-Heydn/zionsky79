// property
var bgFont = null;
var setYear = 1930;
var m_CurrentDate = null;
var initObject = false;
var DPYear, DPMonth;
var divYear, divMonth;
var txtYearName, txtMonthName;

// public methods
// picker의 기본값을 주고 시작
function init(date) {
	if ( date == null ) {
		date = new Date();
	}

	// object 초기화
	if ( initObject === false ) {
		divYear = document.getElementById("divYear");
		divMonth = document.getElementById("divMonth");
		DPYear = document.getElementById("DPYear");
		DPMonth = document.getElementById("DPMonth");
		txtYearName = document.getElementById("txtYearName");
		txtMonthName = document.getElementById("txtMonthName");
		initObject = true;
	}

	m_CurrentDate = date;
	_build();
}

// private methods
// 지정된 날짜로 달력을 출력
function _build(date) {
	var inFlag, i, y, j;
	var DPToday = document.getElementById("DPToday");
	var DPCalendar = document.getElementById("DPCalendar");
	var isIE = ( document.all ) ? true : false;
	var today = new Date();

	if ( date == null ) {
		date = m_CurrentDate;
	}
	if ( date == null ) {
		date = today;
	}

	// 날짜로 부터 년, 월을 가져옴
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	if ( setYear === "" || setYear == null ) {
		setYear = year - 3;
	}

	// 현재 연도 선택
	DPYear.options.length = 0;
	for ( i=0, y=setYear; y < year + 20; ++i, ++y ) {
		DPYear.options[i] = new Option(y +"년", y);
		if ( y === year ) {
			DPYear.selectedIndex = i;
		}
	}

	// 현재 월 선택
	DPMonth.selectedIndex = month - 1;
	// 오늘 날짜 입력
	DPToday.innerHTML = DP_FormatDate(today);

	// 날짜 레이어 값 변경
	var arMonth = new Array("01","02","03","04","05","06","07","08","09","10","11","12");
	txtMonthName.innerHTML = "↕ "+ arMonth[DPMonth.selectedIndex];
	txtYearName.innerHTML = "↕ "+ DPYear.value;
	divYear.style.visibility = "hidden";
	divMonth.style.visibility = "hidden";


	// 달력 초기화
	while ( DPCalendar.rows.length > 4 ) {
		DPCalendar.deleteRow(2);
	}


	i = 2;
	var cal = new DP_Calendar(year, month);
	while ( cal.hasNextWeek() ) {
		j = 0;
		var w = cal.nextWeek();
		var tr = DPCalendar.insertRow(i);

		while ( w.hasNextDate() ) {
			var d = w.nextDate();
			var td = tr.insertCell(j);

			// 현재 월과 아닌 월을 구분하여 style 적용
			td.id = DP_FormatDate(d);
			if ( cal.month === d.getMonth() ) {
				inFlag = "Y";
				td.className = "DPDate";
			} else {
				inFlag = "N";
				td.className = "DPDate2";
			}

			// 오늘 날짜 font 변경
			if ( DP_DateEquals(d, today) ) {
				td.style.fontWeight = "bold";
				td.style.color = "#660000";
			}
			// 선택된 날짜 font 변경
			if ( DP_DateEquals(d, m_CurrentDate) ) {
				td.style.fontWeight = "bold";
				td.style.backgroundColor = "#ffffcc";
			}

			if ( inFlag === "Y" ) {
				if ( d.getDay() === 0 ) {
					td.style.color = "#ff0000";
				}
				if ( d.getDay() === 6 ) {
					td.style.color = "#0000ff";
				}
			}

			td.innerHTML = d.getDate();
			++j;
		}

		++i;
	}

	// 달력 출력이 완료되면 iframe의 크기를 재조정한다.
	var DPTable = document.getElementById("DPTable");

	if ( isIE ) {
		window.resizeTo(DPTable.offsetWidth, DPTable.offsetHeight);
	} else {
		var vIFRAME = "DP_IFRAME";
		document.body.style.overflow = "hidden";
		parent.document.getElementById(vIFRAME).height = DPTable.offsetHeight +"px";
	}

	return cal;
}

// 날짜 선택
function _pickDate(date_str) {
	if ( parent.DP_GetPickedDate != null ) {
		parent.DP_GetPickedDate(date_str);
	}
}

// 레이어 닫기
function _disablePicker() {
	divYear.style.visibility = "hidden";
	divMonth.style.visibility = "hidden";
	parent.dpWin = "none";

	if ( parent.DP_DisablePicker != null ) {
		parent.DP_DisablePicker();
	}
}

// HTML event handlers (오늘 클릭)
function DPCalendar_click() {
	var today = new Date();
	var e = event.srcElement;

	if ( e.tagName === "SPAN" && e.id === "DPToday" ) {
		_build(today);
	//	_pickDate(e.innerHTML);
	} else if ( e.tagName === "TD" && (e.className === "DPDate" || e.className === "DPDate2") ) {
		_pickDate(e.id);
	}

	return false;
}

// onMouseOver Event
function fnOver() {
	var e = event.srcElement;
	var a = e.className;
	var b = e.style.backgroundColor;
	var c = e.tagName;

	if ( a === "DPDate" ) {
		bgFont = "#ffffff";
	}
	if ( a === "DPDate2" ) {
		bgFont = "#eeeeee";
	}
	if ( b === "#ffffcc" && (a === "DPDate" || a === "DPDate2") ) {
		bgFont = "#ffffcc";
	}
	if ( c === "TD" && (a === "DPDate" || a === "DPDate2") ) {
		e.style.backgroundColor = "#ccff00";
	}
}

// onMouseOut Event
function fnOut() {
	var e = event.srcElement;
	var a = e.className;
//	b = e.style.backgroundColor;
	var c = e.tagName;

	if ( c === "TD" && (a === "DPDate" || a === "DPDate2") ) {
		e.style.backgroundColor = bgFont;
	}
}

// 연도 레이어에서 이동할 연도 선택
function DPCalendar_JumpYear(pSelectYear) {
	var vMove = pSelectYear - DPYear.value;
	if ( vMove === 0 ) {
		return;
	}

	DPCalendar_MoveYear(vMove);
}

// 연도로 이동 (pMove : 1,2,3,...-1,-2,-3,...)
function DPCalendar_MoveYear(pMove) {
	var dpYear = DPYear.selectedIndex + pMove;
	var dpMonth = DPMonth.selectedIndex;
	var dpYearDesc = DPYear.options[dpYear].value;
	var dpMonthDesc = DPMonth.options[dpMonth].value;
	DPYear.selectedIndex = dpYear;

	if ( (dpYear === -1 || dpYearDesc === "") || (dpMonth === -1 || dpMonthDesc === "") ) {
		return;
	}


	var year = Number(DPYear.options[DPYear.selectedIndex].value);
	var month = Number(DPMonth.options[DPMonth.selectedIndex].value);
	var date = new Date(year, month - 1, 1);

	_build(date);
}

// 이전 월로 이동
function DPCalendar_PrevMonth() {
	var dpYear = DPYear.selectedIndex;
	var dpMonth = DPMonth.selectedIndex;
	var dpYearDesc = DPYear.options[DPYear.selectedIndex].value;
	var dpMonthDesc = DPMonth.options[DPMonth.selectedIndex].value;

	if ( (dpYear === -1 || dpYearDesc === "") || (dpMonth === -1 || dpMonthDesc === "") ) {
		return;
	}


	var year = Number(DPYear.options[DPYear.selectedIndex].value);
	var month = Number(DPMonth.options[DPMonth.selectedIndex].value);
	var date = new Date(year, month - 2, 1);
//	var arMonth = new Array("12","01","02","03","04","05","06","07","08","09","10","11");

	_build(date);
}

// 다음 월로 이동
function DPCalendar_NextMonth() {
	var dpYear = DPYear.selectedIndex;
	var dpMonth = DPMonth.selectedIndex;
	var dpYearDesc = DPYear.options[DPYear.selectedIndex].value;
	var dpMonthDesc = DPMonth.options[DPMonth.selectedIndex].value;

	if ( (dpYear === -1 || dpYearDesc === "") || (dpMonth === -1 || dpMonthDesc === "") ) {
		return;
	}


	var year = Number(DPYear.options[DPYear.selectedIndex].value);
	var month = Number(DPMonth.options[DPMonth.selectedIndex].value);
	var date = new Date(year, month, 1);

//	var arMonth = new Array("02","03","04","05","06","07","08","09","10","11","12","01");

	_build(date);
}

// 월 레이어에서 이동할 월 선택
function DPCalendar_ChangeMonth(pMonth) {
	var dpYear = DPYear.selectedIndex;
//	var dpMonth = DPMonth.selectedIndex;
	var dpYearDesc = DPYear.options[DPYear.selectedIndex].value;
	var dpMonthDesc = pMonth;
	DPMonth.value = pMonth;

	if ( (dpYear === -1 || dpYearDesc === "") || dpMonthDesc === "" ) {
		return;
	}


	var year = Number(DPYear.options[DPYear.selectedIndex].value);
	var month = Number(pMonth);
	var date = new Date(year, month - 1, 1);

	_build(date);
}

// 년도 레이어
function fnYearList(pThisYear, pThisMonth) {
	var vHtml = "", vThisYear = DPYear.value;
	var vTmpStyle, vTmpMsOut;
	var vMarginTop, vMarginLeft;
	var vPrevYear, vNextYear, vYearCnt = 10;
	var vYear = Number(parseInt((Number(pThisYear) - 1) / 10) * 10 + 1);

	var vStyle = "float:left; width:35px; height:17px; text-align:center; padding-top:2px; border:1px solid #c2c2c2; background-color:#e5e5e5; font-size:11px; cursor:pointer;";
	var vMouseOver = "this.style.backgroundColor='#c2c2c2';";
	var vMouseOut = "this.style.backgroundColor='#e5e5e5';";

	// 년도선택 레이어 설정
	for ( var i = -1, j = -2; j < vYearCnt; ++i, ++j ) {
		vMarginTop = ((i+1) >= 4) ? 2 : 0;
		vMarginLeft = ((i+1) % 4 === 0) ? 0 : 2;

		vTmpStyle = vStyle;
		vTmpMsOut = vMouseOut;

		if ( vThisYear === vYear + i ) {
			vTmpStyle = vStyle.replace("#e5e5e5", "#ffffcc");
			vTmpMsOut = vMouseOut.replace("#e5e5e5", "#ffffcc");
		}

		if ( i === -1 ) {
			vPrevYear = (vYear - vYearCnt);
			vHtml += "<div style=\"margin-top:"+ vMarginTop +"px; margin-left:"+ vMarginLeft +"px; "+ vStyle +"\" onClick=\"fnYearList("+ vPrevYear +", "+ pThisMonth +")\" onMouseOver=\""+ vMouseOver +"\" onMouseOut=\""+ vMouseOut +"\">Prev</div>";
		} else if ( i === vYearCnt ) {
			vNextYear = (vYear + vYearCnt);
			vHtml += "<div style=\"margin-top:"+ vMarginTop +"px; margin-left:"+ vMarginLeft +"px; "+ vStyle +"\" onClick=\"fnYearList("+ vNextYear +", "+ pThisMonth +")\" onMouseOver=\""+ vMouseOver +"\" onMouseOut=\""+ vMouseOut +"\">Next</div>";
		} else {
			vHtml += "<div style=\"margin-top:"+ vMarginTop +"px; margin-left:"+ vMarginLeft +"px; "+ vTmpStyle +"\" onClick=\"DPCalendar_JumpYear("+ String(vYear + i) +")\" onMouseOver=\""+ vMouseOver +"\" onMouseOut=\""+ vTmpMsOut +"\">"+ String(vYear + i) +"</div>"; 
		}
	}


	divYear.innerHTML = vHtml;
}

// 년도 클릭시 월선택 레이어를 표시/감춤
// on -> off
// off -> on
function fnToggleYear() {
	divMonth.style.visibility = "hidden";
	fnYearList(DPYear.value, DPMonth.value);

	// 달력의 년,월,닫기 부분은 표시되도록 상단에서 20px 내려서 표시함.
	// position:absolute; 이지만 달력 레이어의 상대성 절대좌표로 인식함.
	divYear.style.top = "20px";
	divYear.style.left = "0px";

	// 연도선택 레이어 토글
	if ( divYear.style.visibility === "hidden" ) {
		divYear.style.visibility = "visible";
	} else {
		divYear.style.visibility = "hidden";
	}
}

// 월 클릭시 년도선택 레이어를 표시/감춤
// on -> off
// off -> on
function fnToggleMonth() {
	var vHtml = "";
	var vTmpStyle, vTmpOut;
	var vMonth = DPMonth.selectedIndex;
	var arStyle = new Array("01","02","02","02","02","02","03","04","04","04","04","04");	// css style number
	var arMonth = new Array("01","02","03","04","05","06","07","08","09","10","11","12");

	var vMouseOver = "this.style.backgroundColor='#c2c2c2';";
	var vMouseOut = "this.style.backgroundColor='#e5e5e5';";

	divYear.style.visibility = "hidden";
	for ( var i = 0; i < arMonth.length; ++i ) {
		vTmpOut = vMouseOut;
		vTmpStyle = "";

		if ( vMonth === i ) {
			vTmpStyle = "style=\"background-color:#ffffcc;\"";
			vTmpOut = vTmpOut.replace("#e5e5e5", "#ffffcc");
		}

		vHtml += "<div class=\"Month"+ arStyle[i] +"\""+ vTmpStyle +" onClick=\"DPCalendar_ChangeMonth("+ parseInt(arMonth[i]) +");\" onMouseOver=\""+ vMouseOver +"\" onMouseOut=\""+ vTmpOut +"\">"+ arMonth[i] +"</div>";
	}
	divMonth.innerHTML = vHtml;

	// 달력의 년,월,닫기 부분은 표시되도록 상단에서 20px 내려서 표시함.
	// position:absolute; 이지만 달력 레이어의 상대성 절대좌표로 인식함.
	divMonth.style.top = "20px";
	divMonth.style.left = "0px";

	// 월선택 레이어 토글
	if ( divMonth.style.visibility === "hidden" ) {
		divMonth.style.visibility = "visible";
	} else {
		divMonth.style.visibility = "hidden";
	}
}
