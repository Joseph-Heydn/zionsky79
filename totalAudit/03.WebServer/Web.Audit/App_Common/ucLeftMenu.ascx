<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="ucLeftMenu.ascx.cs"
	Inherits="Web.Audit.App_Common.ucLeftMenu"
%>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header">MAIN NAVIGATION</li>
<asp:Repeater id="rptParent" OnItemDataBound="OnCategoryMenuBound" runat="server">
	<ItemTemplate>
			<li class="treeview"><!--active-->
				<a href="<%# Eval("[3]") %>">
					<i class="fa fa-dashboard"></i> <span><%# Eval("[2]") %></span> <i class="fa fa-angle-left pull-right"></i>
				</a>
				<ul class="treeview-menu">
		<asp:Repeater id="rptChild" runat="server">
			<ItemTemplate>
					<li class="active">
						<a href="<%# Eval("[3]") %>">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="font-size:12px;">
								<i class="fa fa-circle-o"></i>&nbsp;&nbsp;
								<%# Eval("[2]") %>
							</span>
						</a>
					</li>
					<!--li class="active"-->
			</ItemTemplate>
		</asp:Repeater>
				</ul>
			</li>
	</ItemTemplate>
</asp:Repeater>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>
