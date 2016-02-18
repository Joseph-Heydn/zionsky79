﻿<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="siteAdminActionLog.aspx.cs"
	Inherits="Web.Audit.site.siteAdminActionLog"
%>
<asp:Content ContentPlaceHolderId="script" runat="server">
	<script type="text/javascript">
		function fnCopyDate() {
			var objStartDate = $("#<%= txtStartDate.ClientID %>");
			var objLimitDate = $("#<%= txtLimitDate.ClientID %>");

			if ( objLimitDate.val() === "" ) {
				objLimitDate.val(objStartDate.val());
			} else if ( objLimitDate.val() < objStartDate.val() ) {
				objLimitDate.val(objStartDate.val());
			}
		}

		function fnGetMenu(field) {
			$.ajax(
				{	type: "POST"
				,	url: "?fnInitDrpMenu"
				,	data: "{menu_grp_no:"+ field.value +"}"
				,	contentType: "application/json; charset=utf-8"
				,	dataType: "json"
				,	success:function(msg) {
						alert(msg.d);
					}
				}
			);
		}

		// 클릭한 row highlight
		function fnSelectRow() {
			var vTxtMainNo = $(window.gComm + +"txtMainNo");
			$("m" + vTxtMainNo).attr("class", "selectedRow");
		}

		fnSelectRow();
	</script>
</asp:Content>
<asp:Content ContentPlaceHolderId="contents" runat="server">
	<!-- 검색 조건 입력 패널 -->
	<div id="content" class="col-lg-10 col-sm-10" style="margin-bottom:-15px;">
		<div class="breadcrumb">
			<div style="width:300px; display:inline-block;">
				<asp:Label EnableViewState="False" CssClass="cLabel" runat="server" meta:resourcekey="sh_lbl_Period" />
				<asp:TextBox id="txtStartDate" onfocus="fnCopyDate();" CssClass="cTextbox" MaxLength="10" Width="90px" runat="server"  />
				<img src="/_common/_images/_common/icn_calendar20.gif" onclick="Calendar_D('<%= txtStartDate.ClientID %>',1);" class="imgC" alt="" /> ~
				<asp:CompareValidator id="CompareValidator1" ControlToValidate="txtStartDate" Display="None" Operator="DataTypeCheck" Type="Date" ValidationGroup="vg_search" runat="server" />
				<asp:RequiredFieldValidator ControlToValidate="txtStartDate" Display="None" ValidationGroup="vg_search" runat="server" />
				<asp:TextBox id="txtLimitDate" onfocus="fnCopyDate();" CssClass="cTextbox" MaxLength="10" Width="90px" runat="server" />
				<img src="/_common/_images/_common/icn_calendar20.gif" onclick="Calendar_D('<%= txtLimitDate.ClientID %>',2);" class="imgC" alt="" />
				<asp:CompareValidator id="CompareValidator2" ControlToValidate="txtLimitDate" Display="None" Operator="DataTypeCheck" Type="Date" ValidationGroup="vg_search" runat="server" />
				<asp:RequiredFieldValidator ControlToValidate="txtLimitDate" Display="None" ValidationGroup="vg_search" runat="server" />
				<asp:HiddenField id="txtMainNo" runat="server" />
			</div>
			<div style="width:170px; display:inline-block;">
				<asp:Label EnableViewState="False" CssClass="cLabel" runat="server" meta:resourcekey="sh_lbl_AdminNo" />
				<asp:DropDownList id="drpAdmin" Width="100" CssClass="cDropDown" AppendDataBoundItems="True" runat="server">
					<asp:ListItem Value="0" meta:resourcekey="drpFilter_01" />
				</asp:DropDownList>
			</div>
			<div style="width:170px; display:inline-block;">
				<asp:Label EnableViewState="False" CssClass="cLabel" runat="server" meta:resourcekey="sh_lbl_MenuNo" />
				<asp:DropDownList id="drpMenu" Width="120" CssClass="cDropDown" AppendDataBoundItems="True" runat="server">
					<asp:ListItem Value="-1" meta:resourcekey="drpMenu_01" />
				</asp:DropDownList>
			</div>
			<div style="width:120px; display:inline-block;">
				<asp:Button id="btnSearch" onclick="btnSearch_Click" CssClass="cButton" EnableViewState="False" runat="server" meta:resourcekey="sh_btn_Search" />
				<asp:Button id="btnInit" onclick="btnInit_Click" CssClass="cButton" EnableViewState="False" runat="server" meta:resourcekey="sh_btn_Init" />
			</div>
		</div>
	</div>
	<!--//검색 조건 입력 패널 -->

	<!-- 관리자 작업 내역 -->
	<div id="pnGrid" class="box col-md-6" style="width:620px;" Visible="False" runat="server">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_02" />
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
					<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
						<td style="width:138px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_ipt_time" /></td>
						<td style="width:090px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_admin_id" /></td>
						<td><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_menu_nm" /></td>
						<td style="width:050px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_log_cd" /></td>
						<td style="width:090px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_ip_addr" /></td>
						<td style="width:050px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_select" /></td>
					</tr>
					<asp:Repeater id="repActionLog" OnItemCommand="repActionLog_OnItemCommand" runat="server">
						<ItemTemplate>
							<tr id="m<%# string.Format("{0:yyyyMMddHHmmss}", Eval("ipt_time")) %>" class="<%= fnRowStyle() %>" style="text-align:center;">
								<td>
									<asp:LinkButton CommandName="SELECT_DATE" runat="server">
										<asp:Literal id="ipt_time" Text='<%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("ipt_time")) %>' runat="server" />
									</asp:LinkButton>
								</td>
								<td>
									<asp:LinkButton CommandName="SELECT_ADMIN" runat="server">
										<asp:Literal id="admin_id" Text='<%# Eval("admin_id") %>' runat="server" />
									</asp:LinkButton>
								</td>
								<td>
									<asp:LinkButton CommandName="SELECT_MENU" runat="server">
										<asp:Literal id="menu_nm" Text='<%# Eval("menu_nm") %>' runat="server" />
									</asp:LinkButton>
								</td>
								<td><asp:Literal Text='<%# fnGetLogName(Eval("log_code")) %>' runat="server" /></td>
								<td><asp:Literal id="ip_addr" Text='<%# Eval("ip_addr") %>' runat="server" /></td>
								<td>
									<asp:LinkButton CommandName="SELECT" runat="server">
										<asp:Literal runat="server" meta:resourcekey="dg_select" />
									</asp:LinkButton>
									<asp:Literal id="menu_no" Text='<%# Eval("menu_no") %>' Visible="False" runat="server" />
									<asp:Literal id="admin_no" Text='<%# Eval("admin_no") %>' Visible="False" runat="server" />
									<asp:Literal id="log_code" Text='<%# Eval("log_code") %>' Visible="False" runat="server" />
									<asp:Literal id="note_desc" Text='<%# Eval("note_desc") %>' Visible="False" runat="server" />
									<asp:Literal id="http_params" Text='<%# Eval("http_params") %>' Visible="False" runat="server" />
								</td>
							</tr>
						</ItemTemplate>
					</asp:Repeater>
				</table>
			</div>
		</div>
	</div>
	<!--// 관리자 작업 내역 -->

	<!-- 선택된 관리자 작업 상세 정보 -->
	<div id="pnDetail" class="box col-md-6" style="width:505px;" Visible="False" runat="server">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9" EnableViewState="False" runat="server" meta:resourcekey="lbl_Title_03" />
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:450px; font-size:11px;">
					<tr>
						<td class="tbLayoutHeader" style="width:90px;">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_ipt_time" />
						</td>
						<td class="tbLayout" style="width:360px;">
							<asp:Literal id="litIptTime" EnableViewState="False" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_admin_id" />
						</td>
						<td class="tbLayout">
							<asp:Literal id="litAdminID" EnableViewState="False" runat="server" />
							<asp:Literal id="litAdminNo" EnableViewState="False" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_menu_nm" />
						</td>
						<td class="tbLayout">
							<asp:Literal id="litMenuName" EnableViewState="False" runat="server" />
							<asp:Literal id="litMenuNo" EnableViewState="False" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_log_cd" />
						</td>
						<td class="tbLayout">
							<asp:Literal id="litLogCDName" EnableViewState="False" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_ip_addr" />
						</td>
						<td class="tbLayout">
							<asp:Literal id="litIPAddr" EnableViewState="False" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_http_params" />
						</td>
						<td class="tbLayout">
							<div style="-moz-word-break:break-all; -o-word-break:break-all; word-break:break-all;">
								<asp:Literal id="litHttpParams" EnableViewState="False" runat="server" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_get_params" />
						</td>
						<td class="tbLayout">
							<table style="border-collapse:collapse; border:1px solid #ddd !important; width:100%;">
								<asp:Repeater id="rpGetParams" runat="server">
									<ItemTemplate>
										<tr>
											<td class="tbLayoutHeaderL"><%# Eval("cKey") %></td>
											<td class="tbLayout"><%# Eval("cValue") %></td>
										</tr>
									</ItemTemplate>
								</asp:Repeater>
							</table>
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_post_params" />
						</td>
						<td class="tbLayout">
							<table style="border-collapse:collapse; border:1px solid #ddd !important; width:100%;">
								<asp:Repeater id="rpPostParams" runat="server">
									<ItemTemplate>
										<tr>
											<td class="tbLayoutHeaderL"><%# Eval("cKey") %></td>
											<td class="tbLayout"><%# Eval("cValue") %></td>
										</tr>
									</ItemTemplate>
								</asp:Repeater>
							</table>
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_lbl_note_desc" />
						</td>
						<td class="tbLayout">
							<div style="max-height:100px; -moz-word-break:break-all; -o-word-break:break-all; word-break:break-all;">
								<asp:Literal id="litNoteDesc" EnableViewState="False" runat="server" />
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--// 선택된 관리자 작업 상세 정보 -->


</asp:Content>
