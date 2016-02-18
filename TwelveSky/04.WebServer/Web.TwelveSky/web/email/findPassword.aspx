<%@ Page
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="findPassword.aspx.cs"
	Inherits="Web.TwelveSky.web.email.findPassword"
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>

<body>
	<asp:Literal runat="server" meta:resourcekey="lblDear"/>
	<span><%= Request.QueryString["pParam_01"] %></span><br/><!-- AccountId -->
	<asp:Literal runat="server" meta:resourcekey="lblText_01"/><br/>
	<asp:Literal runat="server" meta:resourcekey="lblText_02"/><br/>
	<asp:Literal runat="server" meta:resourcekey="lblUserId"/>
	<span><a href="mailto:"><%= Request.QueryString["pParam_02"] %></a></span><br/><!-- new Password -->
	<asp:Literal runat="server" meta:resourcekey="lblDescript"/>
</body>
</html>
