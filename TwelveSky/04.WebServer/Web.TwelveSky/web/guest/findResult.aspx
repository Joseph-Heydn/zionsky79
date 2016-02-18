<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="findResult.aspx.cs"
	Inherits="Web.TwelveSky.web.guest.findResult"
%>
<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<%= fnMenuText("Home") %> &gt;
				<asp:Literal id="lblGroup" runat="server"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<div class="con_text" style="background:#f5f5f5; margin-top:20px; padding:20px 10px;">
				<ul>
					<li><%= fnMenuText("lblFindResult") %></li>
				</ul>
			</div>
		</div>

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
