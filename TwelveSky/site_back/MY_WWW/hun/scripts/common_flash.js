////////////////////////////////////////////////////////////////////////////////////
// flash ���� ��� function
////////////////////////////////////////////////////////////////////////////////////
//
// Flash Grid Component ���� ����
//
// 1. flash�� �ε��� �Ϸ�Ǹ� flash ==> script dataGridLoadOk() ȣ��
// 2. �ε� ���� Object �±��� param���� flashVars�Ӽ��� requestUrl�� �����ϸ� flash ==> script flash_enc() ȣ��
// 3. �ε� ���� Object �±��� param���� flashVars�Ӽ��� requestUrl�� �������� ������ ����
// 4. ��� ��ư�� Ŭ�� �ÿ� flashDataGridSend()�� ȣ���ϸ� flash ==> script flash_enc() ȣ��
////////////////////////////////////////////////////////////////////////////////////

// Flash Grid load �Ϸ� ����
var isFlashGridLoadOk = false;

// Flash Grid �۾��� ����
var isFlashGridWorkingOk = false;

// flashLoad(���ϰ��, ����, ����, ���̵�, ����, ����, ��������)
function flashHtml(url,w,h,id,bg,vars,win) {

	win = "transparent";

	// �÷��� �ڵ� ����
	var flashStr=
	"<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+
	"<param name='allowScriptAccess' value='always' />"+
	"<param name='movie' value='"+url+"' />"+
	"<param name='FlashVars' value='"+vars+"' />"+
	"<param name='wmode' value='"+win+"' />"+
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='"+bg+"' />"+
	"<param name='base' value='.'>"+
	"<embed src='"+url+"' FlashVars='"+vars+"' wmode='"+win+"' menu='false' base='.' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object>";

	// �÷��� �ڵ� ���


	//Flash�� ExternalInterface�� Form Tag������ ����� ���׸� �ذ��ϴ� �ڵ�
	eval("window." + id + " = document.getElementById('" + id + "');");
 return flashStr;
}

function flashLoad(url,w,h,id,bg,vars,win,divId){
  var html = flashHtml(url,w,h,id,bg,vars,win);
  document.getElementById(divId).innerHTML  = html;  
}

function flashDisappear(divId){
  $('#'+divId).html("");
}