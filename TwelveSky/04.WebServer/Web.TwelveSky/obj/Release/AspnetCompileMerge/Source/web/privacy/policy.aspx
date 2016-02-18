<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="policy.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.policy"
%>
<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<asp:Literal runat="server" meta:resourcekey="lblHome"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="pMenu" runat="server"/>
			<asp:HiddenField id="pWrite" runat="server"/>
		</div>
		<!-- con_top -->

		<!-- contents start -->
		<div class="content_page">
			<asp:Label id="lblContents" runat="server"/>
		</div>
	</div>
</asp:Content>
