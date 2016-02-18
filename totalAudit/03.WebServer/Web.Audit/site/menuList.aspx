<%@ Page
	Title=""
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="menuList.aspx.cs"
	Inherits="Web.Audit.site.menuList"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		$(document).ready(function() {
			fnSelectRow();
		});


		function fnSetGroup(pObj) {
			var tObj = $("#<%= txtMenuGrp.ClientID %>");
			tObj.val(pObj.value);
		}

		// 클릭한 row highlight
		function fnSelectRow() {
			var txtMainNo = $("#<%= txtMainNo.ClientID %>");
			$("#m"+ txtMainNo.val()).attr("class", "selectedRow");
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<!-- content starts -->
	<div class="box col-md-6" style="width:655px; margin-top:0;">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title1" />
				</h2>
				<div style="display:inline-block; float:right;">
					<asp:DropDownList id="drpMenuGrp" CssClass="cDropDown" OnSelectedIndexChanged="btnSearch_OnClick" AppendDataBoundItems="True" onchange="fnSetGroup(this);" AutoPostBack="True" runat="server">
						<asp:ListItem meta:resourcekey="drpMenuGrp_01" />
					</asp:DropDownList>
					<asp:DropDownList id="drpFilter" CssClass="cDropDown" runat="server">
						<asp:ListItem meta:resourcekey="drpFilter_01" />
						<asp:ListItem meta:resourcekey="drpFilter_02" />
					</asp:DropDownList>
					<asp:TextBox id="txtFilter" CssClass="cTextbox" Width="120px" runat="server" />
					<asp:Button OnClick="btnSearch_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_Search" />
					<span style="display:none;">
						<asp:TextBox id="txtSiteGrpNo" runat="server" />
						<asp:TextBox id="txtMenuGrp" runat="server" />
						<asp:TextBox id="txtMenuGrpNo" runat="server" />
						<asp:TextBox id="txtOldSeqNo" runat="server" />
						<asp:HiddenField id="txtMainNo" runat="server" />
					</span>
				</div>
			</div>
			<div class="box-content">
				<!-- 메뉴 목록 -->
				<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
					<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
						<td style="width:085px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_menu_no" /></td>
						<td style="width:085px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_menu_grp_nm" /></td>
						<td style="width:140px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_menu_nm" /></td>
						<td><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_note_desc" /></td>
					</tr>
<asp:Repeater id="repMenuList" OnItemCommand="repMenuList_OnItemCommand" runat="server">
	<ItemTemplate>
					<tr id="m<%# Eval("cMenuNo") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
						<td><asp:Literal id="cMenuNo" Text='<%# Eval("cMenuNo") %>' runat="server" /></td>
						<td>
							<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
								<asp:Literal id="cGroupName" Text='<%# Eval("cGroupName") %>' runat="server" />
							</asp:LinkButton>
						</td>
						<td>
							<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
								<asp:Literal id="cMenuName" Text='<%# Eval("cMenuName") %>' runat="server" />
							</asp:LinkButton>
						</td>
						<td>
							<asp:Literal id="cExecUrl" Text='<%# Eval("cExecUrl") %>' runat="server" />
							<asp:Literal id="cNoteText" Text='<%# Eval("cNoteText") %>' visible="False" runat="server" />
							<asp:Literal id="cMenuGroup" Text='<%# Eval("cMenuGroup") %>' visible="False" runat="server" />
							<asp:Literal id="cIsUsed" Text='<%# Eval("cIsUsed") %>' visible="False" runat="server" />
							<asp:Literal id="cIsView" Text='<%# Eval("cIsView") %>' visible="False" runat="server" />
							<asp:Literal id="cOrderBy" Text='<%# Eval("cOrderBy") %>' visible="False" runat="server" />
						</td>
					</tr>
	</ItemTemplate>
</asp:Repeater>
				</table>
				<!--// 메뉴 목록 -->
			</div>
		</div>
		<!--/span-->
	</div><!--/row-->

	<!-- 메뉴 기본 정보 -->
	<div class="box col-md-6" style="width:560px; margin-top:0;">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title2" />
				</h2>
				<div style="display:inline-block; float:right; padding-bottom:3px;">
					<asp:Button OnClick="btnNew_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_New" />&nbsp;
					<asp:Button OnClick="btnSave_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_Save" />
				</div>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:500px;">
					<tr>
						<td class="tbLayoutHeader" style="width:100px; height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_MenuNo" />
						</td>
						<td class="tbLayout" style="width:400px;">
							<asp:TextBox id="txtMenuNo" runat="server" ReadOnly="true" BackColor="Silver" />
							<asp:Label Font-Size="9pt" runat="server" meta:resourcekey="lbl_Auto" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_MenuNM" />
						</td>
						<td class="tbLayout"><asp:TextBox id="txtMenuName" Width="200px" style="text-align:left;" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_ExecUrl" />
						</td>
						<td class="tbLayout"><asp:TextBox id="txtExecUrl" Width="370px" style="text-align:left;" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_DeptNo" />
						</td>
						<td class="tbLayout">
							<asp:DropDownList id="drpMenuGrpNo" AppendDataBoundItems="True" Width="132px" runat="server">
								<asp:ListItem meta:resourcekey="drpMenuGrpNo_01" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_IsUsed" />
						</td>
						<td class="tbLayout">
							<asp:RadioButton id="rdoIsUsed1" GroupName="UsedGrp" runat="server" meta:resourcekey="rdo_IsUsed1" />&nbsp;&nbsp;
							<asp:RadioButton id="rdoIsUsed2" GroupName="UsedGrp" runat="server" meta:resourcekey="rdo_IsUsed2" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_IsView" />
						</td>
						<td class="tbLayout">
							<asp:RadioButton id="rdoIsView1" GroupName="ViewGrp" runat="server" meta:resourcekey="rdo_IsUsed1" />&nbsp;&nbsp;
							<asp:RadioButton id="rdoIsView2" GroupName="ViewGrp" runat="server" meta:resourcekey="rdo_IsUsed2" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_OrderbyNo" />
						</td>
						<td class="tbLayout"><asp:TextBox id="txtOrderNo" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_NoteDesc" />
						</td>
						<td class="tbLayout"><asp:TextBox id="txtNoteDesc" Width="390px" Height="70px" TextMode="MultiLine" MaxLength="200" runat="server" /></td>
					</tr>
				</table>
			</div>
		</div>
		<!--/span-->
	</div><!--/row-->
	<!--// 메뉴 기본 정보 -->
</asp:Content>
