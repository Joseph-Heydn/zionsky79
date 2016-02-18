<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="_12sky2.web.media.list" %>
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
				<left:layout id="left" runat="server" setTITL="Media"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnLabelText("Media") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="media_area">
							<asp:Repeater id="LIST" runat="server">
							<ItemTemplate>
							<div class="media_img">
								<ul>
									<li class="thum_img">
										<asp:LinkButton id="LinkButton1" runat="server"
											CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
										<%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>
										</asp:LinkButton>
									</li>
									<li class="thum_tit">
										<asp:LinkButton id="btn_list" runat="server"
											CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
											<%# DataBinder.Eval(Container, "DataItem.TITL") %> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT") %> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
										</asp:LinkButton>
									</li>
								</ul>
							</div>
							</ItemTemplate>
							</asp:Repeater>
							<asp:Panel id="NO_LIST" runat="server" Visible="false">
								no data
							</asp:Panel>
						</div>

						<div class="btn" style="margin-top:10px;">
							<ul>
								<li><asp:LinkButton id="btn_reg" runat="server" ToolTip="Write" onclick="btn_reg_Click" Visible="false">WRITE</asp:LinkButton></li>
							</ul>
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
