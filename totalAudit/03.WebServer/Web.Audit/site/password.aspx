<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="password.aspx.cs"
	Inherits="Web.Audit.site.password"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
	<!--
		function fnSubInfo_check() {
			if ( $("#<%= txtPassWd.ClientID %>").val().replace(/\s/g,"").length < 1 ) {
				alert("<%= fnLabelText("ltl_PassMsg_1")%>");
				return false;
			} else if ( $("#<%= txtPassWdChange.ClientID %>").val().replace(/\s/g,"").length < 1 ) {
				alert("<%= fnLabelText("ltl_PassMsg_2")%>");
				return false;
			} else if ( $("#<%= txtPassWdChange.ClientID %>").val() !== $("#<%= txtPassWdChangeCheck.ClientID %>").val() ) {
				alert("<%= fnLabelText("ltl_PassMsg_3")%>");
				return false;
			}

			return true;
		}
	//-->
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div class="box col-md-6" style="width:515px; margin-top:0; display:inline-block;">
		<div class="box-inner">
			<!-- 게시판 기본정보 -->
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title1" />
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:100%; font-size:9pt;">
					<tr>
						<td class="tbLayoutHeader" style="width:140px;">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_PassWD" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtPassWd" TextMode="Password" MaxLength="20" Width="280px" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_PassWDChange" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtPassWdChange" TextMode="Password" MaxLength="20" Width="280px" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_PassWDCheck" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtPassWdChangeCheck" TextMode="Password" MaxLength="20" Width="280px" runat="server" />
						</td>
					</tr>
				</table>

				<div style="margin:-8px 0 5px 200px;">
					<asp:Button OnCommand="btnUpdate_Click" OnClientClick="return fnSubInfo_check();" CssClass="button" Height="25px" Width="100px" runat="server" meta:resourcekey="btnUpdate" />
				</div>
			</div>
		</div>
	</div>
</asp:Content>
