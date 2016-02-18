<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="npcs.aspx.cs" Inherits="_12sky2.web.guide.npcs" %>
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
				<left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="npcs"/>

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
					<div class="l_img"><img src="/resources/images/con_img/guide/npcs01.png" alt=""/></div>

						<div class="con_table" style="margin-top:30px;">
							<table cellspacing="0" cellpadding="0" class="C_table01" style="border-bottom:1px solid #ccc;">
								<caption></caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_01"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_02"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_03"/></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs02.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs03.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_05"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs04.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_06"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs05.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_09"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs06.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_10"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_11"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs07.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_12"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_13"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs08.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_14"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_15"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs09.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_16"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_17"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs10.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_18"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_19"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs11.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_20"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_21"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs12.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_22"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_23"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs13.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_24"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_25"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs14.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_26"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_27"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs15.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_28"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_29"/></td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_30"/></div>
						<div class="l_img"><img src="/resources/images/con_img/guide/npcs16.png" alt=""/></div>

						<div class="con_table" style="margin-top:30px;">
							<table cellspacing="0" cellpadding="0" class="C_table01" style="border-bottom:1px solid #ccc;">
								<caption></caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_01"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_02"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_03"/></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs17.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_31"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_32"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs18.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_33"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_34"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs19.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_35"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_36"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs20.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_37"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_38"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs21.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_39"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_40"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs22.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_41"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_42"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs23.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_43"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_44"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs24.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_45"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_46"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs25.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_47"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_48"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs26.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_49"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_50"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs27.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_51"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_52"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs28.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_53"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_54"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs29.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_55"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_56"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs30.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_57"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_58"/></td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="con_tit01"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_59"/></div>
						<div class="l_img"><img src="/resources/images/con_img/guide/npcs31.png" alt=""/></div>

						<div class="con_table" style="margin-top:30px;">
							<table cellspacing="0" cellpadding="0" class="C_table01">
								<caption></caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_01"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_02"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_03"/></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs32.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_60"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_61"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs33.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_62"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_63"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs34.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_64"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_65"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs35.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_66"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_67"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs36.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_68"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_69"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs37.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_70"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_71"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs38.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_72"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_73"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs39.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_74"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_75"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs40.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_76"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_77"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs41.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_78"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_79"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs42.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_80"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_81"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs43.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_82"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_83"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs44.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_84"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_85"/></td>
									</tr>
									<tr>
										<td class="center"><img src="/resources/images/con_img/guide/npcs45.png" alt=""/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_86"/></td>
										<td class="center"><asp:Literal runat="server" meta:resourcekey="lbl_conPage_87"/></td>
									</tr>
								</tbody>
							</table>
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
