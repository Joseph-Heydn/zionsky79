<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="findPass.aspx.cs"
	Inherits="Web.TwelveSky.web.guest.findPass"
%>
<%@ Register
	Src="/App_Common/ucCaptcha.ascx"
	TagName="ucCaptcha"
	TagPrefix="uc1"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gCheckMsg = $("#CheckMessage");
		var txtAccountId = $("#<%= txtAccountId.ClientID %>");

		function fnCheckForm() {
			if ( txtAccountId.val().length < 5 ) {
				gCheckMsg.show();
				return false;
			}

			gCheckMsg.hide();
			return true;
		}
	</script>
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

			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<div class="content_page">
			<div id="CheckMessage" class="message_box" style="display:none;">
				<asp:Literal runat="server" meta:resourcekey="lblInputEmail"/>
			</div>
			<div class="con_text">
				<ul>
					<li><asp:Literal runat="server" meta:resourcekey="lblLoginInfo"/></li>
				</ul>
			</div>
			<div class="profile">
				<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
					<table class="C_table01" style="border-spacing:0; padding:0;">
						<colgroup>
							<col style="width:30%;"/>
							<col/>
						</colgroup>
						<tbody>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span><asp:Literal runat="server" meta:resourcekey="lblEmailAddr"/>
								</th>
								<td>
									<asp:TextBox id="txtAccountId" runat="server" Width="240"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<!-- security string -->
			<uc1:ucCaptcha runat="server"/>

			<p class="t_center">
				<span class="btn_type" id="ModifyButton">
					<asp:LinkButton OnClientClick="return fnCheckForm();" OnClick="btnFindPassword_Click" runat="server" meta:resourcekey="lblSendEmail"/>
				</span>
			</p>
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
