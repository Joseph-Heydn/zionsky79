<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="items.aspx.cs"
	Inherits="Web.Manage.web.board.items"
%>
<asp:Content ContentPlaceHolderId="cpStyles" runat="server">
	<link rel="stylesheet" type="text/css" href="/_common/_css/common.css" />
	<link rel="stylesheet" type="text/css" href="/_common/_css/layout.css" />
</asp:Content>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		// 페이지 이동
		function fnMovePage(pPageNo, pRowCnt, pLastNo, pLastVo, pJumpSize, pIsNext) {
			var vPage = String.format(
					"/web/items.aspx?m={0}&p={1}&c={2}&l={3}&j={4}&n={5}"
				,	$("#<%= pMenu.ClientID %>").val()
				,	pPageNo
				,	pRowCnt
				,	pLastNo
				,	pJumpSize
				,	pIsNext
				);
			$(location).attr("href", vPage);
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<%= fnMenuText("Home") %> &gt;
				<asp:Literal id="lblGroup" runat="server"/> &gt;
				<asp:Literal runat="server" meta:resourcekey="lblItem"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="pMenu" runat="server"/>
			<asp:HiddenField id="pPage" runat="server"/>
			<asp:HiddenField id="pRowCnt" runat="server"/>
			<asp:HiddenField id="pJumpNo" runat="server"/>
			<asp:HiddenField id="pLastNo" runat="server"/>
			<asp:HiddenField id="pIsNext" runat="server"/>
			<asp:HiddenField id="pIsFind" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<div class="page_tab">
				<div class="tab">
					<ul>
<asp:Repeater id="repTabList" runat="server">
	<ItemTemplate>
						<li <%# fnCheckPage(Eval("[5]")) %>>
							<a href="<%# Eval("[5]") %>">
								<%# Eval("[4]") %>
							</a>
						</li>
	</ItemTemplate>
</asp:Repeater>
					</ul>
				</div>
			</div>
			<!-- page_tab -->

<asp:Repeater id="repArticleList" runat="server">
	<ItemTemplate>
			<div class="con_table">
				<table class="I_table" style="border-spacing:0; padding:0;">
					<caption></caption>
					<colgroup>
						<col style="width:15%;"/>
						<col/>
						<col style="width:12%;"/>
						<col style="width:15%;"/>
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
							<th rowspan="3"><%# fnImageUrl(Eval("cFolder"), Eval("cImage"), Eval("cExts")) %></th>
							<td class="center_b"><%# Eval("cSubject") %></td>
							<td class="center"><%# Eval("SALE_QTY") %></td>
							<td class="center_c">
								<img src="/_common/_images/con_img/shop/icon_cash.gif" alt=""/>
								<%# Eval("SALE_AMT") %>
							</td>
						</tr>
						<tr>
							<th class="center" colspan="3">
								<asp:Literal runat="server" meta:resourcekey="lbl_table_05"/>
							</th>
						</tr>
						<tr>
							<td colspan="3"><%# Eval("cSummary") %></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- con_table -->
	</ItemTemplate>
</asp:Repeater>

			<div id="dvEmptyList" class="con_table" Visible="False" style="height:150px;" runat="server">
				<asp:Literal runat="server" meta:resourcekey="lblEmpty"/>
			</div>

			<div class="pagingArea">
				<div class="paging">
					<asp:Literal id="lblPaging" runat="server"/>
				</div>
			</div>
			<!-- pagingArea -->
		</div>
		<!-- content_page -->
	</div>
	<!-- contents -->
</asp:Content>
