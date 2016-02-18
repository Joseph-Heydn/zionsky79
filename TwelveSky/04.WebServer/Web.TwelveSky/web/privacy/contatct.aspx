<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	ValidateRequest="false"
	EnableEventValidation="false"
	CodeBehind="contatct.aspx.cs"
	Inherits="Web.TwelveSky.web.privacy.contatct"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript">
		var gMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Alert_05 : "<%= fnLabelText("msgAlert_05") %>"
			,	Alert_09 : "<%= fnLabelText("msgAlert_09") %>"
			,	Alert_10 : "<%= fnLabelText("msgAlert_10") %>"
			};
	</script>
	
	<script type="text/javascript" charset="utf-8" src="/_common/_js/web/write.js"></script>
	<script type="text/javascript" charset="utf-8" src="/_common/_js/web/contatct.js"></script>
	<script type="text/javascript" charset="utf-8" src="/_common/_tinymce/tinymce.min.js"></script>
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

			<asp:HiddenField id="txtRawFiles" runat="server"/>
			<asp:HiddenField id="txtNewFiles" runat="server"/>
			<asp:HiddenField id="txtFileExts" runat="server"/>
			<asp:HiddenField id="txtFileSize" runat="server"/>
			<asp:HiddenField id="txtAllFiles" runat="server"/>
			<asp:HiddenField id="txtFileList" runat="server"/>
			<asp:HiddenField id="txtOnlyText" runat="server"/>

			<asp:HiddenField id="txtCategoryL" runat="server"/>
			<asp:HiddenField id="txtCategoryM" runat="server"/>

			<asp:HiddenField id="pMenu" runat="server"/>
		</div>

		<div class="content_page">
			<div class="con_table">
				<table class="C_table01" style="border-spacing:0; padding:0;">
					<colgroup>
						<col style="width:110px;"/>
						<col/>
					</colgroup>
					<tbody>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblCategory"/>
							</th>
							<td>
								<asp:DropDownList id="drpLarge" onchange="fnSetCategoryM(this.value);" runat="server"/>
								<asp:DropDownList id="drpDetail" runat="server"/>
							</td>
						</tr>
						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblNickName"/>
							</th>
							<td>
								<asp:TextBox id="txtNickName" Width="240" runat="server"/>
							</td>
						</tr>

						<tr>
							<th class="b_none">
								<span class="red_02">*</span>
								<asp:Literal runat="server" meta:resourcekey="lblSubject"/>
							</th>
							<td>
								<asp:TextBox id="txtSubjects" Width="400" MaxLength="100" runat="server"/>
								<asp:Literal runat="server" meta:resourcekey="lblMaxChar"/>
							</td>
						</tr>

						<tr>
							<td colspan="2"><asp:TextBox id="txtContents" Width="100%" Height="350" runat="server"/></td>
						</tr>
						<tr>
							<th class="b_none"><asp:Literal runat="server" meta:resourcekey="lblAttach"/></th>
							<td>
								<div style="width:75px; height:70px; display:inline-block;">
									<img id="imgAttachFile" src="/_common/_images/logo20.png" style="width:70px; height:70px; border:1px solid gray;" alt=""/>
								</div>
								<div style="width:320px; height:71px; display:inline-block;">
									<input type="file" id="txtAttachFile" multiple="multiple" accept="image/*" style="width:0; display:none;"/>
									<input type="button" id="btnFileUp" style="width:0; display:none;" value="upload file"/>
									<asp:ListBox id="lstAttachList" SelectionMode="Multiple" onclick="fnPreviewImage(this);" Width="100%" Height="71" runat="server"/>
								</div>
								<div class="btn" style="width:145px; height:71px; margin-top:-71px;">
									<ul>
										<li>
											<a href="javascript:;" id="btnAttachFile">
												<asp:Literal runat="server" meta:resourcekey="lblFileUp"/>
											</a>
										</li>
										<li>
											<a href="javascript:fnDeleteImage();">
												<asp:Literal runat="server" meta:resourcekey="lblDrop"/>
											</a>
										</li>
										<br/>
										<li style="margin-top:5px;">
											<a href="javascript:fnSetImage2Document();">
												<asp:Literal runat="server" meta:resourcekey="lblDocument"/>
											</a>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<p class="t_center01">
				<asp:Literal runat="server" meta:resourcekey="lblLimitSize"/>
			</p>
			<div class="message01">
				<div id="checkMessage" class="message" style="display:none;"></div>
			</div>

			<p class="t_center">
				<span class="btn_type">
					<asp:LinkButton OnClientClick="return fnCheckForm();" OnClick="btnSave_Click" runat="server" meta:resourcekey="btnSave"/>
				</span>
			</p>
		</div>
		<!-- content_page -->

		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top"/></a>
		</div>
	</div>
</asp:Content>
