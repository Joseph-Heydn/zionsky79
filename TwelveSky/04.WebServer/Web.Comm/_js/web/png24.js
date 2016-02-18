// Png Img
function setPng24(obj) {
	var useragent = navigator.userAgent;
	if ( (useragent.indexOf("MSIE 6") > 0) && (useragent.indexOf("MSIE 7") === -1) ) {
		obj.width = obj.height = 1;
		obj.className = obj.className.replace(/\bpng24\b/i, "");
		obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');";
		obj.src = "";
	}

	return "";
}
