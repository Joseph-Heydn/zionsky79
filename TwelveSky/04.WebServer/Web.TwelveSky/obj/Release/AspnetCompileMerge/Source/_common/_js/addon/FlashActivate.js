/*
	Flash Activete
	deute 꺼 훔쳐온 zizzy;;
*/
function GnxFlashActivate ( strFlashUrl , n4Witdh , n4Height , strWmode , strId , strClassName , strFlashvar ) {
	//width,height 여부 & 묶음 (width,height가 없을때는 0 으로 선언)
	if (n4Witdh != 0) {
		objSize_attribute = " width='"+ n4Witdh +"' height='"+ n4Height +"'";
	} else {
		objSize_attribute = "";
	}
	//id 여부 (ID 셀렉렉터가 없을경우 0으로선언)
	if (strId != 0) {
		objId_attribute = " id='" + strId + "'";
		objId_IE_attribute = " id='" + strId + "'";
	} else {
		objId_attribute = "";
		objId_IE_attribute = "";
	}
	//class 여부 (class가 없을때는 0 으로 선언)
	if (strClassName != 0) {
		className_attribute = " class='" + strClassName + "'";
	} else {
		className_attribute = "";
	}
	//wmode 여부 (wmode가 없을때는 0 으로 선언)
	if (strWmode != 0) {
		wmode_param = "<param name='wmode' value='" + strWmode + "' />";
		wmode_attribute = " wmode='" + strWmode + "'";
	} else {
		wmode_param = "";
		wmode_attribute = "";
	}
	//Flashvar 여부 (wmode가 없을때는 0 으로 선언)
	if (strFlashvar != 0) {
		Flashvar_param = "<param name='flashvars' value='" + strFlashvar + "' />";
		Flashvar_attribute = " Flashvars='" + strFlashvar + "'";
	} else {
		Flashvar_param = "";
		Flashvar_attribute = "";
	}
	document.writeln( "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' " + objSize_attribute + objId_IE_attribute + className_attribute + ">" );
	document.writeln( "<param name='movie' value='"+ strFlashUrl +"' />" );
	document.writeln( "<param name='quality' value='high' />" );
	document.writeln( "<param name='allowScriptAccess' value='always' />" );
	document.writeln( wmode_param );
	document.writeln( Flashvar_param );
	document.writeln( "<!-- Hixie method -->" );
	document.writeln( "<!--[if !IE]> <-->" );
	document.writeln( "<object type='application/x-shockwave-flash' data='"+ strFlashUrl +"'" + Flashvar_attribute + objSize_attribute + objId_attribute + wmode_attribute + className_attribute + "></object>" );
	document.writeln( "<!--> <![endif]-->" );
	document.writeln( "</object>" );
}

/* 사용법
<script type="text/javascript" language="JavaScript">
// <![CDATA[
	GnxFlashActivate('http://s.nx.com/S2/Bigshot2/swf/sub_nav.swf',890,175,'opaque','TopNavi','TopNavi','Flashvars');
// ]]>
</script>
*/