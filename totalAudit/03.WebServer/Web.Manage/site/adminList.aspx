<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="adminList.aspx.cs"
	Inherits="Web.Manage.site.adminList"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		$(document).ready(function() {
			fnSelectRow();
		});


		// 그룹 변경 (검색)
		function fnSetGroup() {
			$("#<%= txtUserGroup.ClientID %>").val($("#<%= drpAuthGrp.ClientID %>").val());
		}

		// 클릭한 row highlight
		function fnSelectRow() {
			var txtMainNo = $("#<%= txtAdminNo.ClientID %>");
			$("#m"+ txtMainNo.val()).attr("class", "selectedRow");
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div class="row">
		<!-- 관리자 목록 -->
		<div class="col-xs-6">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">
						<i class="glyphicon glyphicon-list-alt"></i>
						<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title_01"/>
					</h3>
					<div style="display:inline-block; float:right;">
						<asp:DropDownList id="drpAuthGrp" OnSelectedIndexChanged="btnSearch_OnClick" onchange="fnSetGroup();" AppendDataBoundItems="True" CssClass="cDropDown" Width="110" AutoPostBack="True" runat="server">
							<asp:ListItem meta:resourcekey="drpAuthGrp_01"/>
						</asp:DropDownList>
						<asp:DropDownList id="drpFilter" CssClass="cDropDown" Width="110" runat="server">
							<asp:ListItem meta:resourcekey="drpFilter_01"/>
							<asp:ListItem meta:resourcekey="drpFilter_02"/>
							<asp:ListItem meta:resourcekey="drpFilter_03"/>
						</asp:DropDownList>
						<asp:TextBox id="txtFilter" Width="120" CssClass="cTextbox" runat="server"/>
						<asp:Button OnClick="btnSearch_OnClick" CssClass="btn-xs" runat="server" meta:resourcekey="sh_btn_Search"/>
						<asp:HiddenField id="txtUserGroup" runat="server"/>
					</div>
				</div>
				<div class="box-content">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:100px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_AdminNo"/></td>
							<td style="width:150px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_AdminId"/></td>
							<td style="width:120px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_AuthGrpNm"/></td>
							<td><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_DeptGrpNm"/></td>
						</tr>
<asp:Repeater id="repAdminList" OnItemCommand="repAdminList_OnItemCommand" runat="server">
	<ItemTemplate>
						<tr id="m<%# Eval("cAdminNo") %>" class="<%= fnRowStyle() %>" style="text-align:center;">
							<td>
								<asp:Literal id="cAdminNo" Text='<%# Eval("cAdminNo") %>' runat="server"/>
								<asp:Literal id="cIsUsed" Text='<%# Eval("cIsUsed") %>' visible="False" runat="server"/>
								<asp:Literal id="cNoteText" Text='<%# Eval("cNoteText") %>' visible="False" runat="server"/>
							</td>
							<td>
								<asp:LinkButton CommandName="SELECT" runat="server">
									<asp:Literal id="cAdminName" Text='<%# Eval("cAdminName") %>' runat="server"/><br/>
									<asp:Literal id="cAdminId" Text='<%# Eval("cAdminId") %>' runat="server"/>
								</asp:LinkButton>
							</td>
							<td>
								<asp:Literal id="cAuthName" Text='<%# Eval("cAuthName") %>' runat="server"/>
								<asp:Literal id="cAuthGroup" Text='<%# Eval("cAuthGroup") %>' visible="False" runat="server"/>
							</td>
							<td>
								<asp:Literal id="cDeptName" Text='<%# Eval("cDeptName") %>' runat="server"/>
								<asp:Literal id="cDeptNo" Text='<%# Eval("cDeptNo") %>' visible="False" runat="server"/>
							</td>
						</tr>
	</ItemTemplate>
</asp:Repeater>
					</table>
				</div>
			</div>
		</div>
		<!--// 관리자 목록 -->

		<div class="col-xs-6">
			<div class="box-inner">
				<!-- 관리자 기본정보 -->
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">
							<i class="glyphicon glyphicon-list-alt"></i>
							<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title_02"/>
						</h3>
						<div style="display:inline-block; float:right; text-align:right;">
							<asp:Button OnClick="btnNew_OnClick" CssClass="cButton" runat="server" meta:resourcekey="tx_btn_New"/>&nbsp;
							<asp:Button OnClick="btnSave_OnClick" CssClass="cButton" runat="server" meta:resourcekey="tx_btn_Save"/>
						</div>
					</div>
					<div class="box-content">
						<table class="table table-bordered" style="width:100%; font-size:9pt;">
							<tr>
								<td class="tbLayoutHeader" style="width:100px; height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_AdminNo"/>
								</td>
								<td class="tbLayout" style="width:400px;">
									<asp:TextBox id="txtAdminNo" runat="server" BackColor="#e0e0e0" ReadOnly="True"/>
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_Auto"/>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_AdminNm"/>
								</td>
								<td class="tbLayout">
									<asp:TextBox id="txtAdminNm" Width="300px" style="text-align:left;" runat="server"/>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_AdminId"/>
								</td>
								<td class="tbLayout">
									<asp:TextBox id="txtAdminId" Width="300px" CssClass="EnglishOnly" style="text-align:left;" runat="server"/>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_AdminPw"/>
								</td>
								<td class="tbLayout">
									<asp:TextBox id="txtAdminPw" TextMode="Password" Width="300px" CssClass="EnglishOnly" style="text-align:left;" runat="server"/>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_DeptList"/>
								</td>
								<td class="tbLayout">
									<asp:DropDownList id="drpDeptList" AppendDataBoundItems="True" Width="132px" runat="server">
										<asp:ListItem meta:resourcekey="drpAuthList_01"/>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_AuthList"/>
								</td>
								<td class="tbLayout">
									<asp:DropDownList id="drpAuthList" AppendDataBoundItems="True" Width="132px" runat="server">
										<asp:ListItem meta:resourcekey="drpAuthList_01"/>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_UseFlag"/>
								</td>
								<td class="tbLayout">
									<asp:RadioButton id="rdoUseFlag1" GroupName="UseFlag" runat="server" meta:resourcekey="tx_rdb_UseFlag1"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:RadioButton id="rdoUseFlag2" GroupName="UseFlag" runat="server" meta:resourcekey="tx_rdb_UseFlag2"/>
								</td>
							</tr>
							<tr>
								<td class="tbLayoutHeader" style="height:25px;">
									<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_NoteDesc"/>
								</td>
								<td class="tbLayout"><asp:TextBox id="txtNoteDesc" Height="80px" Width="99%" MaxLength="200" TextMode="MultiLine" runat="server"/></td>
							</tr>
						</table>
					</div>
				</div>
				<!--// 관리자 기본정보 -->
			</div>
		</div>
	</div>
</asp:Content>
