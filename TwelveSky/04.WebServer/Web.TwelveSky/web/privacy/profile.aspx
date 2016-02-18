<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="profile.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.profile"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Alert_05 : "<%= fnLabelText("msgAlert_05") %>"
			,	Alert_06 : "<%= fnLabelText("msgAlert_06") %>"
			,	Alert_07 : "<%= fnLabelText("msgAlert_07") %>"
			};
		var gFileNo = "<%= AuthInfo.pAccountNo %>";
	</script>

	<script type="text/javascript" src="/_common/_js/web/profile.js" charset="utf-8"></script>
</asp:Content>

<asp:Content  ContentPlaceHolderId="cpContents" runat="server">
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<%= fnMenuText("Home") %> &gt;
				<asp:Literal id="lblGroup" runat="server"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="txtFileExts" runat="server"/>
			<asp:HiddenField id="txtImageFile" runat="server"/>
			<asp:HiddenField id="txtNickOrgnl" runat="server"/>
			<asp:HiddenField id="txtNickCheck" Value="N" runat="server"/>
			<asp:HiddenField id="txtBirthDay" runat="server"/>
			<asp:HiddenField id="txtCheckImg" Value="N" runat="server"/>
			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<!--ERROR-->
			<div class="message_box" id="formCheckText" style="display:none;">
				error message
			</div>
			<!--//ERROR-->
			<div class="profile">
				<div class="edit_img">
					<ul>
						<li class="profile_img">
							<asp:Image id="imgProfile" Width="200" Height="200" runat="server"/>
						</li>
						<li class="file">
							<input type="file" id="txtAttachFile" accept="image/*" style="width:400px;"/>
							<input type="button" id="btnFileUp" style="width:0; display:none;" value="upload file"/>
						</li>
						<li class="profile_text">
							<asp:Literal runat="server" meta:resourcekey="lblConPage_01"/>
						</li>
						<li>
							<span class="del_img">
								<asp:CheckBox id="chkDeleteImage" onclick="return fnDropImage();" runat="server" meta:resourcekey="lblConPage_02"/>
							</span>
						</li>
					</ul>
				</div>
				<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
					<table class="C_table01" style="border-spacing:0; padding:0;">
						<colgroup>
							<col style="width:30%;"/>
							<col/>
						</colgroup>
						<tbody>
							<tr>
								<th class="b_none">
									<span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblConPage_03"/>
								</th>
								<td>
									<asp:TextBox id="txtNickName" Width="240" runat="server"/>
									<span id="NicknameCheckImg"></span>
									<p class="en_comment" id="NicknameCheck" style="display:none;"></p>
								</td>
							</tr>
							<tr>
								<th class="b_none"><span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblConPage_04"/>
								</th>
								<td>
									<asp:RadioButtonList id="rdoGender" RepeatDirection="Horizontal" runat="server">
										<asp:ListItem Value="1" meta:resourcekey="lblConPage_05"/>
										<asp:ListItem Value="2" meta:resourcekey="lblConPage_06"/>
									</asp:RadioButtonList>
								</td>
							</tr>
							<tr>
								<th class="b_none"><span class="red_02">*</span>
									<asp:Literal runat="server" meta:resourcekey="lblConPage_07"/>
								</th>
								<td>
									<asp:DropDownList id="drpYear" runat="server" Width="100"/>
									<asp:DropDownList id="drpMonth" runat="server" Width="70"/>
									<asp:DropDownList id="drpDay" runat="server" Width="70"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- profile -->

			<p class="t_center">
				<asp:CheckBox id="chkReceiveMail" runat="server" meta:resourcekey="lblConPage_08"/>
			</p>
			<p class="t_center">
				<span class="btn_type" id="SaveButton">
					<asp:LinkButton OnClientClick="return fnCheckForm();" OnClick="btnSave_Click" ToolTip="save" runat="server" meta:resourcekey="lblConPage_09"/>
				</span>
			</p>
		</div>
	</div>
</asp:Content>
