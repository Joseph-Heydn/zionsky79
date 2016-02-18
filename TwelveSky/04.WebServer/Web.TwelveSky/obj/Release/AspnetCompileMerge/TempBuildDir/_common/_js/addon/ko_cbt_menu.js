// JavaScript Document

function movePage(first, second) {

	first = first + "";
  second = second + "";
  
  if (first == "0") {
  	// 메인
  	location.href = APPLICATION_CONTEXT + "/main.htm?main_url=main";
  	return;
  }
  
  // 워렌소식
  if (first == "1") {

    if (second == "0") {
      // 공지사항
      location.href = APPLICATION_CONTEXT + "/board/1/list";
      return;
    } else if (second == "1") {
      // 공지사항
      location.href = APPLICATION_CONTEXT + "/board/1/list";
      return;
    } else if (second == "2") {
      // 이벤트
      location.href = APPLICATION_CONTEXT + "/event";
      return;
    } else if (second == "3") {
      // gm 노트
      location.href = APPLICATION_CONTEXT + "/gmDiary/list";
      return;
    } else if (second == "4") {
      // 소설
      location.href = APPLICATION_CONTEXT + "/board/2/list";
      return;
    }

    // 게임정보
  } else if (first == "2") {

    if (second == "0") {
      // 세계관
      location.href = APPLICATION_CONTEXT + "/info/world";
      return;
    } else if (second == "1") {
      // 세계관
      location.href = APPLICATION_CONTEXT + "/info/world";
      return;
    } else if (second == "2") {
      // 클래스 정보
      location.href = APPLICATION_CONTEXT + "/info/class";
      return;
    } else if (second == "3") {
      // 게임시스템
      location.href = APPLICATION_CONTEXT + "/info/gameSystem";
      return;
    }

    // 커뮤니티
  } else if (first == "3") {

    if (second == "0") {
      // 테스터 게시판
      location.href = APPLICATION_CONTEXT + "/board/3/list";
      return;
    } else if (second == "1") {
      // 테스터 게시판
      location.href = APPLICATION_CONTEXT + "/board/3/list";
      return;
    } else if (second == "2") {
      // 버그리포트
      location.href = APPLICATION_CONTEXT + "/board/4/form";
      return;
    }

    // 다운로드
  } else if (first == "4") {
    if (second == "0") {
      // 클라이언트
      location.href = APPLICATION_CONTEXT + "/download/client";
      return;
    }
    if (second == "1") {
      // 클라이언트
      location.href = APPLICATION_CONTEXT + "/download/client";
      return;
    } else if (second == "2") {
      // 멀티미디어
      location.href = APPLICATION_CONTEXT + "/media/mediaList";
      return;
    }
    return;
  }
}
