<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	ValidateRequest="false"
	EnableEventValidation="false"
	CodeBehind="write.aspx.cs"
	Inherits="Web.TwelveSky.web.board.write"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript" src="/_common/_js/write.js" charset="utf-8"></script>
	<script type="text/javascript" src="/_common/_tinymce/tinymce.min.js" charset="utf-8"></script>

	<script type="text/javascript">
		var gObjectId = {
				txtRawFiles		: $("#<%= txtRawFiles.ClientID %>")
			,	txtNewFiles		: $("#<%= txtNewFiles.ClientID %>")
			,	txtFileExts		: $("#<%= txtFileExts.ClientID %>")
			,	txtFileSize		: $("#<%= txtFileSize.ClientID %>")
			,	txtAllFiles		: $("#<%= txtAllFiles.ClientID %>")
			,	txtFileList		: $("#<%= txtFileList.ClientID %>")
			,	txtSubjects		: $("#<%= txtSubjects.ClientID %>")
			,	txtContents		: $("#<%= txtContents.ClientID %>")
			,	txtOnlyText		: $("#<%= txtOnlyText.ClientID %>")
			,	lstAttachList	: "#<%= lstAttachList.ClientID %>"
			,	txtContents2	: "<%= txtContents.ClientID %>"
			,	txtContents3	: "#<%= txtContents.ClientID %>"
			};
		var pReturn = $("#<%= pReturn.ClientID %>").val();
		var gMessage = {
				Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			};
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<!-- content -->
	<div id="contents">
		<div class="con_top">
			<div class="nav_hint">
				<asp:Literal runat="server" meta:resourcekey="lblHome"/> &gt;
				<asp:Literal id="lblGroup" runat="server"/> &gt;
				<asp:Label id="lblNavTitle" CssClass="now" runat="server"/>
			</div>
			<div class="page_tit"><asp:Literal id="lblPageTitle" runat="server"/></div>

			<asp:HiddenField id="txtIsModify" runat="server"/>
			<asp:HiddenField id="txtRawFiles" runat="server"/>
			<asp:HiddenField id="txtNewFiles" runat="server"/>
			<asp:HiddenField id="txtFileExts" runat="server"/>
			<asp:HiddenField id="txtFileSize" runat="server"/>
			<asp:HiddenField id="txtAllFiles" runat="server"/>
			<asp:HiddenField id="txtFileList" runat="server"/>
			<asp:HiddenField id="txtOnlyText" runat="server"/>

			<asp:HiddenField id="pReturn" runat="server"/>
			<asp:HiddenField id="pMenu" runat="server"/>
			<asp:HiddenField id="pWrite" runat="server"/>
			<asp:HiddenField id="pKey" runat="server"/>
			<asp:HiddenField id="pTxt" runat="server"/>
		</div>

		<!-- contents start -->
		<div class="content_page">
			<div class="con_table">
				<table class="N_table" style="border-spacing:0; padding:0; margin-top:-20px;">
					<tbody>
						<tr>
							<th style="width:70px;"><asp:Literal runat="server" meta:resourcekey="lblSubject"/></th>
							<td>
								<asp:TextBox id="txtSubjects" runat="server" Width="400" MaxLength="100"/>
								<asp:Literal runat="server" meta:resourcekey="lblMaxChar"/>
							</td>
						</tr>
						<tr>
							<!--th><asp:Literal runat="server" meta:resourcekey="lblContents"/></th-->
							<td colspan="2"><asp:TextBox id="txtContents" Height="350" runat="server"/></td>
						</tr>
						<tr>
							<th><asp:Literal runat="server" meta:resourcekey="lblAttach"/></th>
							<td id="tdFiles" runat="server">
								<div style="width:75px; height:70px; display:inline-block;">
									<img id="imgAttachFile" src="/_common/_images/logo20.png" style="width:70px; height:70px; border:1px solid gray;" alt=""/>
								</div>
								<div style="width:350px; height:71px; display:inline-block;">
									<input type="file" id="txtAttachFile" multiple="multiple" accept="image/*" style="width:0; display:none;"/>
									<input type="button" id="btnUpload" style="width:0; display:none;" value="upload file"/>
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
							<td id="tdMovie" Visible="False" runat="server">
								<asp:TextBox id="txtYoutube" Width="100%" runat="server"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn">
				<ul>
					<li id="liDropThis" runat="server">
						<asp:LinkButton id="btnDrop" OnClientClick="return fnDropArticle();" OnClick="btnDrop_Click" Visible="False" runat="server" meta:resourcekey="btnDrop"/>
					</li>
					<li>
						<asp:LinkButton OnClientClick="return fnGetContents();" OnClick="btnSave_Click" runat="server" meta:resourcekey="btnSave"/>
					</li>
					<li>
						<a href="javascript:fnList();">
							<asp:Literal runat="server" meta:resourcekey="btnList"/>
						</a>
					</li>
				</ul>
			</div>

			<asp:LinkButton onclick="btnSave_Click" runat="server"/>
		</div>
		<div class="page_top">
			<a href="#"><img src="/_common/_images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
		</div>
	</div>
</asp:Content>
