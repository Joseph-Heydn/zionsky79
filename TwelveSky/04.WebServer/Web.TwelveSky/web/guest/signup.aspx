<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="signup.aspx.cs"
	Inherits="Web.TwelveSky.web.guest.signup"
%>
<%@ Register
	Src="/App_Common/ucCaptcha.ascx"
	TagName="ucCaptcha"
	TagPrefix="uc1"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gMessage =
			{	Error_01 : "<%= fnLabelText("msgError_02") %>"
			,	Error_02 : "<%= fnLabelText("msgError_03") %>"
			,	Error_03 : "<%= fnLabelText("msgError_04") %>"
			,	Error_04 : "<%= fnLabelText("msgError_05") %>"
			,	Error_05 : "<%= fnLabelText("msgError_06") %>"
			,	Error_06 : "<%= fnLabelText("msgError_07") %>"
			,	Error_07 : "<%= fnLabelText("msgError_08") %>"
			,	Error_08 : "<%= fnLabelText("msgError_09") %>"
			,	Error_09 : "<%= fnLabelText("msgError_10") %>"
			,	Error_10 : "<%= fnLabelText("msgError_11") %>"
			,	Error_11 : "<%= fnLabelText("msgError_12") %>"
			,	Error_12 : "<%= fnLabelText("msgError_13") %>"
			,	Error_13 : "<%= fnLabelText("msgError_14") %>"
			,	Error_14 : "<%= fnLabelText("msgError_15") %>"
			,	Error_15 : "<%= fnLabelText("msgError_16") %>"
			,	Error_16 : "<%= fnLabelText("msgError_17") %>"
			,	Error_17 : "<%= fnLabelText("msgError_18") %>"
			,	Error_18 : "<%= fnLabelText("msgError_19") %>"
			,	Error_19 : "<%= fnLabelText("msgError_20") %>"
			};
	</script>

	<script type="text/javascript" src="/_common/_js/web/signup.js"></script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<!-- content -->
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<%= fnMenuText("Home") %> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="txtAccountCheck" Value="N" runat="server"/>
			<asp:HiddenField id="txtNickCheck" Value="N" runat="server"/>
			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
				<!--ERROR-->
				<div id="formCheckMsg" class="message_box marB_10" style="display:none;">error message</div>
				<!--//ERROR-->
				<table class="C_table01" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:35%;"/>
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
								<span id="AccountIdCheckImg"></span>
								<p id="AccountIdCheck" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblEmail2"/>
							</th>
							<td>
								<asp:TextBox id="txtAccountId2" Width="240" runat="server"/>
								<span id="AccountIdCheckOkImg"></span>
								<p id="AccountIdCheckOk" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblPassword"/>
							</th>
							<td>
								<asp:TextBox id="txtPassword" TextMode="Password" Width="240" runat="server"/>
								<span id="PasswordCheckImg"></span>
								<p id="PasswordCheck" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblPassword2"/>
							</th>
							<td>
								<asp:TextBox id="txtPassword2" TextMode="Password" Width="240" runat="server"/>
								<span id="PasswordCheckOkImg"></span>
								<p id="PasswordCheckOk" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblSecurity"/>
							</th>
							<td>
								<asp:TextBox id="txtSecurityEmail" Width="240" MaxLength="40" runat="server"/>
								<span id="SecurityEmailCheckImg"></span>
								<p id="SecurityEmailCheck" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblNickName"/>
							</th>
							<td>
								<asp:TextBox id="txtNickName" Width="240" runat="server"/>
								<span id="NickNameCheckImg"></span>
								<p id="NickNameCheck" class="en_comment" style="display:none;"></p>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="height:15px;">
								<p class="txt_type01 marT_10" style="color:Red;font-size:15px;">
									<strong><asp:Literal runat="server" meta:resourcekey="lblSecEmail_01"/></strong>
									<asp:Literal runat="server" meta:resourcekey="lblSecEmail_02"/>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //entry_table -->
			</div>

			<div class="con_text">
				<ul>
					<li>
						<label>
							<input type="checkbox" id="chkIsAgree" name="IsAgree" value="Y" class="check" style="margin: 0 5px 0 0;"/>
							<asp:Literal runat="server" meta:resourcekey="lblChkAgree_01"/>
							<a href="javascript:fnPolicyPop(18);" title="Terms of Use" target="_blank">
								<asp:Literal runat="server" meta:resourcekey="lblTerms"/>
							</a>
							<asp:Literal runat="server" meta:resourcekey="lblChkAgree_02"/>
							<a href="javascript:fnPolicyPop(19);" title="Privacy Policy" target="_blank">
								<asp:Literal runat="server" meta:resourcekey="lblPrivacy"/>.
							</a>
						</label>
					</li>
					<li>
						<label>
							<asp:CheckBox id="chkIsEmailOk" Checked="true" CssClass="check" style="margin: 0 5px 0 0;" runat="server"/>
							<asp:Literal runat="server" meta:resourcekey="lblReceiveMail"/>
						</label>
					</li>
				</ul>
			</div>

			<!-- security string -->
			<uc1:ucCaptcha runat="server"/>

			<p class="t_center">
				<span class="btn_type">
					<asp:LinkButton OnClientClick="return fnCheckForm();" OnClick="btnSignUp_Click" runat="server" meta:resourcekey="lblContinue"/>
				</span>&nbsp;
				<span class="btn_type">
					<a href="javascript:history.back();"><asp:Literal runat="server" meta:resourcekey="lblCancel"/></a>
				</span>
			</p>
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
