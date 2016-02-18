<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main_movie.aspx.cs" Inherits="_12sky2.admin.main.main_movie" %>
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
			<asp:HiddenField id="SEQ" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<admin_left:layout id="admin_left" runat="server" setTITL="Main" setSUB_TITL="main_movie"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; Main &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_tit">Main Youtube Upload</div>
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="N_table" style="border:1px solid #ccc;">
								<tbody>
									<tr>
										<th class="left" style="width:100px;">Movie Url</th>
										<td>
											<asp:TextBox id="PATH" runat="server" Width="98%" placeholder="text youtube url"></asp:TextBox>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn">
							<ul>
								<li><asp:LinkButton id="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click">SAVE</asp:LinkButton></li>
							</ul>
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
