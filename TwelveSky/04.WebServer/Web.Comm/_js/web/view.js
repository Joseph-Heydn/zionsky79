var gMenuNo = $(gPrefix +"pMenu").val();
var gWriteNo = $(gPrefix +"pWrite").val();
var gReturn = $(gPrefix +"pReturn").val();
// 덧글의 글로벌 JSON 변수
var gCommVar = {
		pMenuNo	: gMenuNo
	,	pWriteNo: gWriteNo
	};

// 글 수정
function fnEdit() {
	if ( fnCheckAuth() ) {
		var vMovePage = "write.aspx?m={0}&w={1}&r={2}";
		$(location).attr("href", String.format(vMovePage, gMenuNo, gWriteNo, gReturn));
	}
}

// 글 삭제
function fnDrop() {
	return fnCheckAuth();
}

// 리스트
function fnList() {
	$(location).attr("href", gReturn);
}



// 덧글 수정에 필요한 덧글 번호 변수
var gCommtNo = 0;
var gBaseUrl = "/web/wsArticle.asmx/";

// 권한 체크
function fnCheckAuth() {
	$.ajax(
	{	url : gBaseUrl +"fnCheckAuthority"
	,	type : "POST"
	,	contentType : false
	,	processData : false
	,	data : gCommVar
//	,	dataType: "json"
	,	success : function(pResult) {
			if ( pResult === false ) {
				alert(window.gMessage.Error_02);
				return false;
			}

			return true;
		}
	,	error : function(pError) {
			alert(pError.statusText);
			return false;
		}
	});
}

// ############################# initialize layer ###############################
// 덧글 페이징에 필요한 글로벌 JSON 변수
var gReplyPage = {
		pPageNo		: 1
	,	pRowCnt		: 0
	,	pIsNext		: 0
	,	pJumpSize	: 1
	,	pBaseMoveNo	: 0
	};


$(document).ready(function() {
	// 댓글 호출
	fnReplyList();
});


// ############################# binding layer ##################################
// 댓글 목록 가져오기(Ajax)
function fnReplyList() {
	// 댓글 목록 조회를 위한 JSON 객체 생성
	var vParamData = {
			pMenuNo		: gCommVar.pMenuNo
		,	pWriteNo	: gCommVar.pWriteNo
		,	pPageNo		: gReplyPage.pPageNo
		,	pJumpSize	: gReplyPage.pJumpSize
		,	pIsNext		: gReplyPage.pIsNext
		,	pBaseMoveNo	: gReplyPage.pBaseMoveNo
		,	pRowCnt		: gReplyPage.pRowCnt
		};


	try {
		var fnAfter = function(pData) {
			if ( pData.d === "false" ) {
			//	alert(pData.Message);
				return;
			}


			var vData = JSON.parse(pData.d);
			if ( vData["Table1"].length > 0 ) {
				// 데이터가 존재 할시 덧글 및 페이징 부분을 Show 한다.
				$("#ulReplyList").show();
				$("#btnGroup").show();

				// 덧글 데이터 바인딩 호출
				fnBindData(vData["Table1"]);
				// 페이징 렌더링 호출
				fnReplyPaging(vData["Table2"]);
			} else {
				// 덧글이 하나 남아있다가 삭제 할때 컨트롤 폼을 감춘다.
				$("#ulReplyList").hide();
				$("#Paging").hide();
			}
		};

		window.fnAjaxSend("fnReplyList", vParamData, fnAfter);
	} catch ( e ) {
		alert(e.description);
	}
}

// 덧글 페이징 렌더링
function fnReplyPaging(pResult) {
	var vPageString = "";

	for ( var i = 0; i < pResult.length; i++ ) {
		if ( pResult[i]["cClass"] === "current" ) {
			vPageString += String.format(
					"<a href=\"javascript:;\" class=\"current\" style=\"margin-right:3px;\">{0}</a>"
				,	pResult[i]["cPagNo"]
				);
			continue;
		}

		vPageString += String.format(
				"<a href=\"#bookMark\" onclick=\"fnMovePage('{0}')\" style=\"margin-right:3px;\">{1}</a>"
			,	pResult[i]["cParam"]
			,	pResult[i]["cPagNo"]
			);
	}

	// 페이지 렌더링
	$("#pagi").html(vPageString);
}

// 덧글 리스트 바인딩
function fnBindData(pResult) {
	// 덧글 변수
	var vHtmlString = "\
		<table class=\"cmmtList\">";
	var vComment = "\
		<tr>\
			<td class=\"name\">\
				{0} : <b>{1}</b>\
				&nbsp;&nbsp;&nbsp;&nbsp;\
				{2} : {3}\
			</td>\
			{4}\
		</tr>\
		<tr>\
			<td colspan=\"2\" style=\"height:40px;\">\
				<pre id=\"comment_{5}\">{6}</pre>\
			</td>\
		</tr>";
	var vAuth = "\
			<td style=\"width:150px; text-align:right;\">\
				<a href=\"javascript:fnEditReply({0});\">{1}</a>&nbsp;\
				<a href=\"javascript:fnDropReply({0});\">{2}</a>\
			</td>";
	var tmp = new Array("","");

	// 데이터 갯수 만큼 반복
	for ( var i = 0; i < pResult.length; i++ ) {
		if ( pResult[i]["cIsWriter"] ) {
			tmp[0] = String.format(
					vAuth
				,	pResult[i]["cCommtNo"]
				,	window.gLabel.pModify
				,	window.gLabel.pDelete
				);
		}

		tmp[1] = String.format(
				vComment
			,	window.gLabel.pWriter
			,	pResult[i]["cWriter"]
			,	window.gLabel.pReDate
			,	pResult[i]["cCreateTime"]
			,	tmp[0]
			,	pResult[i]["cCommtNo"]
			,	pResult[i]["cComments"]
			);

		vHtmlString += tmp[1];
		tmp[0] = "";
	}
	vHtmlString += "</table>";

	if ( pResult.length > 0 ) {
		// 덧글 렌더링
		$("#ulReplyList").html(vHtmlString);
		$("#lblComment").show();
	}
}


// ############################# button event layer #############################
// 덧글 페이지 이동
function fnMovePage(pParam) {
	// 페이지 이동을 위한 글로벌 변수 데이터 넣기
	var vPageData = pParam.split(",");

	gReplyPage.pPageNo		= vPageData[0];
	gReplyPage.pRowCnt		= vPageData[1];
	gReplyPage.pIsNext		= vPageData[3];
	gReplyPage.pJumpSize	= vPageData[2];
	gReplyPage.pBaseMoveNo	= vPageData[4];

	// 덧글만 새로 Refresh
	fnReplyList();
}

// 덧글 등록 버튼 클릭 - 덧글 등록 버튼을 신규와 수정으로 이분화 한다.
function fnRegistClick() {
	if ( fnCheckTag($("#txtComment").val()) ) {
		alert(window.gMessage.Error_05);
		return;
	}


	if ( gCommtNo === 0 ) {
		fnWriteReply();
	} else {
		fnModifyReply();
	}
}

// 덧글 입력(Ajax)
function fnWriteReply() {
	try {
		// 덧글 수정과 입력을 분기시킨다. gReplyNo = 0 인가 아닌가에 따라 처리
		var vComment = $("#txtComment").val();

		// 유효성 검사 - 3자리 이상
		if ( vComment.trim().length < 3 ) {
			alert(window.gMessage.Alert_02);
			$("#txtComment").focus();
			return false;
		}


/*		// 비속어 거르기
		for ( var i = 0; i < window.gProhibitedArray.length; i++ ) {
			var vProhibitedStr = window.gProhibitedArray[i].toLowerCase();
			if ( vComment.indexOf(vProhibitedStr) >= 0 ) {
				alert(window.gMessage.Error_03);
				return false;
			}
		}
*/

		// 덧글 신규 입력을 위한 JSON 생성
		var vParamData = {
				pMenuNo		: gCommVar.pMenuNo
			,	pWriteNo	: gCommVar.pWriteNo
			,	pContents	: vComment
			};
		var fnAfter = function(pData) {
			fnReplyCommon(pData.d, false);
		};

		window.fnAjaxSend("fnReplyWrite", vParamData, fnAfter);	
	} catch ( e ) {
		alert(e.description);
		return false;
	} 

	return true;
}

// 덧글 수정 클릭 이벤트
function fnEditReply(pReplyNo) {
	// 덧글 번호를 가지고 있게 덧글 번호를 저장 한다.
	gCommtNo = pReplyNo;
	// 수정할 댓글의 내용을 위 Textarea에 담는다.
	var vComment = $("#comment_"+ pReplyNo).html();
//	$("#txtComment").val(window.fnReplaceXSS(vComment.replace(/<br>/gi, "\n")));
	$("#txtComment").val(vComment);
	$("#txtComment").focus();
}

// 덧글 수정(Ajax)
function fnModifyReply() {
	var vComment = $("#txtComment").val();
	// 덧글 수정을 위한 JSON 생성
	var vParamData = {
			pMenuNo		: gCommVar.pMenuNo
		,	pWriteNo	: gCommVar.pWriteNo
		,	pContents	: vComment
		,	pCommtNo	: gCommtNo
		};


	try {
		// 유효성 검사 - 3자리 이상
		if ( vComment.trim().length < 3 ) {
			alert(window.gMessage.Alert_02);
			$("#txtComment").focus();
			return false;
		}


		var fnAfter = function(pData) {
			fnReplyCommon(pData.d, true);
		};
		window.fnAjaxSend("fnReplyModify", vParamData, fnAfter);
	} catch ( e ) {
		alert(e.description);
		return false;
	} 

	return true;
}

// 덧글 삭제(Ajax)
function fnDropReply(pReplyNo){
	if ( !confirm(window.gMessage.Alert_04) ) {
		return;
	}


	// 덧글 삭제를 위한 JSON 생성
	var vParamData = {
			pMenuNo		: gCommVar.pMenuNo
		,	pWriteNo	: gCommVar.pWriteNo
		,	pCommtNo	: pReplyNo
		};


	try {
		var fnAfter = function(pData) {
			fnReplyCommon(pData.d, false);
		};
		window.fnAjaxSend("fnReplyDelete", vParamData, fnAfter);
	} catch ( e ) {
		alert(e.description);
		return;
	} 
}

// 글 추천 및 신고(Ajax)
function fnReport(pWriteNo, pCommtNo, pType) {
	var vParamData = {
			pMenuNo		: gCommVar.pMenuNo
		,	pWriteNo	: pWriteNo
		,	pCommtNo	: pCommtNo
		,	pReportType	: pType
		};


	try {
		var fnAfter = function(pData) {
			switch ( pData.d ) {
				case "false":
					break;
				case "loginError":
					alert(window.gMessage.Alert_01);
					break;
				default:
					// oReturn: 2 - 존재 하지 않음, 3 - 본인글 추천 신고 안됌, 6 - 중복 추천
					var vReturn = (pData.d).split("/");
					switch ( vReturn[0] ) {
						case "0":
							if ( pType === 1 ) {
								alert(window.gMessage.Repot_01);
								$("#spRecmdCnt").text(vReturn[1]);
							} else {
								alert(window.gMessage.Repot_03);
							}
							break;
						case "6":
							alert(window.gMessage.Error_03);
							break;
						case "7":
							alert(window.gMessage.Error_04);
							break;
						default:
							alert(window.gMessage.Error_02);
					}
			}
		};

		window.fnAjaxSend("fnReport", vParamData, fnAfter);
	} catch ( e ) {
		alert(e.description);
	} 
}

// 덧글 추천 및 신고(Ajax)
function fnReplyReport(pWriteNo, pCommtNo, pType) {
	// 덧글 추천 및 신고를 위한 JSON 생성 
	var vParamData = {
			pMenuNo		: gCommVar.pMenuNo
		,	pWriteNo	: pWriteNo
		,	pCommtNo	: pCommtNo
		,	pReportType	: pType
		};


	try {
		var fnAfter = function(pData) {
			switch ( pData.d ) {
				case "false":
					break;
				case "loginError":
					alert(window.gMessage.Alert_01);
					break;
				default:
					// oReturn: 2 - 존재 하지 않음, 3 - 본인글 추천 신고 안됌, 6 - 중복 추천
					var vReturn = (pData.d).split("/");
					switch ( vReturn[0] ) {
						case "0":
							if ( pType === 11 ) {
								alert(window.gMessage.Repot_01);
							} else {
								alert(window.gMessage.Repot_03);
							}

							// Ajax 이므로 코멘트 부분의 컨트롤 초기화
							$("#txtComment").val("");
							// 최신 덧글을 가져오기 위한 덧글 재렌더링
							fnReplyList();
							break;
						case "6":
							alert(window.gMessage.Error_03);
							break;
						case "7":
							alert(window.gMessage.Error_04);
							break;
						default:
							alert(window.gMessage.Error_02);
					}
			}
		};

		window.fnAjaxSend("fnReport", vParamData, fnAfter);
	} catch ( e ) {
		alert(e.description);
	}
}

// 덧글 공통 함수
function fnReplyCommon(pReturn, pIsModify) {
	// 서버에서 로그인을 체크한다.
	switch ( pReturn ) {
		case "false":
			break;
		case "loginError":
			alert(window.gMessage.Alert_01);
			break;
		default:
			// Ajax 이므로 코멘트 부분의 컨트롤 초기화
			$("#txtComment").val("");
			// 덧글 분기를 위해 Set 했던 Global 변수 초기화
			if ( pIsModify ) {
				gCommtNo = 0;
			}

			// 최신 덧글을 가져오기 위한 덧글 재렌더링
			fnReplyList();
	}
}

// 자바스크립트 태그 방지 
function fnCheckTag(pStr) {
	var vRegEx = /<(\w+)[^>]*?>(.*?)/;
	return vRegEx.test(pStr.replace(/<a/, ""));
}
