<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="view.aspx.cs"
	Inherits="Web.Manage.web.board.view"
%>
<asp:Content ContentPlaceHolderId="cpStyles" runat="server">
	<link rel="stylesheet" type="text/css" href="/_common/_css/common.css" />
	<link rel="stylesheet" type="text/css" href="/_common/_css/layout.css" />
</asp:Content>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gLabel = {
				pRecomd : "<%= fnLabelText("lbl_Recomd") %>"
			,	pAganst : "<%= fnLabelText("lbl_Aganst") %>"
			,	pReport : "<%= fnLabelText("lbl_Report") %>"
			,	pModify : "<%= fnLabelText("lblEdit.Text") %>"
			,	pDelete : "<%= fnLabelText("lblDrop.Text") %>"
			,	pReDate : "<%= fnLabelText("lblDate.Text") %>"
			,	pWriter : "<%= fnLabelText("lblWriter.Text") %>"
			};
		var gMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Error_02 : "<%= fnLabelText("msgError_02") %>"
			,	Error_03 : "<%= fnLabelText("msgError_03") %>"
			,	Error_04 : "<%= fnLabelText("msgError_04") %>"
			};
	</script>

	<script type="text/javascript" src="/_common/_js/view.js" charset="utf-8"></script>
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
			<asp:HiddenField id="pIsWrite" runat="server"/>
		</div>

		<div class="content_page">
			<div class="con_table">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:15%;"/>
						<col style="width:25%;"/>
						<col style="width:15%;"/>
						<col/>
						<col style="width:10%;"/>
						<col style="width:10%;"/>
					</colgroup>
					<thead>
						<tr>
							<th colspan="6" class="title">
								<asp:Literal id="txtSubject" runat="server"/>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="Writer"><asp:Literal runat="server" meta:resourcekey="lblWriter"/></th>
							<td><asp:Literal id="txtWriter" runat="server"/></td>
							<th class="date"><asp:Literal runat="server" meta:resourcekey="lblDate"/></th>
							<td><asp:Literal id="txtDate" runat="server"/></td>
							<th class="hit"><asp:Literal runat="server" meta:resourcekey="lblHits"/></th>
							<td><asp:Literal id="txtHits" runat="server"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="board__view">
				<asp:Literal id="txtContents" runat="server"/>
			</div>

			<div id="dvFileList" class="con_table" style="border-bottom: 2px solid #ccc;" Visible="False" runat="server">
				<table class="N_table" style="border-spacing:0; padding:0;">
					<thead>
						<tr>
							<td colspan="2"><b><asp:Literal runat="server" meta:resourcekey="lblFile"/></b></td>
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
			</div>
			<!--// Attach file list -->

			<div class="btnArea">
				<div class="btn_like">
					<asp:LinkButton id="btnLike" OnClientClick="return false;" runat="server"/>
				</div>
				<div class="btn_hate">
					<asp:LinkButton id="btnHate" OnClientClick="return false;" runat="server"/>
				</div>

				<div class="btn">
					<ul>
						<li id="liEdit" Visible="False" runat="server">
							<a href="javascript:fnEdit();">
								<asp:Literal runat="server" meta:resourcekey="lblEdit"/>
							</a>
						</li>
						<li id="liDrop" Visible="False" runat="server">
							<asp:LinkButton OnClientClick="return fnDrop();" runat="server" meta:resourcekey="lblDrop"/>
						</li>
						<li>
							<a href="javascript:fnList();">
								<asp:Literal runat="server" meta:resourcekey="lblList"/>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- btnArea -->

			<div id="lblCommtTitle" class="cmmtTitle" style="margin-top:20px;" Visible="False" runat="server">
				<asp:Literal runat="server" meta:resourcekey="lblCmtTitle"/>
			</div>
			<table id="txtCommtArea" class="cmmtList" Visible="False" runat="server">
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
