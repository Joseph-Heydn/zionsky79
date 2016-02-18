<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="list.aspx.cs"
	Inherits="Web.TwelveSky.web.board.list"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gObjectId = {
				pMenu	: $("#<%= pMenu.ClientID %>").val()
			,	pPage	: $("#<%= pPage.ClientID %>").val()
			,	pRowCnt : $("#<%= pRowCnt.ClientID %>").val()
			,	pJumpNo : $("#<%= pJumpNo.ClientID %>").val()
			,	pLastNo : $("#<%= pLastNo.ClientID %>").val()
			,	pIsNext : $("#<%= pIsNext.ClientID %>").val()
			,	pIsFind : $("#<%= pIsFind.ClientID %>").val()
			,	pReturn : $("#<%= pReturn.ClientID %>").val()
			};

		// 글 보기
		function fnView(pWriteNo) {
			var vMoveUrl = "view.aspx?pMenu={0}&pWrite={1}&pReturn={2}";
			$(location).attr("href", String.format(vMoveUrl, gObjectId.pMenu, pWriteNo, gObjectId.pReturn));
		}

		// 글 작성
		function fnWrite() {
			var vMoveUrl = "write.aspx?pMenu={0}&pReturn={1}";
			$(location).attr("href", String.format(vMoveUrl, gObjectId.pMenu, gObjectId.pReturn));
		}

		// 페이지 이동
		function fnMovePage(pPageNo, pRowCnt, pLastNo, pLastVo, pJumpSize, pIsNext) {
			var vPage = String.format(
					"/web/list.aspx?pMenu={0}&pPage={1}&pRowCnt={2}&pLastNo={3}&pJumpNo={4}&pIsNext={5}"
				,	gObjectId.pMenuNo
				,	pPageNo
				,	pRowCnt
				,	pLastNo
				,	pLastVo
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
				<asp:Literal runat="server" meta:resourcekey="lblHome"/> &gt;
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

		<!-- contents start -->
		<div class="content_page">
			<div id="dvList" class="con_table" Visible="False" runat="server">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:7%;"/>
						<col/>
						<col style="width:20%;"/>
						<col style="width:12%;"/>
						<col style="width:10%;"/>
					</colgroup>
					<thead>
						<tr>
							<th><asp:Literal runat="server" meta:resourcekey="lblNo"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblTitle"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblDate"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblWriter"/></th>
							<th><asp:Literal runat="server" meta:resourcekey="lblHits"/></th>
						</tr>
					</thead>
					<tbody>
<asp:Repeater id="repNoticeList" runat="server">
	<ItemTemplate>
						<tr>
							<td class="center" style="background:#e0f0ef;"><img src="/_common/_images/icon/news01.png" alt=""/></td>
							<td style="background:#e0f0ef;">
								<a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
									<%# Eval("cSubject") %>
									[<%# Eval("cReplyCnt") %>]
									<%# fnIsFile(Eval("cImage")) %>
									<%# fnIsNew(Eval("cCreateTime")) %>
								</a>
							</td>
							<td class="center" style="background:#e0f0ef;"><%# fnDateOnly(Eval("cCreateTime")) %></td>
							<td class="center" style="background:#e0f0ef;"><%# Eval("cWriter") %></td>
							<td class="center" style="background:#e0f0ef;"><%# Eval("cViewCnt") %></td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
<asp:Repeater id="repBest5List" runat="server">
	<ItemTemplate>
						<tr>
							<td class="center" style="width:20px; background:#e7f0f7;"><img src="/_common/_images/icon/like.png" alt=""/></td>
							<td style="background:#e7f0f7;">
								<a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
									<%# Eval("cSubject") %>
									[<%# Eval("cReplyCnt") %>]
									<%# fnIsFile(Eval("cImage")) %>
									<%# fnIsNew(Eval("cCreateTime")) %>
								</a>
							</td>
							<td class="center" style="background:#e7f0f7;"><%# fnDateOnly(Eval("cCreateTime")) %></td>
							<td class="center" style="background:#e7f0f7;"><%# Eval("cWriter") %></td>
							<td class="center" style="background:#e7f0f7;"><%# Eval("cViewCnt") %></td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
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
							<td class="center"><%# fnDateOnly(Eval("cCreateTime")) %></td>
							<td class="center"><%# Eval("cWriter") %></td>
							<td class="center"><%# Eval("cViewCnt") %></td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
<asp:Panel id="pnEmptyList" Visible="false" runat="server">
						<tr style="height:150px;">
							<td colspan="5" class="center">
								<asp:Literal runat="server" meta:resourcekey="lblEmpty"/>
							</td>
						</tr>
</asp:Panel>
					</tbody>
				</table>
			</div>
			<!-- dvList -->

			<div id="dvMedia" class="media_area" Visible="False" runat="server">
<asp:Repeater id="repMediaList" runat="server">
	<ItemTemplate>
				<ul>
					<li class="thum_img">
						<a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
							<img src="<%# fnImageUrl(Eval("cFolder"), Eval("cImage"), Eval("cExts"), Eval("cExtLink")) %>" style="width:200px;" alt=""/>
						</a>
					</li>
					<li class="thum_tit">
                        <a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
	                        <%# Eval("cSubject") %>
							[<%# Eval("cReplyCnt") %>]
							<%# fnIsNew(Eval("cCreateTime")) %>
                        </a>
					</li>
				</ul>
	</ItemTemplate>
</asp:Repeater>
                <div id="pnEmptyMedia" Visible="False" style="height:150px;" runat="server">
                    <asp:Literal runat="server" meta:resourcekey="lblEmpty"/>
                </div>
			</div>
			<!-- dvMedia -->

			<div id="dvPreview" Visible="False" runat="server">
<asp:Repeater id="repPreviewList" runat="server">
	<ItemTemplate>
                <div class="announce">
                    <div class="announce_tit">
                        <a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
	                        <%# Eval("cSubject") %>
                        </a>
                    </div>
                    <div class="announce_date">
                        <asp:Literal runat="server" meta:resourcekey="lblBy"/>
						<span class="writer"><%# Eval("cWriter") %></span>
						<%# fnDateOnly(Eval("cCreateTime")) %>
                    </div>
                    <div class="announce_img">
                        <a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
	                        <img src="/FileUp/<%# Eval("cFolder") %>/<%# Eval("cImage") %>-s.<%# Eval("cExts") %>" alt=""/>
                        </a>
                    </div>
                    <div class="announce_text">
                        <ul>
                            <li>
	                            <a href="javascript:fnView(<%# Eval("cWriteNo") %>);">
									<%# Eval("cSummary") %>
								</a>
                            </li>
                        </ul>  
                    </div>
                </div>
	</ItemTemplate>
</asp:Repeater>
                <div id="pnEmptyPreview" class="announce" Visible="False" style="height:150px;" runat="server">
                    <asp:Literal runat="server" meta:resourcekey="lblEmpty"/>
                </div>
			</div>
			<!-- dvPreview -->

			<div id="btnWrite" class="btn" Visible="False" runat="server">
				<ul>
					<li>
						<a href="javascript:fnWrite();">
							<asp:Literal runat="server" meta:resourcekey="lblWrite"/>
						</a>
					</li>
				</ul>
			</div>
			<!-- btnWrite -->

			<div class="pagingArea">
				<div class="paging">
					<asp:Literal id="lblPaging" runat="server"/>
				</div>
			</div>
			<!-- pagingArea -->
		</div>

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
		</div>
	</div>
    <!-- content -->
</asp:Content>
