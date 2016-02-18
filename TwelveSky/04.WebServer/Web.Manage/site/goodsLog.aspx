<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="goodsLog.aspx.cs"
	Inherits="Web.Manage.site.goodsLog"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		$(document).ready(function() {
			fnSelectRow();
		});


		function fnCopyDate() {
			var objStartDate = $("#<%= txtStartDate.ClientID %>");
			var objEndDate =$("#<%= txtLimitDate.ClientID %>");

			if ( objEndDate.val() === "" ) {
				objEndDate.val(objStartDate.val());
			} else if ( objEndDate.val() < objStartDate.val() ) {
				objEndDate.val(objStartDate.val());
			}
		}

		// 클릭한 row highlight
		function fnSelectRow() {
			var txtMainNo = $("#<%= txtMainNo.ClientID %>");
			$("#m"+ txtMainNo.val()).attr("class", "selectedRow");
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<!-- 검색 조건 입력 패널 -->
	<div class="col-lg-10 col-sm-10" style="margin-bottom:-15px;">
		<div class="breadcrumb">
			<div style="width:300px; display:inline-block;">
				<asp:Label CssClass="cLabel" EnableViewState="False" runat="server" meta:resourcekey="sh_lbl_Period"/>
				<asp:TextBox id="txtStartDate" onfocus="fnCopyDate();" CssClass="cTextbox" MaxLength="10" Width="90px" runat="server"/>
				<img src="/_common/_images/icn_calendar20.gif" onclick="Calendar_D('<%= txtStartDate.ClientID %>',1);" class="imgC" alt=""/> ~
				<asp:CompareValidator id="CompareValidator1" ControlToValidate="txtStartDate" Display="None" Operator="DataTypeCheck" Type="Date" ValidationGroup="vg_search" runat="server"/>
				<asp:RequiredFieldValidator ControlToValidate="txtStartDate" Display="None" ValidationGroup="vg_search" runat="server"/>
				<asp:TextBox id="txtLimitDate" onfocus="fnCopyDate();" CssClass="cTextbox" MaxLength="10" Width="90px" runat="server"/>
				<img src="/_common/_images/icn_calendar20.gif" onclick="Calendar_D('<%= txtLimitDate.ClientID %>',2);" class="imgC" alt=""/>
				<asp:CompareValidator id="CompareValidator2" ControlToValidate="txtLimitDate" Display="None" Operator="DataTypeCheck" Type="Date" ValidationGroup="vg_search" runat="server"/>
				<asp:RequiredFieldValidator ControlToValidate="txtLimitDate" Display="None" ValidationGroup="vg_search" runat="server"/>
				<asp:HiddenField id="txtMainNo" runat="server"/>
			</div>
			<div style="width:170px; display:inline-block;">
				<asp:Label CssClass="cLabel" EnableViewState="False" runat="server" meta:resourcekey="sh_lbl_AdminNo"/>
				<asp:DropDownList id="drpAdmin" Width="100" CssClass="cDropDown" AppendDataBoundItems="True" runat="server">
					<asp:ListItem Value="0" meta:resourcekey="drpFilter_01"/>
				</asp:DropDownList>
			</div>
			<div style="width:180px; display:inline-block;">
				<asp:Label CssClass="cLabel" EnableViewState="False" runat="server" meta:resourcekey="sh_lbl_action_nm"/>
				<asp:DropDownList id="drpAction" Width="100" CssClass="cDropDown" AppendDataBoundItems="True" runat="server">
					<asp:ListItem Value="0" meta:resourcekey="drpFilter_01"/>
				</asp:DropDownList>
			</div>
			<div style="width:120px; display:inline-block;">
				<asp:Button OnClick="btnSearch_Click" CssClass="cButton" EnableViewState="False" runat="server" meta:resourcekey="sh_btnSearch"/>
				<asp:Button OnClick="btnInit_Click" CssClass="cButton" EnableViewState="False" runat="server" meta:resourcekey="sh_btnInit"/>
			</div>
		</div>
	</div>
	<!--//검색 조건 입력 패널 -->

	<!-- 관리자 작업 내역 -->
	<div id="pnGrid" class="box col-md-6" style="width:740px;" Visible="False" runat="server">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9" EnableViewState="False" runat="server" meta:resourcekey="lbl_GridTitle"/>
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; font-size:9pt;">
					<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
						<td style="width:138px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_ipt_time"/></td>
						<td style="width:050px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_server_no"/></td>
						<td style="width:080px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_account_nm"/></td>
						<td><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_action_nm"/></td>
						<td style="width:060px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_values_old"/></td>
						<td style="width:060px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_values_new"/></td>
						<td style="width:070px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_admin_id"/></td>
						<td style="width:050px;"><asp:Literal EnableViewState="False" runat="server" meta:resourcekey="dg_select"/></td>
					</tr>
<asp:Repeater id="repActionLog" OnItemCommand="repActionLog_OnItemCommand" runat="server">
	<ItemTemplate>
					<tr id="m<%# string.Format("{0:yyyyMMddHHmmss}", Eval("ipt_time")) %>" class="<%= fnRowStyle() %>" style="text-align:center;">
						<td>
							<asp:LinkButton CommandName="SELECT_DATE" runat="server">
								<asp:Literal id="ipt_time" Text='<%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("ipt_time")) %>' runat="server"/>
							</asp:LinkButton>
						</td>
						<td><asp:Literal id="server_no" Text='<%# Eval("server_no") %>' runat="server"/></td>
						<td><asp:Literal id="nick_name" Text='<%# Eval("nick_name") %>' runat="server"/></td>
						<td><asp:Literal id="action_nm" Text='<%# fnGetActionName(Eval("action_no")) %>' runat="server"/></td>
						<td><asp:Literal id="values_old" Text='<%# string.Format("{0:n0}", Eval("values_old")) %>' runat="server"/></td>
						<td><asp:Literal id="values_new" Text='<%# string.Format("{0:n0}", Eval("values_new")) %>' runat="server"/></td>
						<td>
							<asp:LinkButton CommandName="SELECT_ADMIN" runat="server">
								<asp:Literal id="admin_id" Text='<%# Eval("admin_id") %>' runat="server"/>
							</asp:LinkButton>
						</td>
						<td>
							<asp:LinkButton CommandName="SELECT" runat="server">
								<asp:Literal runat="server" meta:resourcekey="dg_select"/>
							</asp:LinkButton>
							<asp:Literal id="admin_no" Text='<%# Eval("admin_no") %>' Visible="False" runat="server"/>
							<asp:Literal id="account_no" Text='<%# Eval("account_no") %>' Visible="False" runat="server"/>
							<asp:Literal id="publish_no" Text='<%# Eval("publish_no") %>' Visible="False" runat="server"/>
							<asp:Literal id="mail_no" Text='<%# Eval("mail_no") %>' Visible="False" runat="server"/>
							<asp:Literal id="action_no" Text='<%# Eval("action_no") %>' Visible="False" runat="server"/>
							<asp:Literal id="try_cnt" Text='<%# Eval("try_cnt") %>' Visible="False" runat="server"/>
							<asp:Literal id="ip_addr" Text='<%# Eval("ip_addr") %>' Visible="False" runat="server"/>
							<asp:Literal id="upt_time" Text='<%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("upt_time")) %>' Visible="False" runat="server"/>
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
	<div id="pnDetail" class="box col-md-6" style="width:410px;" Visible="False" runat="server">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9" EnableViewState="False" runat="server" meta:resourcekey="lbl_DetailTitle"/>
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:350px; font-size:11px;">
					<tr>
						<td class="tbLayoutHeaderF" style="width:120px;">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_ipt_time"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litIptTime" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_server_no"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litServerNo" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_nick_name"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litNickName" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_account_no"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litAccountNo" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_publish_no"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litPublishNo" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_action_name"/>
						</td>
						<td class="tbLayout">
							<asp:Literal id="litActionName" EnableViewState="False" runat="server"/>
							(<asp:Literal id="litActionNo" EnableViewState="False" runat="server"/>)
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_values_new"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litValuesNew" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_values_old"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litValuesOld" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_admin_id"/>
						</td>
						<td class="tbLayout">
							<asp:Literal id="litAdminId" EnableViewState="False" runat="server"/>
							(<asp:Literal id="litAdminNo" EnableViewState="False" runat="server"/>)
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_mail_no"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litMailNo" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_try_cnt"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litTryCnt" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_ip_addr"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litIPAddr" EnableViewState="False" runat="server"/></td>
					</tr>
					<tr>
						<td class="tbLayoutHeaderF">
							<asp:Localize EnableViewState="False" runat="server" meta:resourcekey="tx_upt_time"/>
						</td>
						<td class="tbLayout"><asp:Literal id="litUptTime" EnableViewState="False" runat="server"/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 선택된 관리자 작업 상세 정보 -->
</asp:Content>
