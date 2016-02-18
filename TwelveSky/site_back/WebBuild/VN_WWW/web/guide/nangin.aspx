<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nangin.aspx.cs" Inherits="_12sky2.web.guide.nangin" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="info"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnLabelText("Game Guides") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit">
							<span id="PAGE_TITL" runat="server"></span> -
							<asp:Literal runat="server" meta:resourcekey="lbl_Charactor_04"/>
						</div>
						<div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="page_tab">
							<div class="tab">
								<ul>
									<li><a href="/web/guide/info.aspx"><asp:Literal runat="server" meta:resourcekey="lbl_Charactor_01"/></a></li>
									<li><a href="/web/guide/fujin.aspx"><asp:Literal runat="server" meta:resourcekey="lbl_Charactor_02"/></a></li>
									<li><a href="/web/guide/jinong.aspx"><asp:Literal runat="server" meta:resourcekey="lbl_Charactor_03"/></a></li>
									<li class="on"><a href="/web/guide/nangin.aspx"><asp:Literal runat="server" meta:resourcekey="lbl_Charactor_04"/></a></li>
								</ul>
							</div>
						</div>
						<div class="con_tit02"><asp:Literal runat="server" meta:resourcekey="lbl_Charactor_04"/></div>
						<div class="con_img02">
							<ul>
								<li><img src="/resources/images/con_img/guide/nangin01.png" alt=""/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/></li>
							</ul>
						</div>

						<div class="con_tit02"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></div>
						<div class="img_text">
							<div class="l_img01"><img src="/resources/images/con_img/guide/nangin02.png" alt=""/></div>
							<div class="r_text01">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/>
										<ul>
											<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
										</ul>
									</li>
								</ul>
							</div>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/>.</li>
							</ul>
						</div>
					</div> <!--// content page -->
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- wrap -->

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
