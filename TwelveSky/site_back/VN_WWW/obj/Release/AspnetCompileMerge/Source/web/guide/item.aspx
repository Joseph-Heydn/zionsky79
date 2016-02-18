<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="item.aspx.cs" Inherits="_12sky2.web.guide.item" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="item"/>

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
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_17"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></li>
							</ul>
						</div>
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="C_table01">
								<caption></caption>
								<colgroup>
									<col width="35%"/>
									<col widht="35%"/>
									<col widht="30%"/>
								</colgroup>
								<thead>
									<tr>
										<th>Equipment</th>
										<th>Increase</th>
										<th style="background:#fff;">&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center">Weapon</td>
										<td class="center">Damage</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Armor</td>
										<td class="center">Defense</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Gloves</td>
										<td class="center">Chance to Hit</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Boots</td>
										<td class="center">Dodge</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Cape</td>
										<td class="center">Defense</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Ring</td>
										<td class="center">Deadly</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="center">Amulet</td>
										<td class="center">Luck</td>
										<td>* 15% - Gold of Eternity</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="C_table01">
								<caption></caption>
								<colgroup>
									<col width="33%"/>
									<col widht="33%"/>
									<col widht="33%"/>
								</colgroup>
								<thead>
									<tr>
										<th>Phase</th>
										<th>Combine Cost</th>
										<th>Success Rate</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center">CS 1</td>
										<td class="center">1 Million</td>
										<td class="center">65%</td>
									</tr>
									<tr>
										<td class="center">CS 2</td>
										<td class="center">1.5 Million</td>
										<td class="center">60%</td>
									</tr>
									<tr>
										<td class="center">CS 3</td>
										<td class="center">2 Million</td>
										<td class="center">55%</td>
									</tr>
									<tr>
										<td class="center">CS 4</td>
										<td class="center">2.5 Million</td>
										<td class="center">50%</td>
									</tr>
									<tr>
										<td class="center">CS 5</td>
										<td class="center">3 Million</td>
										<td class="center">45%</td>
									</tr>
									<tr>
										<td class="center">CS 6</td>
										<td class="center">3.5 Million</td>
										<td class="center">40%</td>
									</tr>
									<tr>
										<td class="center">CS 7</td>
										<td class="center">4 Million</td>
										<td class="center">35%</td>
									</tr>
									<tr>
										<td class="center">CS 8</td>
										<td class="center">4.5 Million</td>
										<td class="center">30%</td>
									</tr>
									<tr>
										<td class="center">CS 9</td>
										<td class="center">5 Million</td>
										<td class="center">25%</td>
									</tr>
									<tr>
										<td class="center">CS 10</td>
										<td class="center">5.5 Million</td>
										<td class="center">20%</td>
									</tr>
									<tr>
										<td class="center">CS 11</td>
										<td class="center">6 Million</td>
										<td class="center">15%</td>
									</tr>
									<tr>
										<td class="center">CS 12</td>
										<td class="center">6.5 Million</td>
										<td class="center">10%</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></strong></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_30"/></li>
								<li style="margin-left:20px;"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_31"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_32"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_33"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_34"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_35"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_36"/></li>
							</ul>
						</div>

						<div class="box_text">
							<ul class="left">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_37"/></li>
							</ul>
							<ul class="center">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_38"/></li>
							</ul>
						</div>
						<div class="box_text">
							<ul class="left">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_39"/></li>
							</ul>
							<ul class="center">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_40"/></li>
							</ul>
						</div>
						<div class="box_text">
							<ul class="left">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_41"/></li>
							</ul>
							<ul class="center">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_42"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_43"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_44"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_45"/></li>
							</ul>
						</div>
						<div class="box_text">
							<ul class="left">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_46"/></li>
							</ul>
							<ul class="center">
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_47"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_48"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_49"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_50"/></li>
							</ul>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_51"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_52"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_53"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_54"/></li>
							</ul>
						</div>
						<div class="con_text_img">
							<ul>
								<li class="l_text"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_55"/></li>
								<li class="r_img"><img src="/resources/images/con_img/guide/item01.png" alt=""/></li>
							</ul>
						</div>
						<div class="con_text_img">
							<ul>
								<li class="l_text"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_56"/></li>
								<li class="r_img"><img src="/resources/images/con_img/guide/item02.png" alt=""/></li>
							</ul>
						</div>
						<div class="con_text_img">
							<ul>
								<li class="l_text"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_57"/></li>
								<li class="r_img"><img src="/resources/images/con_img/guide/item03.png" alt=""/></li>
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
