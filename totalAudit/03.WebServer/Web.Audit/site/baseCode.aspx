<%@ Page
	Title=""
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="baseCode.aspx.cs"
	Inherits="Web.Audit.site.baseCode"
%>
<asp:Content ContentPlaceHolderId="script" runat="server">
	<script type="text/javascript">
		$(document).ready(function() {
			fnSelectRow();
		});


		// 클릭한 row highlight
		function fnSelectRow() {
			var txtMainNo = $("#<%= txtMainNo.ClientID %>");
			var txtListNo = $("#<%= txtListNo.ClientID %>");
			var vMainRow = $("#m"+ txtMainNo.val());
			var vListRow = $("#w"+ txtListNo.val());

			if ( vMainRow != null ) vMainRow.attr("class", "selectedRow");
			if ( vListRow != null ) vListRow.attr("class", "selectedRow");
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="contents" runat="server">
	<!-- content starts -->
	<div class="box col-md-6" style="width:470px; margin-top:0; display:inline-block;">
		<!-- 기본코드관리 -->
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title1" />
				</h2>
				<div style="text-align:right; display:inline-block; float:right;">
					<asp:Button OnClick="btnNewSite_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_NewSiteGrp" />
					<asp:HiddenField id="txtMainNo" runat="server" />
					<asp:HiddenField id="txtListNo" runat="server" />
				</div>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
					<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
						<td style="width:070px;"><asp:Literal runat="server" meta:resourcekey="dg_SiteGrpNo" /></td>
						<td style="width:100px;"><asp:Literal runat="server" meta:resourcekey="dg_SiteGrpNm" /></td>
						<td><asp:Literal runat="server" meta:resourcekey="dg_NoteDesc" /></td>
					</tr>
<asp:Repeater id="repSiteGroupList" OnItemCommand="repSiteGrpList_OnItemCommand" runat="server">
	<ItemTemplate>
					<tr id="m<%# Eval("cSiteGroup") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
						<td>
							<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
								<asp:Literal id="cSiteGroup" Text='<%# Eval("cSiteGroup") %>' runat="server" />
							</asp:LinkButton>
						</td>
						<td>
							<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
								<asp:Literal id="cSiteName" Text='<%# Eval("cSiteName") %>' runat="server" />
							</asp:LinkButton>
						</td>
						<td>
							<asp:Literal id="cNoteText" Text='<%# Eval("cNoteText") %>' runat="server" />
							<asp:Literal id="cIsUsed" Text='<%# Eval("cIsUsed") %>' Visible="False" runat="server" />
						</td>
					</tr>
	</ItemTemplate>
</asp:Repeater>
				</table>
			</div>
		</div>
		<!--// 기본코드관리 끝 -->
	</div>

	<div id="pnlContets" style="width:650px; margin-top:0; display:inline-block;" runat="server">
		<!-- 상세내용 -->
		<!-- 관리항목 기본정보 -->
		<div id="pnlNewSite" Visible="False" class="box col-md-6" style="width:620px; margin-top:0;" runat="server">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title2" />
					</h2>
					<div style="display:inline-block; float:right;">
						<asp:Button OnClick="btnSaveSite_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_SaveSiteGrp" />
					</div>
				</div>
				<div class="box-content">
					<table class="table table-bordered" style="width:565px; font-size:9pt;">
						<tr>
							<td class="tbLayoutHeader" style="width:100px; height:25px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_SiteGrpNo" />
							</td>
							<td class="tbLayout" style="width:465px;">
								&nbsp;<asp:TextBox id="txtSiteGrpNo" Width="100px" ReadOnly="True" BackColor="#e0e0e0" runat="server" />
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_Auto" />
							</td>
						</tr>
						<tr>
							<td class="tbLayoutHeader" style="height:25px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_SiteGrpNm" />
							</td>
							<td class="tbLayout">
								&nbsp;<asp:TextBox id="txtSiteGrpNm" Font-Size="9pt" MaxLength="20" Width="245px" runat="server" />
								&nbsp;
								<asp:RadioButton id="rdoUseFlag1" GroupName="UseFlag" Font-Size="9pt" runat="server" meta:resourcekey="rdb_UseFlag1" />
								<asp:RadioButton id="rdoUseFlag2" GroupName="UseFlag" Font-Size="9pt" runat="server" meta:resourcekey="rdb_UseFlag2" />
							</td>
						</tr>
						<tr>
							<td class="tbLayoutHeader" style="height:50px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_NoteDesc" />
							</td>
							<td class="tbLayout">
								&nbsp;<asp:TextBox id="txtSiteDesc" Width="98%" Height="61px" Font-Size="9pt" TextMode="MultiLine" runat="server" />
								<div style="float:right; margin-right:7px;">(<asp:Label runat="server" meta:resourcekey="lbl_LimitString" />)</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!--// 관리항목 기본정보 끝 -->

		<!-- 그룹목록 -->
		<div id="pnlNewGrp" Visible="False" class="box col-md-6" style="width:650px; margin-top:0;" runat="server">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Size="9" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title4" />
					</h2>
					<div style="display:inline-block; float:right;">
						<asp:Button OnClick="btnSaveGrp_Click" CssClass="cButton" runat="server" meta:resourcekey="btn_SaveGrp" />
					</div>
				</div>
				<div class="box-content">
					<table class="table table-bordered" style="width:565px; font-size:9pt;">
						<tr>
							<td class="tbLayoutHeader" style="width:100px; height:25px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_CommGrpNo" />
							</td>
							<td class="tbLayout" style="width:465px;">
								&nbsp;<asp:TextBox id="txtCommGrpNo" Width="100px" ReadOnly="True" BackColor="#e0e0e0" runat="server" />
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_Auto" />
							</td>
						</tr>
						<tr>
							<td class="tbLayoutHeader" style="height:25px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_CommGrpNm" />
							</td>
							<td class="tbLayout">
								&nbsp;<asp:TextBox id="txtCommGrpNm" Width="190px" MaxLength="25" runat="server" />&nbsp;
								<asp:RadioButton id="rdoUseFlag3" GroupName="UseFlag2" Font-Size="9pt" runat="server" meta:resourcekey="rdb_UseFlag1" />
								<asp:RadioButton id="rdoUseFlag4" GroupName="UseFlag2" Font-Size="9pt" runat="server" meta:resourcekey="rdb_UseFlag2" />
							</td>
						</tr>
						<tr>
							<td class="tbLayoutHeader" style="height:50px;">
								&nbsp;<asp:Literal runat="server" meta:resourcekey="lbl_NoteDesc" />
							</td>
							<td class="tbLayout">
								&nbsp;<asp:TextBox id="txtCommDesc" Width="98%" Height="61px" Columns="17" Rows="6" Font-Size="9pt" TextMode="MultiLine" runat="server" />
								<div style="float:right; margin-right:7px;">(<asp:Label runat="server" meta:resourcekey="lbl_LimitString" />)</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div><br />

		<div id="pnlGrpList" Visible="False" class="box col-md-6" style="width:655px;" runat="server">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title3" />
					</h2>
					<div style="display:inline-block; float:right;">
						<asp:Button OnClick="btnNewGrp_Click" CssClass="cButton" runat="server" meta:resourcekey="btn_NewGrp" />
					</div>
				</div>
				<div class="box-content">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td><asp:Literal runat="server" meta:resourcekey="dg2_CommGrpNo" /></td>
							<td><asp:Literal runat="server" meta:resourcekey="dg2_CommGrpNm" /></td>
							<td><asp:Literal runat="server" meta:resourcekey="dg_NoteDesc" /></td>
							<td><asp:Literal runat="server" meta:resourcekey="dg2_OrderbyNo" /></td>
						</tr>
<asp:Repeater id="repGroupList" OnItemCommand="repGroupList_OnItemCommand" runat="server">
	<ItemTemplate>
						<tr id="w<%# Eval("cCommGroup") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
							<td>
								<asp:Literal id="cCommGroup" Text='<%# Eval("cCommGroup") %>' runat="server" />
								<asp:Literal id="cIsUsed" Text='<%# Eval("cIsUsed") %>' Visible="False" runat="server" />
								<asp:Literal id="cOrderBy" Text='<%# Eval("cOrderBy") %>' Visible="False" runat="server" />
							</td>
							<td>
								<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
									<asp:Literal id="cCommName" Text='<%# Eval("cCommName") %>' runat="server" />
								</asp:LinkButton>
							</td>
							<td style="text-align:left;"><asp:Literal id="cNoteText" Text='<%# Eval("cNoteText") %>' runat="server" /></td>
							<td>
								<asp:DropDownList id="drpIndex" OnSelectedIndexChanged="drpIndex_OnSelectedIndexChanged" AutoPostBack="True" style="width:105%" runat="server"/>
							</td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
					</table>
				</div>
			</div>
		</div>
		<!--// 그룹목록 끝 -->
	</div>
	<!--// 상세내용 끝 -->

	<div style="width:330px; display:none; text-align:right;" Visible="False" runat="server">
		<asp:DropDownList id="drpGrpCD" runat="server">
			<asp:ListItem meta:resourcekey="drp_GrpCd_01" />
			<asp:ListItem meta:resourcekey="drp_GrpCd_02" />
		</asp:DropDownList>
		<asp:TextBox id="txtCondition" Width="120" runat="server" />
		<asp:Button OnClick="btnSearch_OnClick" CssClass="button" runat="server" meta:resourcekey="btn_Search" />
	</div>
</asp:Content>
