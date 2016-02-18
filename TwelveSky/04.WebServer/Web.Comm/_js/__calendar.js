var DP_Num = 0;
var DP_Win = new Array();
var DP_getYear = 2001;
var DP_DateBox = null;
var DP_PickerInput = null;
var DP_IFRAMES;
for ( var i=0; i < 10; i++ ) DP_Win[i] = "none";

// 달력 열고 닫기
function Calendar_D(pObj, pNum) {
	var vObj = document.getElementById(pObj);
	DP_IFRAMES = "DP_IFRAME";
	DP_IFRAMES = document.getElementById(DP_IFRAMES);

	// 달력 번호
	DP_Num = pNum;
	// 시작년도
	DP_IFRAMES.setYear = DP_getYear;
	// 달력초기화
	DP_PickerInput_blur(vObj);

	// 달력상태 초기화
	for ( var i=0; i < DP_Win.length; i++ ) {
		if ( i !== pNum ) DP_Win[i] = "none";
	}

	switch ( DP_Win[pNum] ) {
		case "block":
			DP_Win[pNum] = "none";
			DP_DisablePicker(vObj);
			break;
		case "none":
			DP_Win[pNum] = "block";
			DP_OpenPicker(vObj);
			break;
		default:
	}
}

// vHtml 이벤트 핸들러
function DP_PickerInput_blur(obj) {
	DP_DateBox = obj;
	if ( !DP_PickerHasMouse()) DP_DisablePicker();
}

/**
* Picker Callback
* 날짜를 선택한 경우 picker 프레임에서 호출
**/
function DP_GetPickedDate(date_str) {
	if ( DP_PickerInput != null ) DP_PickerInput.value = date_str;
	DP_DisablePicker();
	DP_DateBox.focus();
}

// Picker Method
function DP_OpenPicker(input) {
	var top = document.body.clientTop + DP_GetObjectTop(input);
	var left = document.body.clientLeft + DP_GetObjectLeft(input);
	var DPContainer = document.getElementById("DPContainer");

	DP_PickerInput = input;
	DP_IFRAMES.contentWindow.init(DP_ParseDate(DP_PickerInput.value));


	DPContainer.style.top = top + input.offsetHeight + 1 +"px";
	DPContainer.style.left = (left-72) +"px";
	DPContainer.style.display = "block";

	DP_IFRAMES.contentDocument.getElementById("divYear").style.visibility = "hidden";
	DP_IFRAMES.contentDocument.getElementById("divMonth").style.visibility = "hidden";
}

function DP_DisablePicker() {
	DP_PickerInput = null;
	var DPContainer = document.getElementById("DPContainer");

	DPContainer.style.pixelTop = 0;
	DPContainer.style.pixelLeft = 0;
	DPContainer.style.display = "none";
	DP_Win[DP_Num] = "none";
}

function DP_PickerHasMouse() {
	var DPContainer = document.getElementById("DPContainer");
	var top = document.body.clientTop + DP_GetObjectTop(DPContainer) - document.body.scrollTop;
	var left = document.body.clientLeft + DP_GetObjectLeft(DPContainer) - document.body.scrollLeft;
	var width = DPContainer.offsetWidth;
	var height = DPContainer.offsetHeight;

	//alert( event.x +" "+ event.y +" "+ top +" "+ height +" "+ left +" "+ width);
	return (
		(event.y + 20 >= top && event.y + 20 < top + height)
	&&	(event.x >= left && event.x < left + width)
	);
}

function DP_InitPicker(getYear) {
	// common.js
	document.write('<div id="DPContainer" class="DPContainer" style="position:absolute; top:100px; left:100px; display:none; z-index:1000;">');
	document.write('<iframe id="DP_IFRAME" width="182" height="192" src="/_common/_controls/date_picker.html" scrolling="no" frameborder="no" border="0"></iframe>');
	document.writeln('</div>');

/*	document.writeln('<script language="javascript" for="document" event="onclick">');
	document.writeln('	var o = DP_DateBox;');
	document.writeln('	var e = event.srcElement;');
	document.writeln('	DP_IFRAME.setYear = '+ getYear +';');
	document.writeln('	if ( DP_Win[DP_Num] == "block" ) { ');
	document.writeln('		DP_DisablePicker();');
	document.writeln('		DP_Win[DP_Num] = "none";');
	document.writeln('		return;');
	document.writeln('	}');
	document.writeln('	if ( e.tagName == "IMG" || e.tagName == "INPUT" ) DP_OpenPicker(o);');
	document.writeln('</script>');
*/
	DP_getYear = getYear;
}

// vHtml 개체용 유틸리티 함수
function DP_GetObjectTop(obj) {
	if ( obj.offsetParent != null ) {
		if ( obj.offsetParent === document.body ) return obj.offsetTop;
		else return obj.offsetTop + DP_GetObjectTop(obj.offsetParent);
	} else {
		return obj.offsetTop;
	}
}

function DP_GetObjectLeft(obj) {
	if ( obj.offsetParent != null ) {
		if ( obj.offsetParent === document.body ) return obj.offsetLeft;
		else return obj.offsetLeft + DP_GetObjectLeft(obj.offsetParent);
	} else {
		return obj.offsetLeft;
	}
}


// class DP_Calendar
function DP_Calendar(year, month) {
	if ( year == null || month == null ) {
		var d = new Date();
		this.year = d.getFullYear();
		this.month = d.getMonth();
	} else {
		this.year = year;
		this.month = month - 1; // Date 개체의 경우 달은 0부터 시작
	}

	this.first_week = new DP_Week(new Date(this.year, this.month, 1));
	this.last_date = new Date(this.year, this.month + 1, 1);
	this.next_week = this.first_week;

	// methods
	this.reset = DP_Calendar_Reset;
	this.hasNextWeek = DP_Calendar_HasNextWeek;
	this.nextWeek = DP_Calendar_NextWeek;
}

function DP_Calendar_Reset() {
	this.last_week = this.first_week;
}

function DP_Calendar_HasNextWeek() {
	return DP_DateCompare(this.next_week.date, this.last_date) < 0;
}

function DP_Calendar_NextWeek() {
	var next_week = this.next_week;
	this.next_week = next_week.nextWeek();
	return next_week;
}

// class DP_Week
function DP_Week(date) {
	// methods
	this.hasNextDate = DP_Week_HasNextDate;
	this.nextDate = DP_Week_NextDate;
	this.nextWeek = DP_Week_NextWeek;
	this.getWeekFirstDate = DP_Week_GetWeekFirstDate;
	this.equals = DP_Week_Equals;
	this.compare = DP_Week_Compare;
	this.reset = DP_Week_Reset;

	// fields
	this.index = 0;

	if ( date == null ) date = new Date();
	this.date = this.getWeekFirstDate(date);
}

function DP_Week_Reset() {
	this.index = 0;
}

function DP_Week_GetWeekFirstDate(date) {
	var d = new Date(date.valueOf());
	var wday = d.getDay();
	d.setDate(d.getDate() - wday);

	return d;
}

function DP_Week_HasNextDate() {
	return (this.index < 7);
}

function DP_Week_NextDate() {
	if ( this.index >= 7 ) return null;

	var d = new Date(this.date.valueOf());
	d.setDate(d.getDate() + this.index);
	this.index++;

	return d;
}

function DP_Week_NextWeek() {
	var d = new Date(this.date.valueOf());
	d.setDate(d.getDate() + 7);

	return new DP_Week(d);
}

function DP_Week_Equals(week) {
	return DP_DateEquals(this.date, week.date);
}

function DP_Week_Compare(week) {
	return DP_DateCompare(this.date, week.date);
}

// Date 개체용 유틸리티 함수
function DP_FormatDate(d) {
	var year = String(d.getFullYear());
	var month = String(d.getMonth() + 1);
	var mday = String(d.getDate());

	var s = year +"-";
	s += ((month.length < 2) ? "0" : "") + month;
	s += "-"+ ((mday.length < 2) ? "0" : "") + mday;

	return s;
}

function DP_ParseDate(dstr) {
	var str = String(dstr);
	if ( str == null || str === "" ) return null;

	if ( str.match(/(\d{4})-(\d{2})-(\d{2})/) ) {
		var year = Number(RegExp.$1);
		var month = Number(RegExp.$2) - 1;
		var mday = Number(RegExp.$3);

		return new Date(year, month, mday);
	}

	return null;
}

function DP_DateEquals(d1, d2) {
	return (
		(d1.getFullYear() === d2.getFullYear())
	&&	(d1.getMonth() === d2.getMonth())
	&&	(d1.getDate() === d2.getDate())
	);
}

function DP_DateCompare(d1, d2) {
	if ( d1.getFullYear() > d2.getFullYear() )
		return 1;
	if ( d1.getFullYear() < d2.getFullYear() )
		return -1;
	if ( d1.getMonth() > d2.getMonth() )
		return 1;
	if ( d1.getMonth() < d2.getMonth() )
		return -1;
	if ( d1.getDate() > d2.getDate() )
		return 1;
	if ( d1.getDate() < d2.getDate() )
		return -1;

	return 0;
}
