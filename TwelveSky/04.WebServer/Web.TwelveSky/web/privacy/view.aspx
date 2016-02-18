<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="view.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.view"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gLabel = {
				pRecomd : ""
			,	pAganst : ""
			,	pReport : ""
			,	pModify : "<%= fnLabelText("lblEdit") %>"
			,	pDelete : "<%= fnLabelText("lblDrop") %>"
			,	pReDate : "<%= fnLabelText("lblDate") %>"
			,	pWriter : "<%= fnLabelText("lblWriter") %>"
			};
		var gMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Error_02 : "<%= fnLabelText("msgError_02") %>"
			,	Error_03 : "<%= fnLabelText("msgError_03") %>"
			,	Error_04 : "<%= fnLabelText("msgError_04") %>"
			,	Error_05 : "<%= fnLabelText("msgError_05") %>"
			};
	</script>

	<script type="text/javascript" src="/_common/_js/web/view.js" charset="utf-8"></script>
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
			<asp:HiddenField id="pWrite" runat="server"/>
		</div>

		<div class="content_page">
			<div class="con_table">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:25%;"/>
						<col/>
					</colgroup>
					<tbody>
						<tr>
							<th class="b_none">
								<asp:Literal runat="server" meta:resourcekey="lblCategory"/>
							</th>
							<td>
								<asp:Literal id="lblCategoryL" runat="server"/> >
								<asp:Literal id="lblCategoryM" runat="server"/>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<asp:Literal runat="server" meta:resourcekey="lblNickName"/>
							</th>
							<td>
								<asp:Literal id="lblNickName" runat="server"/>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<asp:Literal runat="server" meta:resourcekey="lblStatus"/>
							</th>
							<td>
								<asp:Literal id="lblStatus" runat="server"/>
							</td>
						</tr>

						<tr>
							<th class="b_none">
								<asp:Literal runat="server" meta:resourcekey="lblSubject"/>
							</th>
							<td>
								<asp:Literal id="lblSubject" runat="server"/>
							</td>
						</tr>
					</tbody>
				</table>

				<table class="N_table" style="border-spacing:0; padding:0;">
					<tr style="min-height:200px; height:200px;">
						<td style="vertical-align:top;">
							<asp:Literal id="lblContents" runat="server"/>
						</td>
					</tr>
				</table>

				<table class="N_table" style="border-spacing:0; padding:0;">
					<thead>
						<tr>
							<td colspan="2"><b><asp:Literal id="lblFile" runat="server" meta:resourcekey="lblFile"/></b></td>
						</tr>
					</thead>
					<tbody>
<asp:Repeater id="repFileList" runat="server">
	<ItemTemplate>
						<tr>
							<td>
								<a href="/FileUp/<%# Eval("cMenuNo") %>/<%# Eval("cFileNo") %>.<%# Eval("cFileExt")%>" target="_blank">
									<%# Eval("cFileName")%>
								</a>
							</td>
							<td style="width:100px; text-align:right;">
								<%# Math.Round(Convert.ToDouble(Eval("cFileSize")) / 1024.0 / 1024.0, 2) %>
								<asp:Literal runat="server" meta:resourcekey="lblSize"/>
							</td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
					</tbody>
				</table>

<asp:Panel id="pnAnswer" Visible="false" runat="server">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<thead>
						<tr>
							<td><b><asp:Literal runat="server" meta:resourcekey="lblProcessing"/></b></td>
						</tr>
					</thead>
					<tr style="min-height:200px; height:200px;">
						<td style="vertical-align:top;">
							<asp:Literal id="lblContents2" runat="server"/>
						</td>
					</tr>
				</table>
</asp:Panel>

				<div class="btnArea">
					<div class="btn">
						<ul>
							<li>
								<a href="javascript:fnList();">
									<asp:Literal runat="server" meta:resourcekey="btnList"/>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- btnArea -->
			</div>
			<!-- con_table -->

			<div class="cmmtTitle" style="margin-top:20px;">
				<asp:Literal runat="server" meta:resourcekey="lblCmtTitle"/>
			</div>
			<table class="cmmtList">
				<tr>
					<td>
						<textarea id="txtComment" style="height:80px; width:100%;" maxlength="4000"></textarea>
					</td>
					<td style="width:1px;">
						<div class="btn3">
							<ul>
								<li>
									<a href="javascript:fnRegistClick();">
										<asp:Literal runat="server" meta:resourcekey="btnConfirm"/>
									</a>
								</li>
							</ul>
						</div>
					</td>
				</tr>
			</table>

			<a id="bookMark"></a>
			<span id="lblComment" class="cmmtTitle" style="margin-top:10px; display:none;">
				<asp:Literal runat="server" meta:resourcekey="lblCommt"/>
			</span>
			<div id="ulReplyList" style="margin-top:20px; display:none;"></div>

			<div id="Paging" class="pagingArea">
				<div class="paging">
					<span id="pagi"></span>
				</div>
			</div>
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
