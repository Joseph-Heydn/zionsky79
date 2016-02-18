<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="_12sky2.admin.shop.list" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Twelvesky2 - Admin Page</title>
<common:layout id="common" runat="server"/>
</head>
<body>

<form id="form1" runat="server">
	<%--<div id="main_bg">--%>
	<div>
		<div id="wrap">
			<admin_head:layout id="admin_head" runat="server"/>

			<div id="C_container">
				<asp:ScriptManager id="ScriptManager1" runat="server">
				</asp:ScriptManager>

				<asp:UpdatePanel id="UpdatePanel1" runat="server">
				<ContentTemplate>

				<!-- left menu -->
				<admin_left:layout id="admin_left" runat="server" setTITL="Shop"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; Shop &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
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
										<th>Image</th>
										<th>Name</th>
										<th>Stock</th>
										<th>Cost</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th rowspan="3"><%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %></th>
										<td class="center_b">
											<asp:LinkButton id="btn_list" runat="server"
												CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
												<%# DataBinder.Eval(Container, "DataItem.ITEM_NM") %>
											</asp:LinkButton>
										</td>
										<td class="center"><%# DataBinder.Eval(Container, "DataItem.SALE_QTY", "{0:#,0}")%></td>
										<td class="center_c"><img src="/resources/images/con_img/shop/icon_cash.gif" alt=""/><%# DataBinder.Eval(Container, "DataItem.SALE_AMT", "{0:#,0}")%></td>
									</tr>
									<tr>
										<th class="center" colspan="3">Description</th>
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
						no data
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

						<div class="btn">
							<ul>
								<li><asp:LinkButton id="btn_reg" runat="server" ToolTip="Write" onclick="btn_reg_Click">WRITE</asp:LinkButton></li>
							</ul>
						</div>
					</div>
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
				</ContentTemplate>
				</asp:UpdatePanel>
			</div>
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
