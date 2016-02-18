<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vanity.aspx.cs" Inherits="_12sky2.web.shop.vanity" %>
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
				<div class="lnb">
					<div class="lnb_tit"><%= fnLabelText("Shop") %></div>
					<div class="left_menu">
						<ul>
							<li><a href="/web/shop/upgrading.aspx" class="on">Item List</a></li>
							<asp:Panel id="LEFT_MENU_LIST" runat="server" Visible="false">
							<li><a href='<%=GETBILLURL()%>'>Cash</a>
								<ul>
									<li><a href='<%=GETBILLURL()%>'>Buy Gp coins</a></li>
									<li><a href='<%=GETBILLURL()%>/History/FillUpHistory.aspx'>Fill-up history</a></li>
									<li><a href='<%=GETBILLURL()%>/History/PurchaseHistory.aspx'>Purchase History</a></li>
									<li><a href='<%=GETBILLURL()%>/Policy/CoinsPolicy.aspx'>Coins policy</a></li>
								</ul>
							</li>
							</asp:Panel>
						</ul>
					</div>
<%--
					<div class="left_search">
						<ul>
							<li><input type="text" id="id" name="id" maxlength="41" title="search" placeholder="Search"></li>
							<li><a href="#"><img src="/resources/images/con_img/btn_search.gif" alt="search"></a></li>
						</ul>
					</div>--%>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnLabelText("Shop") %> &gt;
							<%= fnLabelText("item") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="page_tab">
							<div class="tab">
								<ul>
									<li>
										<a href="/web/shop/upgrading.aspx">
											<asp:Literal runat="server" meta:resourcekey="lbl_tab_01"/>
										</a>
									</li>
									<li>
										<a href="/web/shop/buffs.aspx">
											<asp:Literal runat="server" meta:resourcekey="lbl_tab_02"/>
										</a>
									</li>
									<li class="on">
										<a href="/web/shop/vanity.aspx">
											<asp:Literal runat="server" meta:resourcekey="lbl_tab_03"/>
										</a>
									</li>
									<li>
										<a href="/web/shop/miscellaeous.aspx">
											<asp:Literal runat="server" meta:resourcekey="lbl_tab_04"/>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<asp:Repeater id="LIST" runat="server">
						<ItemTemplate>
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="I_table">
								<caption></caption>
								<colgroup>
									<col width="15%">
									<col width="*">
									<col width="12%">
									<col width="15%">
								</colgroup>
								<thead>
									<tr>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_01"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_02"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_03"/></th>
										<th><asp:Literal runat="server" meta:resourcekey="lbl_table_04"/></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th rowspan="3"><%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %></th>
										<td class="center_b"><%# DataBinder.Eval(Container, "DataItem.ITEM_NM") %></td>
										<td class="center"><%# DataBinder.Eval(Container, "DataItem.SALE_QTY")%></td>
										<td class="center_c"><img src="/resources/images/con_img/shop/icon_cash.gif" alt=""/><%# DataBinder.Eval(Container, "DataItem.SALE_AMT")%></td>
									</tr>
									<tr>
										<th class="center" colspan="3"><asp:Literal runat="server" meta:resourcekey="lbl_table_05"/></th>
									</tr>
									<tr>
										<td colspan="3"><%# DataBinder.Eval(Container, "DataItem.EXPL")%></td>
									</tr>
								</tbody>
							</table>
						</div>
						</ItemTemplate>
					</asp:Repeater>
					<asp:Panel id="NO_LIST" runat="server" Visible="false">
						<div class="con_table">
							<asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/>
						</div>
					</asp:Panel>

						<div class="pagingArea">
							<div class="pagingText">(<asp:Label id="NOW_PAGE" runat="server"/> / <asp:Label id="TOTAL_PAGE" runat="server"/> Page )</div>
							<div class="paging">
								<asp:Repeater id="PAGING" runat="server">
									<ItemTemplate>
										<%# DataBinder.Eval(Container, "DataItem.PAGE")%>
									</ItemTemplate>
								</asp:Repeater>
							</div>
						</div>
					</div><!-- -->

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
