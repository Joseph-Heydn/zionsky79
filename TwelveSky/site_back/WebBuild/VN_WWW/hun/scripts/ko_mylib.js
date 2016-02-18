<!--
function MM_swapImgRestore() { // v3.0
var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { // v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { // v4.01
var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { // v3.0
var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function l_commonPopup(link, pagename, width, height, isscroll, isresizable, iscenter) {

  var wd = width;
  var ht = height;
  var sx = 0; // default
  var sy = 0;

  if (iscenter=='yes') {
    sx = (screen.width/2) - (wd/2);
    sy = (screen.height/2) - (ht/2);
  }

  popup_box = window.open(link, pagename, "width="+wd+", height="+ht+", left="+sx+", top="+sy+", scrollbars="+isscroll+", resizable="+isresizable);
  popup_box.focus();
  return popup_box;

}

/*
// 이미지 리사이즈
function resizeContentsImage(contentDivSelector, maxWidth, maxHeight, resizeHeightFlag) {
	
	var pivotWidth = EDITOR_IMAGE_MAX_WITDH;
	var pivotHeight = $(window).height() - 200;
	if (maxWidth != null)
	  pivotWidth = maxWidth;
	if (maxHeight != null) {
	  resizeHeightFlag = false;
	  pivotHeight = maxHeight;
	}
	
  var images = $(contentDivSelector + " img");
  images.each(function(index) {
    
    $(this).css({ "max-width" : pivotWidth });
    
    if (resizeHeightFlag) {
      $(this).css({ "max-height" : pivotHeight });
    }

    // 캐쉬 먹을 경우만 동작.
    var width = $(this).attr("width");
    var height = $(this).attr("height");

    if (!($.browser.msie && Number($.browser.version) < 7)) {
      if (width > pivotWidth) {
        $(this).css({ "max-width" : pivotWidth, "width" : pivotWidth, "height" : "auto" });
      }
      if (resizeHeightFlag && height > pivotHeight) {
        $(this).css({ "max-height" : pivotHeight, "width" : "auto", "height" : pivotHeight });
      }
    } else {
      
      if (width > pivotWidth) {
        var resizeRate = 0;
        resizeRate = width / pivotWidth;
        width = width / resizeRate;
        height = height / resizeRate;
        $(this).css({ "max-width" : pivotWidth, "width" : width, "height" : height });
      }
      
      if (resizeHeightFlag && height > pivotHeight) {
        var resizeRate = 0;
        resizeRate = height / pivotHeight;
        width = width / resizeRate;
        height = height / resizeRate;
        $(this).css({ "max-height" : pivotHeight, "width" : width, "height" : height });
      }
    }
  });
}
*/

// 이미지 리사이즈
function resizeContentsImage(contentDivSelector, maxWidth, maxHeight, resizeHeightFlag) {
	
  var pivotWidth = EDITOR_IMAGE_MAX_WITDH;
  var pivotHeight = $(window).height() - 200;
  if (maxWidth != null)
    pivotWidth = maxWidth;
  if (maxHeight != null) {
    resizeHeightFlag = false;
    pivotHeight = maxHeight;
  }
  
  var $images = $(contentDivSelector + " img");
  $images.each(function(index) {
    
    $(this).css({ "max-width" : pivotWidth + "px" });
    
    if (resizeHeightFlag) {
      $(this).css({ "max-height" : pivotHeight + "px"});
    }
    
    var width = this.width;
    var height = this.height;      
    if ($.browser.msie && Number($.browser.version) < 9) {
    	$(this).removeAttr("width").removeAttr("height");
      if (width >= pivotWidth) {
        var resizeRate = 0;
        resizeRate = width / pivotWidth;
        width = width / resizeRate;
        height = height / resizeRate;
        $(this).css({ "max-width" : pivotWidth, "width" : width, "height" : height });
      }
      if (resizeHeightFlag && height > pivotHeight) {
        var resizeRate = 0;
        resizeRate = height / pivotHeight;
        width = width / resizeRate;
        height = height / resizeRate;
        $(this).css({ "max-height" : pivotHeight, "width" : width, "height" : height });
      }
      $(this).removeAttr("width").removeAttr("height"); 
    } else {
      if (width > pivotWidth) {
        $(this).css({ "max-width" : pivotWidth + "px", "width" : pivotWidth, "height" : "auto" });
      }
      if (resizeHeightFlag && height > pivotHeight) {
        $(this).css({ "max-height" : pivotHeight + "px", "width" : "auto", "height" : pivotHeight });
      } 
    }
  });
}

// 파일의 확장자를 가져옮
function getFileExtension(filePath) {
  var lastIndex = -1;
  lastIndex = filePath.lastIndexOf('.');
  var extension = "";

if ( lastIndex != -1 ) {
  extension = filePath.substring( lastIndex+1, filePath.length );
} else {
  extension = "";
}
  return extension;
}

// 이미지 파일인지 체크. 파일을 선택 후 포커스 이동시 호출
function uploadImageFileChange(obj) {
  var src = getFileExtension(obj.value);
  if (src == "") {
    alert('올바른 파일을 입력하세요');
    return;
  } else if ( !((src.toLowerCase() == "gif") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "jpeg")) ) {
  	
  	obj.value="";
    
    if ($.browser.msie) {
      obj.select();
      document.selection.clear();
    }
  	
    alert('gif 와 jpg 파일만 지원합니다.');
    return;
  }
}

function KeyNextMove(len, txt, next_input){
  if(txt.value.length >= len){
    next_input.focus();
  }
}

function Swf_View(URL,SizeX,SizeY){


document.write('			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ');
document.write(	'				codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" ');
document.write(	'				width="'+SizeX+'" height="'+SizeY+'"  align="middle">');
document.write(	'				<param name="movie" value="'+URL+'"/>');
document.write(	'				<param name="quality" value="high"/>');
document.write(	'				<param name="wmode" value="transparent"/>');
//document.write(	'				<param name="bgcolor" value="#ffffff"/>');
document.write(	'				<embed src="'+URL+'" quality="high" ');
document.write(	'						bgcolor="#ffffff" width="'+SizeX+'" height="'+SizeY+'" name="menuLink"');
document.write(	'						align="middle" ');
document.write(	'						type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"/>');
document.write(	'		</object>		');

}




function Swf_ViewParam(URL,SizeX,SizeY,PARAM){


document.write('			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ');
document.write(	'				codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" ');
document.write(	'				width="'+SizeX+'" height="'+SizeY+'"  align="middle">');
document.write(	'				<param name="movie" value="'+URL+'"/>');
document.write(	'				<param name="allowScriptAccess" value="always"/> ');
document.write(	'				<param name="quality" value="high"/>');
document.write(	'				<param name="wmode" value="transparent"/>');
document.write(	'				<param name="flashvars" value="'+PARAM+'"/>');
//document.write(	'				<param name="bgcolor" value="#ffffff"/>');
document.write(	'				<embed src="'+URL+'" quality="high" ');
document.write(	'						bgcolor="#ffffff" wmode="transparent" width="'+SizeX+'" height="'+SizeY+'" name="menuLink"');
document.write(	'						align="middle" ');
document.write(	'						type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"/>');
document.write(	'		</object>		');


}

function setCookie(name,value,expiredays) {
  var todayDate = new Date();
  todayDate.setDate(todayDate.getDate() + expiredays);
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie( name ) {
  var nameOfCookie = name + "=";
  var x = 0;
  while ( x <= document.cookie.length )
  {
    var y = (x+nameOfCookie.length);
    if ( document.cookie.substring( x, y ) == nameOfCookie ) {
      if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
       endOfCookie = document.cookie.length;
      return unescape( document.cookie.substring( y, endOfCookie ) );
    }
    x = document.cookie.indexOf( " ", x ) + 1;
    if ( x == 0 )
      break;
  }
  return "";
}

// 로그인 부분
function checkLoginForm() {
  if($("#userId").val() == ""){
    alert("아이디를 입력해주세요.");
    $("#userId").focus();
    return false;
  }
  
  if($("#passWd").val() == ""){
    alert("비밀번호를 입력해주세요.");
    $("#passWd").focus();
    return false;
  }
}



$.fn.breakWords = function() {
  this.each(function() {
    if (this.nodeType !== 1) {
      return;
    }
    if (this.currentStyle
    && typeof this.currentStyle.wordBreak === 'string') {
      this.runtimeStyle.wordBreak = 'break-all';
    }
    else if (document.createTreeWalker) {
      var trim = function(str) {
        str = str.replace(/^\s\s*/, '');
        var ws = /\s/,
        i = str.length;
        while (ws.test(str.charAt(--i)));
        return str.slice(0, i + 1);
      };

      // For Opera, Safari, and Firefox
      var dWalker = document.createTreeWalker(this,
      NodeFilter.SHOW_TEXT, null, false);
      var node, s, c = String.fromCharCode('8203');
      while (dWalker.nextNode()) {
        node = dWalker.currentNode;
        s = trim(node.nodeValue).split('').join(c);
        node.nodeValue = s;
      }
    }
  });
  return this;
};



-->