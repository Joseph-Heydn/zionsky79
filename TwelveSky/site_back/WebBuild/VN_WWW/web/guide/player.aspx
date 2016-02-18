<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="player.aspx.cs" Inherits="_12sky2.web.guide.player" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="player"/>

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
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
							</ul>
						</div>
						<div class="con_img02">
							<ul>
								<li><img src="/resources/images/con_img/guide/player01.png" alt=""/></li>
							</ul>
						</div>
						<div class="con_text02">
							<ul>
								<li><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></strong>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></div>

						<div class="img_text03">
							<div class="l_text03" style="width:370px; margin-right:20px;">
								<ul class="text_003">
									<li style="margin-left:-10px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></li>
								</ul>
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
								</ul>
								<ul class="text_003">
									<li style="margin-left:-10px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_17"/></li>
								</ul>
							</div>
							<div class="r_img03"><img src="/resources/images/con_img/guide/player02.png" alt=""/></div>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></div>
						<div class="con_text02">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></li>
							</ul>
							<ul>
								<li>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="con_text" style="margin-top:20px;">
							<ul>
								<li><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></strong> <br/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_30"/></li>
									</ul>
								</li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_31"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_32"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_33"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_34"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_35"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_36"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_37"/></div>
						<div class="con_text03">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_38"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_39"/></li>
									</ul>
								</li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_40"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_41"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_42"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_43"/></li>
									</ul>
								</li>
							</ul>
						</div>
						<div class="r_img01"><img src="/resources/images/con_img/guide/player03.png" style="width:200px;" alt=""/></div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_44"/></div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_45"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_46"/></li>
									</ul>
								</li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_47"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_48"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_49"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_50"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_51"/></div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_52"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_53"/></li>
									</ul>
								</li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_54"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_55"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_56"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_57"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_58"/></div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_59"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_60"/></li>
									</ul>
								</li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_61"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_62"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_63"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_64"/></li>
									</ul>
								</li>
							</ul>
						</div>
					</div><!-- -->

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
