<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cmmt.ascx.cs" Inherits="_12sky2.web.include.cmmt" %>
<div id="is_cmmt" visible="false" runat="server" class="cmmtTitle">Comment</div>
<asp:Repeater ID="LIST" runat="server">
	<ItemTemplate>
		<table class="cmmtList" align="center">
			<tr>
				<td class="name">Writer : <b><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM")%></b> &nbsp;&nbsp;&nbsp;&nbsp;Date : <%# DataBinder.Eval(Container, "DataItem.REG_DTM")%></td>
				<td align="right" width="150">
					<asp:LinkButton ID="btn_edit" runat="server" Visible='<%# DataBinder.Eval(Container, "DataItem.ADMN").ToString().Equals("true") %>' CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' onclick="btn_edit_Click">Edit</asp:LinkButton>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height:40px;"><%# DataBinder.Eval(Container, "DataItem.CNTN").ToString().Replace("\n", "<br/>")%></td>
			</tr>
			<tr id="cmmtEdit" runat="server" visible="false">
				<td colspan="4">
					<table class="cmmtList" align="center">
						<tr>
							<td><span id="TITL" runat="server"/></td>
							<td align="right">
								<asp:LinkButton ID="btn_del" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' onclick="btn_del_Click">Delete</asp:LinkButton>
								<asp:LinkButton ID="btn_cancel" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' OnClick="btn_cancel_Click">Cancel</asp:LinkButton>
							</td>
						</tr>
						<tr>
							<td>
								<asp:HiddenField ID="MODE" runat="server"/>
								<asp:HiddenField ID="SEQ" runat="server" Value='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' />
								<asp:TextBox ID="CNTN" runat="server" TextMode="MultiLine" Rows="5" Width="100%" Text='<%# DataBinder.Eval(Container, "DataItem.CNTN")%>'></asp:TextBox>
							</td>
							<td width="1">
								<div class="btn3">
									 <ul>
										<li>
											<asp:LinkButton ID="btn_reg" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' OnClick="btn_cmmt_reg_Click">Confirm</asp:LinkButton>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br/>
	</ItemTemplate>
</asp:Repeater>

<asp:Panel ID="CMMT_SAVE" runat="server" Visible="false">
<div style="float:left;margin-top:20px;padding:5px; padding-left:10px; "></div>
<div class="cmmtTitle">Comment register</div>
<table class="cmmtList" align="center">
	<tr>
		<td>
			<asp:TextBox ID="CNTN" runat="server" TextMode="MultiLine" Rows="5" MaxLength="4000" Width="100%"></asp:TextBox>
		</td>
		<td width="1">
			<div class="btn3">
				<ul>
					<li>
						<asp:LinkButton ID="btn_reg" runat="server" OnClick="btn_reg_Click">Confirm</asp:LinkButton>
					</li>
				</ul>
			</div>
		</td>
	</tr>
</table>
</asp:Panel>
