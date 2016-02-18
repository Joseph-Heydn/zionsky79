<%@ Page
	Title=""
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="siteMenuList.aspx.cs"
	Inherits="Web.Audit.site.siteMenuList"
%>
<asp:Content ContentPlaceHolderId="script" runat="server">
	<script type="text/javascript">
		function fnSetGroup(pObj) {
			var tObj = document.getElementById(window.comm +"txtMenuGrp");
			tObj.value = pObj.value;
		}
	</script>
</asp:Content>
<asp:Content ContentPlaceHolderId="contents" runat="server">
	<!-- content starts -->
	<div class="box col-md-6" style="width:655px; margin-top:0;">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title1" />
				</h2>
				<div style="display:inline-block; float:right;">
					<asp:DropDownList id="drpMenuGrp" CssClass="cDropDown" OnSelectedIndexChanged="btnSearch_OnClick" onchange="fnSetGroup(this);" AutoPostBack="True" runat="server" />
					<asp:DropDownList id="drpFilter" CssClass="cDropDown" runat="server">
						<asp:ListItem meta:resourcekey="drp_Filter_01" />
						<asp:ListItem meta:resourcekey="drp_Filter_02" />
					</asp:DropDownList>
					<asp:TextBox id="txtFilter" CssClass="cTextbox" Width="120px" runat="server" />
					<asp:Button id="btnSearchAdmin" OnClick="btnSearch_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_Search" />
					<span style="display:none;">
						<asp:TextBox id="txtSiteGrpNo" runat="server" />
						<asp:TextBox id="txtMenuGrp" runat="server" />
						<asp:TextBox id="txtMenuGrpNo" runat="server" />
						<asp:TextBox id="txtOldSeqNo" runat="server" />
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
							<tr id="m<%# Eval("menu_no") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
								<td><asp:Literal id="menu_no" Text='<%# Eval("menu_no") %>' runat="server" /></td>
								<td>
									<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
										<asp:Literal id="menu_grp_nm" Text='<%# Eval("menu_grp_nm") %>' runat="server" />
									</asp:LinkButton>
								</td>
								<td>
									<asp:LinkButton CommandName="SELECT" OnClientClick="fnSelects(this);" runat="server">
										<asp:Literal id="menu_nm" Text='<%# Eval("menu_nm") %>' runat="server" />
									</asp:LinkButton>
								</td>
								<td>
									<asp:Literal id="note_desc" Text='<%# Eval("note_desc") %>' runat="server" />
									<asp:Literal id="menu_grp_no" Text='<%# Eval("menu_grp_no") %>' Visible="False" runat="server" />
									<asp:Literal id="orderby_no" Text='<%# Eval("orderby_no") %>' Visible="False" runat="server" />
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
					<asp:Button id="btnNew" OnClick="btnNew_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_New" />&nbsp;
					<asp:Button id="btnSave" OnClick="btnSave_OnClick" CssClass="cButton" runat="server" meta:resourcekey="btn_Save" />
				</div>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:500px;">
					<tr>
						<td class="tbLayoutHeader" style="width:100px; height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_MenuNo" />
						</td>
						<td class="tbLayout" style="width:400px;">
							<asp:TextBox id="txtMenuNo" runat="server" ReadOnly="true" BackColor="Silver" />
							<asp:Label Font-Size="9pt" runat="server" meta:resourcekey="lbl_Auto" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_MenuNM" />
						</td>
						<td class="tbLayout">&nbsp;<asp:TextBox id="txtMenuName" Width="200px" style="text-align:left;" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_ExecUrl" />
						</td>
						<td class="tbLayout">&nbsp;<asp:TextBox id="txtExecUrl" Width="370px" style="text-align:left;" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_DeptNo" />
						</td>
						<td class="tbLayout">&nbsp;<asp:DropDownList id="drpMenuGrpNo" Width="132px" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_UseTag" />
						</td>
						<td class="tbLayout">
							<asp:RadioButton id="rdoUseTag" GroupName="UseGrp" runat="server" meta:resourcekey="rdo_UseTag" />&nbsp;&nbsp;
							<asp:RadioButton id="rdoUseTag2" GroupName="UseGrp" runat="server" meta:resourcekey="rdo_UseTag2" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_OrderbyNo" />
						</td>
						<td class="tbLayout">&nbsp;<asp:TextBox id="txtOrderNo" runat="server" /></td>
					</tr>
					<tr>
						<td class="tbLayoutHeader" style="height:25px;">
							&nbsp;<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_NoteDesc" />
						</td>
						<td class="tbLayout">&nbsp;<asp:TextBox id="txtNoteDesc" Width="390px" Height="70px" TextMode="MultiLine" MaxLength="200" runat="server" /></td>
					</tr>
				</table>
			</div>
		</div>
		<!--/span-->
	</div><!--/row-->
	<!--// 메뉴 기본 정보 -->


</asp:Content>
