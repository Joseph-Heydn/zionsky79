﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="read.aspx.cs" Inherits="_12sky2.admin.news.read" %>
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
				<admin_left:layout id="admin_left" runat="server" setTITL="News"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; News &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_table">
							<table cellspacing="0" cellpadding="0" class="N_table">
								<caption></caption>
								<colgroup>
									<col width="15%">
									<col width="25%">
									<col width="15%">
									<col width="*">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th colspan="6" class="title"><span id="TITL" runat="server"/></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th class="Writer">Writer</th>
										<td><span id="REG_NICK_NM" runat="server"/></td>
										<th class="date">Date</th>
										<td><span id="REG_DT" runat="server"/></td>
										<th class="hit">Hits</th>
										<td><span id="HIT_CNT" runat="server"/></th>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="board__view">
							<span id="CNTN" runat="server"/>
						</div>
						<file:layout id="file" runat="server"/>

						<!-- btn -->
						<div class="btn">
							<ul>
								<li><asp:LinkButton id="btn_edit" runat="server" ToolTip="list" onclick="btn_edit_Click">EDIT</asp:LinkButton></li>
								<li>
									<a href="#" onclick="if(confirm('Do you want to delete?')){ __doPostBack('btn_del2',''); }">DELETE</a>
								</li>
								<li><asp:LinkButton id="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
							</ul>
						</div>
						<asp:LinkButton id="btn_del2" runat="server" ToolTip="list" onclick="btn_del_Click"></asp:LinkButton>
					</div>
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
			</div> <!-- container -->
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
