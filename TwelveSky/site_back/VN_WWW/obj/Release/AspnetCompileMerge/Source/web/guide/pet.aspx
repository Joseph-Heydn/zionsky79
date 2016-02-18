﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pet.aspx.cs" Inherits="_12sky2.web.guide.pet" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="pet"/>

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
						<div class="con_tit"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></li>
							</ul>
						</div>
						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet01.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet02.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet03.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet04.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet05.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet06.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet07.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet08.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet09.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet10.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet11.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet12.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_30"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet13.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_31"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_32"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet14.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_33"/></li>
							</ul>
						</div>

						<div class="center_img">
							<ul class="tit">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_34"/></li>
							</ul>
							<ul class="c_img">
								<li><img src="/resources/images/con_img/guide/pet15.png" alt=""/></li>
							</ul>
							<ul class="b_text">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_35"/></li>
							</ul>
						</div>
					</div><!-- //content page -->
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
			</div> <!-- container -->
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
