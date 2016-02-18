<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="story.aspx.cs" Inherits="_12sky2.web.guide.story" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Twelvesky2</title>
<common:layout id="common" runat="server"/>
</head>

<body>
<form id="form1" runat="server">
	<div id="main_bg">
		<div id="wrap">
			<head:layout id="head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="story"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnLabelText("Game Guides") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
						<div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_tit">History of the Nangin</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
							</ul>
						</div>
					</div>
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
					</div>
				</div>
			</div> <!-- container -->
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
