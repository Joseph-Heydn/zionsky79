<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="adminGroups.aspx.cs"
	Inherits="Web.Manage.site.adminGroups"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript" src="/_common/_js/__common2.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			fnSelectRow();
		});


		var initFlag = 0;
		// 테이블 리스트
		var tblList = new Array("dgAdminLeft", "dgAdminRight", "dgAuthLeft", "dgAuthRight");
		var objList = new Array("chkSelect");	// 변수에 저장하고 싶은 컨트롤 리스트
		var tblSpec = new Array();				// 필요한 Table수 만큼 늘려서 사용 (테이블의 CheckBox Object 저장 변수)
		var tblFilt = new Array();
		var arTables = new Array(tblSpec, tblFilt);

		function fnSetSiteGroup(pObj) {
			var vObj = document.getElementById("<%= txtSiteGrpNo.ClientID %>");
			vObj.value = pObj.value;
		}

		// 클릭한 row highlight
		function fnSelectRow() {
			var txtMainNo = $("#<%= txtMainNo.ClientID %>");
			$("#m"+ txtMainNo.val()).attr("class", "selectedRow");
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div class="row">
		<div class="col-xs-4">
			<!-- 그룹목록 -->
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_01"/>
						<asp:HiddenField id="txtMainNo" runat="server"/>
					</h3>
				</div>
				<div class="box-content">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:105px;"><asp:Literal runat="server" meta:resourcekey="dg_grp_nm"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="dg_note_desc"/></td>
						</tr>
<asp:Repeater id="repGroupList" OnItemCommand="repGroupList_OnItemCommand" runat="server">
	<ItemTemplate>
						<tr id="m<%# Eval("cCommGroup") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
							<td>
								<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
									<asp:Literal id="cCommName" Text='<%# Eval("cCommName") %>' runat="server"/>
								</asp:LinkButton>
							</td>
							<td style="text-align:left;">
								<asp:Literal id="cNoteText" Text='<%# Eval("cNoteText") %>' runat="server"/>
								<asp:Literal id="cSiteGroup" Text='<%# Eval("cSiteGroup") %>' Visible="False" runat="server"/>
								<asp:Literal id="cCommGroup" Text='<%# Eval("cCommGroup") %>' Visible="False" runat="server"/>
							</td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
					</table>
				</div>
			</div>
			<!--// 그룹목록 -->
		</div>

		<div id="panelGroupInfo" class="col-xs-8" runat="server">
			<!-- 구성원 관리 -->
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_03"/>
					</h3>
				</div>
				<div class="box-content">
					<!-- 비 구성원 -->
					<div style="width:315px; border:1px solid #ccc; background-color:#cccccc; display:inline-block; text-align:center;">
						<asp:Label Font-Size="9pt" Font-Bold="True" EnableViewState="False" runat="server" meta:resourcekey="lbl_AdminLeft"/>
						(<asp:Label id="lblAdminLeft" runat="server"/>)
						<div style="width:315px; height:180px; overflow-y:scroll; overflow-x:hidden; background-color:#ffffff; border-color:#cccccc;" onmouseover="document.body.style.overflow='hidden'" onmouseout="document.body.style.overflow='auto'">
							<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
								<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
									<td style="width:030px;"><asp:CheckBox id="chkAdminLeft" onclick="fnCheckAll(this,'cBlank');" EnableViewState="False" runat="server"/></td>
									<td style="width:150px;"><asp:Literal runat="server" meta:resourcekey="dg2_admin_id"/></td>
									<td><asp:Literal runat="server" meta:resourcekey="dg2_dept_nm"/></td>
								</tr>
<asp:Repeater id="repAdminLeft" runat="server">
	<ItemTemplate>
								<tr class="<%= fnRowStyle() %>" style="text-align:center;">
									<td><input type="checkbox" id="chkSelect" onclick="fnCheckOne(this,'');" value='<%# Eval("cAdminNo") %>' class="cBlank" style="margin:0;" runat="server"/></td>
									<td>
										<%# Eval("cAdminName") %><br/>
										<%# Eval("cAdminId") %>
									</td>
									<td><%# Eval("cCommName") %></td>
								</tr>
	</ItemTemplate>
</asp:Repeater>
							</table>
						</div>
					</div>
					<!--// 비 구성원 -->

					<!-- 버튼 -->
					<div style="width:30px; display:inline-block; vertical-align:top; padding-top:70px;">
						<asp:Button OnClick="btnApplyMember_OnClick" CssClass="cButton" Width="30" runat="server" meta:resourcekey="btn_Add"/><br /><br />
						<asp:Button OnClick="btnRemoveMember_OnClick" CssClass="cButton" Width="30" runat="server" meta:resourcekey="btn_Del"/>
					</div>
					<!--// 버튼 -->

					<!-- 구성원 -->
					<div style="width:315px; border:1px solid #ccc; background-color:#cccccc; display:inline-block; text-align:center;">
						<asp:Label Font-Size="9pt" Font-Bold="True" EnableViewState="False" runat="server" meta:resourcekey="lbl_AdminRight"/>
						(<asp:Label id="lblAdminRight" runat="server"/>)
						<div style="width:315px; height:180px; overflow-y:scroll; overflow-x:hidden; background-color:#ffffff;" onmouseover="document.body.style.overflow='hidden'" onmouseout="document.body.style.overflow='auto'">
							<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
								<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
									<td style="width:030px;"><asp:CheckBox id="chkAdminRight" onclick="fnCheckAll(this,'cBlank2');" EnableViewState="False" runat="server"/></td>
									<td style="width:150px;"><asp:Literal runat="server" meta:resourcekey="dg2_admin_id"/></td>
									<td><asp:Literal runat="server" meta:resourcekey="dg2_dept_nm"/></td>
								</tr>
<asp:Repeater id="repAdminRight" runat="server">
	<ItemTemplate>
								<tr class="<%= fnRowStyle() %>" style="text-align:center;">
									<td><input type="checkbox" id="chkSelect" onclick="fnCheckOne(this,'');" value='<%# Eval("cAdminNo") %>' class="cBlank2" style="margin:0;" runat="server"/></td>
									<td>
										<%# Eval("cAdminName") %><br/>
										<%# Eval("cAdminId") %>
									</td>
									<td><%# Eval("cCommName") %></td>
								</tr>
	</ItemTemplate>
</asp:Repeater>
							</table>
						</div>
					</div>
					<!--// 구성원 -->
				</div>
			</div>
			<!--// 구성원 관리 -->

			<!-- 메뉴권한 관리 -->
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_04"/>
					</h3>
					<div style="display:none; float:right; vertical-align:top; margin-top:-5px;">
						<asp:DropDownList id="drpSiteGrpNo" OnSelectedIndexChanged="drpSiteGrpNo_OnChanged" onchange="fnSetSiteGroup(this);" AutoPostBack="True" runat="server"/>
					</div>
				</div>
				<div class="box-content">
					<!-- 미 등록 메뉴 -->
					<div style="width:328px; border:1px solid #ccc; background-color:#cccccc; display:inline-block; text-align:center;">
						<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_AuthLeft"/>
						(<asp:Label id="lblAuthLeft" runat="server"/>)
						<div style="width:328px; height:350px; overflow-y:scroll; overflow-x:hidden; background-color:#ffffff; border-color:#cccccc;" onmouseover="document.body.style.overflow='hidden'" onmouseout="document.body.style.overflow='auto'">
							<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
								<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
									<td style="width:030px;"><asp:CheckBox id="chkAuthLeft" onclick="fnCheckAll(this,'cBlank3');" EnableViewState="False" runat="server"/></td>
									<td style="width:100px;"><asp:Literal runat="server" meta:resourcekey="dg_grp_nm"/></td>
									<td><asp:Literal runat="server" meta:resourcekey="dg4_menu_nm"/></td>
									<td style="width:050px;"><asp:Literal runat="server" meta:resourcekey="dg4_write_flag"/></td>
								</tr>
<asp:Repeater id="repAuthLeft" runat="server">
	<ItemTemplate>
								<tr class="<%= fnRowStyle() %>" style="text-align:center;">
									<td><input type="checkbox" id="chkSelect" onclick="fnCheckOne(this,'');" value='<%# Eval("cMenuNo") %>' class="cBlank3" style="margin:0;" runat="server"/></td>
									<td><%# Eval("cCommName") %></td>
									<td><%# Eval("cMenuName") %></td>
									<td><input type="checkbox" id="chkWriteFlag" value='<%# Eval("cMenuNo") %>' style="margin:0;" runat="server"/></td>
								</tr>
	</ItemTemplate>
</asp:Repeater>
							</table>
						</div>
					</div>
					<!--// 미 등록 메뉴 -->

					<!-- 버튼 -->
					<div style="width:30px; display:inline-block; vertical-align:top; padding-top:150px;">
						<asp:Button OnClick="btnApplyMenu_OnClick" CssClass="cButton" Width="30" runat="server" meta:resourcekey="btn_Add"/><br /><br />
						<asp:Button OnClick="btnRemoveMenu_OnClick" CssClass="cButton" Width="30" runat="server" meta:resourcekey="btn_Del"/>
					</div>
					<!--// 버튼 -->

					<!-- 등록 메뉴 -->
					<div style="width:315px; border:1px solid #ccc; background-color:#cccccc; display:inline-block; text-align:center;">
						<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_AuthRight"/>
						(<asp:Label id="lblAuthRight" runat="server"/>)
						<div style="width:315px; height:350px; overflow-y:scroll; overflow-x:hidden; background-color:#ffffff; border-color:#cccccc;" onmouseover="document.body.style.overflow='hidden'" onmouseout="document.body.style.overflow='auto'">
							<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
								<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
									<td style="width:030px;"><asp:CheckBox id="chkAuthRight" onclick="fnCheckAll(this,'cBlank4');" EnableViewState="False" runat="server"/></td>
									<td style="width:100px;"><asp:Literal runat="server" meta:resourcekey="dg_grp_nm"/></td>
									<td><asp:Literal runat="server" meta:resourcekey="dg4_menu_nm"/></td>
									<td style="width:050px;"><asp:Literal runat="server" meta:resourcekey="dg4_write_flag"/></td>
								</tr>
<asp:Repeater id="repAuthRight" runat="server">
	<ItemTemplate>
								<tr class="<%= fnRowStyle() %>" style="text-align:center;">
									<td><input type="checkbox" id="chkSelect" onclick="fnCheckOne(this,'');" value='<%# Eval("cMenuNo") %>' class="cBlank4" style="margin:0;" runat="server"/></td>
									<td><%# Eval("cCommName") %></td>
									<td><%# Eval("cMenuName") %></td>
									<td><%# Eval("cIsWrite") %></td>
								</tr>
	</ItemTemplate>
</asp:Repeater>
							</table>
						</div>
					</div>
					<!--// 미 등록 메뉴 -->
				</div>
			</div>
		</div>
		<!--// 메뉴권한 관리 -->
	</div>

	<asp:Panel Visible="False" runat="server">
		<!-- 그룹 기본 정보 -->
		<div style="display:none;">
			<div style="width:200px; display:inline-block; padding-top:4px;">
				<asp:Label Font-Bold="True" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_02"/>
			</div>
			<div style="display:inline-block; float:right;">
				<asp:Button OnClick="btnNewGroup_OnClick" CssClass="cButton" Visible="False" runat="server" meta:resourcekey="btn_NewAdmin"/>
				<asp:Button OnClick="btnSaveGroup_OnClick" CssClass="cButton" Visible="False" runat="server" meta:resourcekey="btn_SaveAdmin"/>
			</div>
		</div>
		<table style="border-collapse:collapse; width:500px; border:1px; padding:0; border-spacing:0; display:none;">
			<tr>
				<td class="tbLayoutHeader" style="width:100px; height:25px;">&nbsp;<asp:Label Font-Bold="False" Font-Size="9pt" EnableViewState="False" runat="server" meta:resourcekey="lbl_GrpNo"/></td>
				<td class="tbLayout" style="width:400px;">
					&nbsp;<asp:TextBox id="txtCommGrpNo" BackColor="#e0e0e0" ReadOnly="True" runat="server"/>
					<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_Auto"/>
				</td>
			</tr>
			<tr>
				<td class="tbLayoutHeader" style="height:25px;">&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_GrpNm"/></td>
				<td class="tbLayout">&nbsp;<asp:TextBox id="txtCommGrpNm" Width="300px" runat="server"/></td>
			</tr>
			<tr>
				<td class="tbLayoutHeader" style="height:25px;">&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_UseFlag"/></td>
				<td class="tbLayout">
					<asp:RadioButton id="rdoUseFlag1" GroupName="UseFlag" runat="server" meta:resourcekey="rdo_UseFlag1"/>
					<asp:RadioButton id="rdoUseFlag2" GroupName="UseFlag" runat="server" meta:resourcekey="rdo_UseFlag2"/>
				</td>
			</tr>
			<tr>
				<td class="tbLayoutHeader" style="height:25px;">&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_NoteDesc"/></td>
				<td class="tbLayout" style="background-color:#ffffff;">&nbsp;<asp:TextBox id="txtNoteDesc" Height="70px" MaxLength="200" TextMode="MultiLine" Width="395" runat="server"/></td>
			</tr>
		</table>
		<!--// 그룹 기본 정보 -->
	</asp:Panel>

	<div style="display:none; float:right;" visible="False" runat="server">
		<asp:DropDownList id="drpFilter" runat="server">
			<asp:ListItem meta:resourcekey="drpFilter_01"/>
			<asp:ListItem meta:resourcekey="drpFilter_02"/>
		</asp:DropDownList>
		<asp:TextBox id="txtCondition" runat="server"/>
		<asp:TextBox id="txtSiteGrpNo" CssClass="hidden" runat="server"/>
		<asp:TextBox id="txtAuthGrpNo" CssClass="hidden" runat="server"/>
		<asp:TextBox id="txtSelected" CssClass="hidden" runat="server"/>
		<asp:TextBox id="txtSelected2" CssClass="hidden" runat="server"/>
		<asp:Button OnClick="btnSearch_Click" CssClass="button" runat="server" meta:resourcekey="btn_Search"/>
	</div>
</asp:Content>
