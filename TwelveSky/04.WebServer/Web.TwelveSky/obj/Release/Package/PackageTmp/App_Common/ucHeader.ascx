<%@ Control
	Language="C#"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="ucHeader.ascx.cs"
	Inherits="Web.TwelveSky.App_Common.ucHeader"
%>
<div class="header">
	<div class="logo">
		<a href="/"><img src="/_common/_images/img/12sky2_logo.png" class="png24" alt="12SKY2" title="Twelvesky2 WSP by KJ GAMES"/></a>
	</div>

	<div class="nav">
<asp:Repeater id="repParent" OnItemDataBound="OnCategoryMenuBound" runat="server">
	<ItemTemplate>
		<div class="menu_<%= gMenuCnt++ %>">
			<h2>
				<a href="<%# Eval("[4]") %>">
					<img src="<%# fnPrintImage(Eval("[5]")) %>" rel="<%# fnPrintImage(Eval("[5]")) %>" rel2="<%# fnPrintImage(Eval("[6]")) %>" class="png24" alt=""/>
				</a>
			</h2>
			<div class="bg" style="display:none;">
				<ul>
		<asp:Repeater id="repChild" runat="server">
			<ItemTemplate>
					<li><a href="<%# Eval("[4]") %>"<%# fnSelected(Eval("[4]")) %>><%# Eval("[3]") %></a></li>
			</ItemTemplate>
		</asp:Repeater>
				</ul>
			</div>
		</div>
	</ItemTemplate>
</asp:Repeater>
	</div>
</div>
