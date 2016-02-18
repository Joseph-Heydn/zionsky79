<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="ucBanner.ascx.cs"
	Inherits="Web.TwelveSky.App_Common.ucBanner"
%>
<!-- left banner AD -->
<asp:Repeater id="rpLeftAd" runat="server">
	<ItemTemplate>
		<div id="banner"><img src='<%# Eval("cImage") %>' alt=""/></div>
	</ItemTemplate>
</asp:Repeater>
<!-- right banner AD -->
<asp:Repeater id="rpRightAd" runat="server">
	<ItemTemplate>
		<div id="banner1"><img src='<%# Eval("cImage") %>' alt=""/></div>
	</ItemTemplate>
</asp:Repeater>
