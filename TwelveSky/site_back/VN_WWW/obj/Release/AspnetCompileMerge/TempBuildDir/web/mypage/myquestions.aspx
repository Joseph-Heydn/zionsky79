<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myquestions.aspx.cs" Inherits="_12sky2.web.mypage.myquestions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
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
					<div class="lnb_tit">My Page</div>
					<div class="left_menu">
						<ul>
							<li><a href="/web/mypage/profile.aspx"><%= fnMainText("profile") %></a></li>
							<li><a href="/web/mypage/password.aspx"><%= fnMainText("password") %></a></li>
							<li><a href="/web/mypage/myquestions.aspx" class="on"><%= fnMainText("support") %></a>
								<ul>
									<li><a href="/web/mypage/myquestions.aspx" class="on"><%= fnMainText("myQuestion") %></a></li>
									<li><a href="/web/mypage/contact.aspx"><%= fnMainText("contatct") %></a></li>
								</ul>
							</li>
							<li><a href="/web/mypage/withdrawal.aspx"><%= fnMainText("deactivate") %></a></li>
						</ul>
					</div>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnMainText("mypage") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="N_table">
								<caption></caption>
								<colgroup>
									<col width="7%"/>
									<col width="*"/>
									<col width="15%"/>
									<col width="20%"/>
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
									<asp:Repeater id="LIST" runat="server">
									<ItemTemplate>
									<tr>
										<td class="center"><%# DataBinder.Eval(Container, "DataItem.ROWNUM")%></td>
										<td>
											<asp:LinkButton id="btn_list" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
											<%# DataBinder.Eval(Container, "DataItem.TITL")%> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT")%> <%# DataBinder.Eval(Container, "DataItem.ICON_FILE")%> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW")%>
											</asp:LinkButton>
										</td>
										<td class="center"><%# DataBinder.Eval(Container, "DataItem.DEAL_STAT_NM")%></td>
										<td class="center"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
									</tr>
									</ItemTemplate>
									</asp:Repeater>
									<asp:Panel id="NO_LIST" runat="server" Visible="false">
										<tr>
											<td colspan="4" class="center">no data</td>
										</tr>
									</asp:Panel>
								</tbody>
							</table>
						</div>

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
