<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="video_e.aspx.cs" Inherits="_12sky2.admin.media.video_e" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Twelvesky2 - Admin Page</title>
<common:layout id="common" runat="server"/>
</head>

<body>
<form id="form1" runat="server">
	<%--<div id="main_bg">--%>
	<div>
		<div id="wrap">
			<admin_head:layout id="admin_head" runat="server"/>

			<div id="C_container">

				<!-- left menu -->
				<admin_left:layout id="admin_left" runat="server" setTITL="Media"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; Media &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">

					<script type="text/javascript">

						function proc_save() {
							var str = escape(CKEDITOR.instances.CNTN.getData());
							save(str);
						}

						function save(str) {
							if (!check_field("TITL", "Please input to Title!")) return;
							if (!check_field("PATH", "Please input to Movie Url!")) return;

							$("#_title").val($("#TITL").val());
							$("#_contents").val(str);
							$("#FILE_SEQ").val($("#_fileList").val());

							__doPostBack('btn_save', '');
						}
					</script>

					<asp:ScriptManager id="ScriptManager1" runat="server">
					</asp:ScriptManager>

					<asp:UpdatePanel id="UpdatePanel1" runat="server">
					<ContentTemplate>
					</ContentTemplate>
					</asp:UpdatePanel>

					<asp:HiddenField id="_fileList" runat="server"/>
					<asp:HiddenField id="FILE_SEQ" runat="server"/>
					<asp:HiddenField id="DEL_FILE_SEQ" runat="server"/>
					<asp:HiddenField id="_title" runat="server"/>
					<asp:HiddenField id="_contents" runat="server"/>

					<div class="con_table">
						<table cellspacing="0" cellpadding="0" class="N_table">
							<tbody>
								<tr>
									<td>Title</td>
									<td>
										<asp:TextBox id="TITL" runat="server" Width="98%"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td>Contents</td>
									<td>
										<CKEditor:CKEditorControl id="CNTN" BasePath="/resources/ckeditor/" runat="server"></CKEditor:CKEditorControl>
									</td>
								</tr>
								<tr>
									<td>Movie Url</td>
									<td>
										<asp:TextBox id="PATH" runat="server" Width="98%"></asp:TextBox>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="btn">
						<ul>
							<li><a href="#" onclick="proc_save();">SAVE</a></li>
							<li><asp:LinkButton id="btn_cancel" runat="server" ToolTip="list" onclick="btn_cancel_Click">CANCEL</asp:LinkButton></li>
							<li><asp:LinkButton id="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
						</ul>
					</div>
					<asp:LinkButton id="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click"></asp:LinkButton>
					</div>
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
			</div>
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
