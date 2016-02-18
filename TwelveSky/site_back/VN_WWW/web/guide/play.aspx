<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="play.aspx.cs" Inherits="_12sky2.web.guide.play" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="play"/>

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
								<li style="font-size:12px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></li>
							</ul>
						</div>
						<div class="img_text01">
							<div class="l_text01">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
									<li style="margin-top:10px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
									<li style="margin-top:10px;">
										<table cellspacing="0" cellpadding="0" class="C_table">
											<caption></caption>
											<colgroup>
												<col width="30%"/>
												<col width="70%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="center">Strength</th>
													<td><p>Physical and Skill Damage</p><p>Attack Success Rate</p></td>
												</tr>
												<tr>
													<th class="center">Dexterity</th>
													<td><p>Chance to Dodge </p><p>Defense </p></td>
												</tr>
												<tr>
													<th class="center">Vitality</th>
													<td><p>Character Health  </p><p>Chance to Dodge </p></td>
												</tr>
												<tr>
													<th class="center">Chi</th>
													<td><p>Physical and Skill Damage</p></td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							</div>
							<div class="r_img01"><img src="/resources/images/con_img/guide/play01.gif" alt=""/></div>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></div>
						<div class="con_text02">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="img_text01" style="margin-top:30px;">
							<div class="l_text01">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></li>
									<li style="margin-top:10px;">
										<table cellspacing="0" cellpadding="0" class="C_table">
											<caption></caption>
											<colgroup>
												<col width="30%"/>
												<col width="70%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="center">Guanyin</th>
													<td><p>Swordmaster Lupai</p> <p>Bladekeeper Ro</p> <p>Master Brus Li</p> </td>
												</tr>
												<tr>
													<th class="center">Fujin</th>
													<td><p>Katana Tutor Beitan</p> <p>Twinblade Phong</p> <p>Songsmith Seiren</p></td>
												</tr>
												<tr>
													<th class="center">Jinong</th>
													<td><p>Spearmaster Raji</p> <p>Bladelord Quon</p> <p>Scepter Adept Nao</p></td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							</div>
							<div class="r_img01"><img src="/resources/images/con_img/guide/play02.png" alt=""/></div>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></div>
						<div class="con_text02">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></li>
									</ul>
								</li>
							</ul>
						</div>

						<div class="three_grid">
							<div class="one_grid">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></li>
								</ul>
							</div>
							<div class="m_img"><img src="/resources/images/con_img/guide/play03.png" alt=""/></div>
							<div class="one_grid">
								<ul>
									<li>&nbsp;</li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_17"/></li>
								</ul>
							</div>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></div>
						<div class="img_text01">
							<div class="l_text01" style="width:390px;">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/></li>
								</ul>
								<ul style="margin-top:20px;">
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></li>
								</ul>
							</div>
							<div class="r_img01"><img src="/resources/images/con_img/guide/play04.png" alt=""/></div>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></div>
						<div class="img_text02">
							<div class="l_img02"><img src="/resources/images/con_img/guide/play05.png" alt=""/></div>
							<div class="r_text02">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								</ul>
							</div>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></div>
						<div class="img_text01">
							<div class="l_text02">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/></li>
									<li style="margin-top:20px;"><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_30"/></strong>
										<ul>
											<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_31"/></li>
											<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_32"/></li>
										</ul>
									</li>
								</ul>
							</div>
							<div class="r_img01"><img src="/resources/images/con_img/guide/play06.png" alt=""/></div>
						</div>

					</div><!-- //content page -->
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
