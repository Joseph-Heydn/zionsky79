<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pvp.aspx.cs" Inherits="_12sky2.web.guide.pvp" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="pvp"/>

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
								<li><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></strong></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></li>
							</ul>
						</div>
						<div class="con_text">
							<ul>
								<li><strong><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></strong></li>
							</ul>
						</div>
						<div class="con_text01">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></li>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></li>
									</ul>
								</li>
							</ul>
						</div>
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="C_table01">
								<caption></caption>
								<colgroup>
									<col width="35%"/>
									<col width="35%"/>
									<col width="30%"/>
								</colgroup>
								<thead>
									<tr>
										<th>Zone Name</th>
										<th>Level Range</th>
										<th>Battle Goal</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center">Bui Di Grounds</td>
										<td class="center">Level 10 - 19</td>
										<td class="center">Annihilation</td>
									</tr>
									<tr>
										<td class="center">Destati Grounds</td>
										<td class="center">Level 20 - 29</td>
										<td class="center">Holy Stone Destruction</td>
									</tr>
									<tr>
										<td class="center">Saotsi Grounds</td>
										<td class="center">Level 30 - 39</td>
										<td class="center">Zone Capture</td>
									</tr>
									<tr>
										<td class="center">Xing Dio Grounds</td>
										<td class="center">Level 40 - 49</td>
										<td class="center">Annihilation</td>
									</tr>
									<tr>
										<td class="center">Finasy Grounds</td>
										<td class="center">Level 50 - 59</td>
										<td class="center">Holy Stone Destruction</td>
									</tr>
									<tr>
										<td class="center">Ye Kan Grounds</td>
										<td class="center">Level 60 - 69</td>
										<td class="center">Zone Capture</td>
									</tr>
									<tr>
										<td class="center">Lena Tsou Grounds</td>
										<td class="center">Level 70 - 79</td>
										<td class="center">Annihilation</td>
									</tr>
									<tr>
										<td class="center">Haibo Grounds</td>
										<td class="center">Level 80 - 89</td>
										<td class="center">Holy Stone Destruction</td>
									</tr>
									<tr>
										<td class="center">Tulang Grounds</td>
										<td class="center">Level 90 - 99</td>
										<td class="center">Zone Capture</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="con_tit"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></li>
							</ul>
						</div>

						<div class="img_text03">
							<div class="l_text03">
								<ul>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_17"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></li>
									<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></li>
								</ul>
							</div>
							<div class="r_img03"><img src="/resources/images/con_img/guide/pvp01.png" alt=""/></div>
						</div>

						<div class="con_tit"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></div>
						<div class="con_text02">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/>
									<ul>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></li>
										<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></li>
									</ul>
								</li>
							</ul>
						</div>
						<div class="con_img02">
							<ul>
								<li><img src="/resources/images/con_img/guide/pvp02.png" alt=""/></li>
							</ul>
						</div>
						<div class="con_text02">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/></li>
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
