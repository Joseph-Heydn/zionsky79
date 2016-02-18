<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main_banner.aspx.cs" Inherits="_12sky2.admin.main.main_banner" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<common:layout id="common" runat="server"/>
<style type="text/css">
	.preView { width:150px; height:570px; text-align:center; margin:0px auto; }
</style>
</head>

<body>
<form id="form1" runat="server">
	<div>
		<div id="wrap">
			<admin_head:layout id="admin_head" runat="server"/>

			<div id="C_container">

				<!-- left menu -->
				<admin_left:layout id="admin_left" runat="server" setTITL="Main" setSUB_TITL="main_banner"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; Main &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_tit">Main Banner Image Upload</div>
						<div class="admin_red">※ Image size has been optimized for 150 X 570</div>
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="N_table">
								<caption></caption>
								<colgroup>
									<col width="50%"/>
									<col width="50%"/>
								</colgroup>
								<thead>
									<tr>
										<th>Left Banner</th>
										<th>Right Banner</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="text-align:center; border-right:1px dotted #ccc;">
											<asp:Image id="Image1" runat="server" CssClass="preView"/><br/>
											<asp:FileUpload id="imageFile1" runat="server" onchange="__doPostBack('imageSelect1','')" CssClass="img_file"/>
											<asp:LinkButton id="imageSelect1" runat="server" OnClick="imageSelect1_Click"></asp:LinkButton>
											<asp:HiddenField id="SEQ1" runat="server"/><br/>
											<a href="#" onclick="if(confirm('Do you want to delete?')){ __doPostBack('btn_del1',''); }" class="del_btn">DELETE</a>
											<asp:LinkButton id="btn_del1" runat="server" onclick="btn_del1_Click"></asp:LinkButton>

										</td>
										<td style="text-align:center;">
											<asp:Image id="Image2" runat="server" CssClass="preView"/><br/>
											<asp:FileUpload id="imageFile2" runat="server" onchange="__doPostBack('imageSelect2','')" CssClass="img_file"/>
											<asp:LinkButton id="imageSelect2" runat="server" OnClick="imageSelect2_Click"></asp:LinkButton>
											<asp:HiddenField id="SEQ2" runat="server"/><br/>
											<a href="#" onclick="if(confirm('Do you want to delete?')){ __doPostBack('btn_del2',''); }" class="del_btn">DELETE</a>
											<asp:LinkButton id="btn_del2" runat="server" onclick="btn_del2_Click"></asp:LinkButton>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
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
