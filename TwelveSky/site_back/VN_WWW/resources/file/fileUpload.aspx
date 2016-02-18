<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fileUpload.aspx.cs" Inherits="_12sky2.resources.file.fileUpload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Attach File</title>
<common:layout id="common" runat="server"/>
<script type="text/javascript">
	var _mockdata = "";
	function setImg(seq, attachurl, filemime, filename, filesize) {
		_mockdata = {
			'seq': seq,
			'attachurl': attachurl,
			'filemime': filemime,
			'filename': filename,
			'filesize': filesize
		};
	}

	function done() {
		opener.parent.setImg(_mockdata);
		closeWindow();
	}
	function closeWindow() {
		self.close();
	}

</script>
<style type="text/css">
	.preView_area { float:left; width:97%; margin:10px auto; padding-left:10px;}
</style>
</head>

<body>
<form id="form1" runat="server">
	<div style="background:#fff;width:390px;height:110px;margin:5px auto;">
		<div class="preView_area">
			<asp:FileUpload id="dataFile" runat="server" onchange="__doPostBack('dataSelect','')"/>
		</div>
		<div class="preView_area">
			<asp:Label id="dataName" runat="server"></asp:Label>
		</div>
	</div>
	<div class="btn">
		<ul>
			<li><a href="#" onclick="done();">INSERT</a></li>
			<li><a href="#" onclick="closeWindow();">CANCEL</a></li>
		</ul>
	</div>
	<asp:LinkButton id="dataSelect" runat="server" onclick="dataSelect_Click"></asp:LinkButton>
</form>
</body>
</html>
