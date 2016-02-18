<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	CodeBehind="encryptTest.aspx.cs"
	Inherits="Web.Audit.site.encryptTest"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		function fnSubinfo_check() {
			if ( $(window.gComm +"txtUserId").val().replace(/\s/g, "").length < 1 ) {
				return alert("<%= fnLabelText("ltl_PassMsg1")%>");
			} else if ( $(window.gComm +"txtPassWd").val().replace(/\s/g, "").length < 1 ) {
				return alert("<%= fnLabelText("ltl_PassMsg2")%>");
			}

			return true;
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div class="box col-md-6" style="width:515px; margin-top:0; display:inline-block;">
		<div class="box-inner">
			<!-- 게시판 기본정보 -->
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list-alt"></i>
					<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lbl_Title" />
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered" style="width:100%; font-size:9pt;">
					<tr>
						<td class="tbLayoutHeader" style="width:110px;">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_ID" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtUserId" runat="server" MaxLength="20" Width="310px" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_PWD" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtPassWd" MaxLength="20" Width="310px" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tbLayoutHeader">
							&nbsp;<asp:Literal EnableViewState="False" runat="server" meta:resourcekey="lbl_MD5Hash" />
						</td>
						<td class="tbLayout">
							&nbsp;
							<asp:TextBox id="txtMD5Hash" ReadOnly="true" MaxLength="20" Width="310px" runat="server" />
						</td>
					</tr>
				</table>

				<div style="margin:-8px 0 5px 200px;">
					<asp:Button OnCommand="btnUpdate_Click" OnClientClick="return fnSubinfo_check();" CssClass="cButton" Height="25px" Width="100px" runat="server" meta:resourcekey="btn_Update" />
				</div>
			</div>
		</div>
	</div>
</asp:Content>
