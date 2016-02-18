function ko_waren_fotter_popup(type) {
  switch (type) {
  case 1:
    window.open("http://www.alt1.co.kr/", "alt1_company");
    break;
  case 2:
    l_commonPopup("/clause/pop_service.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 3:
    l_commonPopup("/clause/pop_privacy.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 4:
    l_commonPopup("/clause/pop_youthpolicy.html", "claus_popup", 700, 700,
        "yes", "yes", "yes");
    break;
  case 5:
    l_commonPopup("/clause/pop_emreject.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 6:
    l_commonPopup("/clause/pop_opspolicy.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 7:
    alert("준비중입니다.");
    break;
  case 8:
    alert("준비중입니다.");
    break;
  case 9:
    alert("준비중입니다.");
    break;
  case 10:
    alert("준비중입니다.");
    break;
  case 11:
    window.open(CSCENTER_DOMAIN);
    break;
  default:
    break;
  }
}


function ko_cscenter_fotter_popup(type) {
  switch (type) {
  case 1:
    window.open("http://www.alt1.co.kr/", "alt1_company");
    break;
  case 2:http:
    window.open("http://www.alt1.co.kr/KOR/m05_career/s07_recruit_announcement/recruit_announcement.asp?sb=57", "alt1_company");
    break;
  case 3:
    l_commonPopup("/clause/pop_privacy.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 4:
    l_commonPopup("/clause/pop_youthpolicy.html", "claus_popup", 700, 700,
        "yes", "yes", "yes");
    break;
  case 5:
    l_commonPopup("/clause/pop_service.html", "claus_popup", 700, 700, "yes",
        "yes", "yes");
    break;
  case 6:
    alert("준비중입니다.");
    break;
  case 7:
    alert("준비중입니다.");
    break;
  case 8:
    window.open("http://www.alt1.co.kr/KOR/m01_abtalt1/s01_summary/summary.asp?sb=11", "alt1_company");
    break;
  default:
    break;
  }
}
function cashCharge(){
	l_commonPopup("http://bill.alt1games.co.kr/billing/fillup/CreditPayFrm.htm", "CreditPayFrm", 700, 730, "no", "no", "no");
}

function cashChargePlayNet(){
	l_commonPopup("https://bill.playnetwork.co.kr/pay/charge.nhn?CHNL=PN", "CreditPayFrm1", 540, 540, "no", "no", "no");
}

function autoHakReport(){
	l_commonPopup("http://waren.alt1games.co.kr/popup/common/autohakReport", "autohakReport", 400, 410, "no", "no", "no");
}

function go_beginner(){
  l_commonPopup('/guide/beginner/', 'beginnerGuide', 980, 700, 'no', 'no', 'no');
}

function go_waite(){
	alert('준비중입니다.');
}


function loveman_pop2(){
  l_commonPopup('http://waren.alt1games.co.kr/eventPage/2011/20111006/eventmain', 'loveman', 960, 780, 'yes', 'yes', 'yes');
}