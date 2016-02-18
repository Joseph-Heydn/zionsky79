<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="guide.aspx.cs"
	Inherits="Web.TwelveSky.web.board.guide"
%>
<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<asp:Literal runat="server" meta:resourcekey="lblHome"/> &gt;
				<asp:Literal id="lblGroup" runat="server"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>
	        <div class="write_date">
		        <asp:Literal runat="server" meta:resourcekey="lblBy"/>
				<span class="writer">
					<asp:Literal runat="server" meta:resourcekey="lblWriter"/>
				</span>
				<asp:Literal id="txtDate" runat="server"/>
	        </div>

			<asp:HiddenField id="pMenu" runat="server"/>
			<asp:HiddenField id="pWrite" runat="server"/>
			<asp:HiddenField id="pIsWrite" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<asp:Literal id="txtContents" runat="server"/>
		</div>

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
		</div>
	</div>
    <!-- content -->
</asp:Content>
