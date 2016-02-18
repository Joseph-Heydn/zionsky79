// 테이블들의 Object들을 초기화 한다.
function fnObjList() {
	var i, j, n, tid, obj, oGrid, oTbl, rowCnt;

	// Table 전체
	for ( i=0; i < window.tblList.length; i++ ) {
		if ( window.arTables[i] == undefined ) continue;
		oTbl = window.arTables[i];

		oGrid = window.comm + window.tblList[i];
		oGrid = document.getElementById(oGrid);
		if ( oGrid == undefined ) continue;

		// Table의 Rows
		for ( j=0; j < oGrid.rows.length; j++ ) {
			oTbl[j] = new Array();

			// Object ID 구하기
			// 제목 줄 기준으로 Row 인덱스는 '0', 컨트롤 인덱스는 '1'부터 시작함
			rowCnt = (j + 2).toString();
			if ( rowCnt.length === 1 ) rowCnt = "0"+ rowCnt;
			tid = window.comm + window.tblList[i] +"_ctl"+ rowCnt +"_";

			// Table Rows의 컨트롤 수
			for ( n=0; n < window.objList.length; n++ ) {
				obj = tid + window.objList[n];
				obj = document.getElementById(obj);

				if ( obj == undefined ) break;
				oTbl[j][n] = obj;
			}
		}
	}
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

// Checkbox 전체 선택 반전
function fnCheckChangAll(obj, tbNo, use) {
	var i, tr, item, opps;
	var dgView = document.getElementById(window.comm + window.tblList[tbNo]);

	// RowCount 만큼 반복
	for ( i=1; i < dgView.rows.length; i++ ) {
		tr = dgView.rows[i];
		item = tr.childNodes[1].childNodes[1];
		opps = tr.style;

		// CheckBox가 맞는지 확인 및 첫번째 CheckBox 패스
		if ( item.id !== obj.id && item.type === "checkbox" ) {
			if ( obj.checked ) {
				//item.click();
				item.checked = true;

				// 컨트롤 사용 변경
				if ( use === 1 ) fnObjUsed(item, 0, 1);
				opps.backgroundColor = "#a6d2ff";
			} else {
				item.checked = false;
				if ( use === 1 ) fnObjUsed(item, 0, 3);
				opps.backgroundColor = "#ffffff";
			}
		}
		obj.blur();
	}
}

// Checkbox 선택 시 row 하이라이트
function fnCheckChanged(obj, tbl, use) { //, rowindex;
	var opp = obj.parentElement.parentElement.style; //	rowindex = opp.sectionRowIndex;

	if ( obj.checked ) {
		if ( use === 1 ) fnObjUsed(obj, tbl, 1);
		opp.backgroundColor = "#a6d2ff";
		obj.blur();
	} else {
		if ( use === 1 ) fnObjUsed(obj, tbl, 3);
		opp.backgroundColor = "#ffffff";
		obj.blur();
	}

	//fnCondition();
}

// TextBox 사용 반전
function fnObjUsed(obj, tbl, loop) {
	var i, r, oTbl;
	var item;

	// Object 초기화
	if ( window.tblSpec.length === 0 ) fnObjList();

	// Table Object 할당
	if ( tbl === 0 ) {
		oTbl = window.tblSpec;
	} else {
		oTbl = window.tblFilt;
	}

	// 현재 선택된 row 구하기
	var opp = obj.parentElement.parentElement;
	r = opp.sectionRowIndex - 1;
	if ( r < 0 ) r = 0;
	if ( oTbl[r][0] == undefined ) return;

	// Object 상태값 바꾸기
	for ( i=1; i <= loop; i++ ) {
		item = oTbl[r][i];

		// CheckBox가 선택 되었는지 확인
		if ( oTbl[r][0].checked ) {
			item.disabled = false;
		} else {
			item.selectedIndex = 0;
			item.value = "";
			item.disabled = true;
		}
	}

	// 연산자가 "BETWEEN"이 아니면 비 활성화
	if ( oTbl[r][1].value !== "BETWEEN" ) {
		oTbl[r][3].value = "";
		oTbl[r][3].disabled = true;
	}

	oTbl[r][2].focus();
}
