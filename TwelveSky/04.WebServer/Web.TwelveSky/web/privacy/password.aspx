<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="password.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.password"
%>
<%@ Register
	Src="/App_Common/ucCaptcha.ascx"
	TagName="ucCaptcha"
	TagPrefix="uc1"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var vMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Alert_05 : "<%= fnLabelText("msgAlert_05") %>"
			,	Alert_06 : "<%= fnLabelText("msgAlert_06") %>"
			,	Alert_07 : "<%= fnLabelText("msgAlert_07") %>"
			,	Alert_08 : "<%= fnLabelText("msgAlert_08") %>"
			,	Alert_09 : "<%= fnLabelText("msgAlert_09") %>"
			,	Alert_10 : "<%= fnLabelText("msgAlert_10") %>"
			};
	</script>

	<script type="text/javascript" src="/_common/_js/web/password.js" charset="utf-8"></script>
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
			<div class="message_box" id="CheckMessage" style="display:none;">
				<%= fnLabelText("msgAlert_04") %>
			</div>
			<div class="con_text">
				<ul>
					<li><asp:Literal runat="server" meta:resourcekey="lblConPage_01"/></li>
				</ul>
			</div>
			<div class="profile">
				<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
					<table class="C_table01" style="border-spacing:0; padding:0;">
						<caption></caption>
						<colgroup>
							<col style="width:30%;"/>
							<col/>
						</colgroup>
						<tbody>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblEmail"/>
								</th>
								<td>
									<asp:TextBox id="txtAccountId" Width="240" runat="server"/>
								</td>
							</tr>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblPassword"/>
								</th>
								<td>
									<asp:TextBox id="txtPassword" TextMode="Password" Width="240" runat="server"/>
								</td>
							</tr>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblNewPassword"/>
								</th>
								<td>
									<asp:TextBox id="txtNewPassword" TextMode="Password" Width="240" runat="server"/>
								</td>
							</tr>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblConfirmPass"/>
								</th>
								<td>
									<asp:TextBox id="txtConfirmPass" TextMode="Password" Width="240" runat="server"/>
								</td>
								</tr>
						</tbody>
					</table>
				</div>
			</div>

			<!-- security string -->
			<uc1:ucCaptcha runat="server"/>

			<p class="t_center">
				<span class="btn_type">
					<asp:LinkButton OnClientClick="return fnCheckForm();" OnClick="btnModifyPassword_OnClick" runat="server" meta:resourcekey="btnSave"/>
				</span>
			</p>
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
