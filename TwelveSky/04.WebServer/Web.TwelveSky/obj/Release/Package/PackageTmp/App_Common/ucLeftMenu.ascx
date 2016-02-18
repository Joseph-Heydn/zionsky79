<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="ucLeftMenu.ascx.cs"
	Inherits="Web.TwelveSky.App_Common.ucLeftMenu"
%>
<div class="lnb">
	<div class="lnb_tit">
		<asp:Literal id="lblGroup" runat="server"/>
	</div>
	<div class="left_menu">
		<ul>
<asp:Repeater id="repParent" OnItemDataBound="OnCategoryMenuBound" runat="server">
	<ItemTemplate>
			<li>
				<a href="<%# Eval("[3]") %>"<%# fnSelected(Eval("[3]")) %>><%# Eval("[2]") %></a>
		<asp:Repeater id="repChild" runat="server">
			<ItemTemplate>
				<ul>
					<li><a href="<%# Eval("[3]") %>"<%# fnSelected(Eval("[3]")) %>><%# Eval("[2]") %></a></li>
				</ul>
			</ItemTemplate>
		</asp:Repeater>
			</li>
	</ItemTemplate>
</asp:Repeater>
		</ul>
   </div>
</div>
