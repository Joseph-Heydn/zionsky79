<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="signupOk.aspx.cs"
	Inherits="Web.TwelveSky.web.guest.signupOk"
%>
<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<%= fnMenuText("Home") %> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>
			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<div class="con_text02">
				<ul>
					<li><img src="/_common/_images/succes_bg.png" usemap="#map" alt=""/>
						<map id="map" name="map">
							<area href="/" shape="rect" coords="81,509,611,571" alt=""/>
						</map>
					</li>
				</ul>
			</div>
		</div>
		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
