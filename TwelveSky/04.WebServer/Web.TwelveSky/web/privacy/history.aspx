<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="history.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.history"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gMenuNo = $("#<%= pMenu.ClientID %>").val();
		var gReturn = $("#<%= pReturn.ClientID %>").val();

		// 글 보기
		function fnView(pWriteNo) {
			var vMoveUrl = "view.aspx?m={0}&w={1}&r={2}";
			$(location).attr("href", String.format(vMoveUrl, gMenuNo, pWriteNo, gReturn));
		}

		// 페이지 이동
		function fnMovePage(pPageNo, pRowCnt, pLastNo, pLastVo, pJumpNo, pIsNext) {
			var vPage = String.format(
					"history.aspx?m={0}&p={1}&c={2}&l={3}&j={4}&n={5}"
				,	gMenuNo
				,	pPageNo
				,	pRowCnt
				,	pLastNo
				,	pJumpNo
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
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="pReturn" runat="server"/>
			<asp:HiddenField id="pMenu" runat="server"/>
			<asp:HiddenField id="pPage" runat="server"/>
			<asp:HiddenField id="pRowCnt" runat="server"/>
			<asp:HiddenField id="pJumpNo" runat="server"/>
			<asp:HiddenField id="pLastNo" runat="server"/>
			<asp:HiddenField id="pIsNext" runat="server"/>
			<asp:HiddenField id="pIsFind" runat="server"/>
		</div>

		<div class="content_page">
			<div class="con_table">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:07%;"/>
						<col/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
					</colgroup>
					<thead>
						<tr>
							<th><asp:Literal runat="server" meta:resourcekey="lblTable_01"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblTable_02"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblTable_03"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblTable_04"/></th>
						</tr>
					</thead>
					<tbody>
<asp:Repeater id="repArticleList" runat="server">
	<ItemTemplate>
						<tr>
							<td class="center"><%# Eval("cWriteNo")%></td>
							<td>
								<a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
									<%# Eval("cSubject") %>
									[<%# Eval("cReplyCnt") %>]
									<%# fnIsFile(Eval("cImage")) %>
									<%# fnIsNew(Eval("cCreateTime")) %>
								</a>
							</td>
							<td class="center"><%# fnReplyStatus(Eval("cRecep"), Eval("cReady"), Eval("cReply")) %></td>
							<td class="center"><%# fnDateOnly(Eval("cCreateTime")) %></td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
<asp:Panel id="pnEmptyList" Visible="false" runat="server">
						<tr style="height:150px;">
							<td colspan="4" class="center">
								<asp:Literal runat="server" meta:resourcekey="lblEmpty"/>
							</td>
						</tr>
</asp:Panel>
					</tbody>
				</table>
			</div>

			<div class="pagingArea">
				<div class="paging">
					<asp:Literal id="lblPaging" runat="server"/>
				</div>
			</div>
			<!-- pagingArea -->
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
