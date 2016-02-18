<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cd_e.aspx.cs" Inherits="_12sky2.admin.support.code.cd_e" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Twelvesky2 - Admin Page</title>
<common:layout id="common" runat="server"/>
</head>

<body>
<form id="form1" runat="server">
	<div>
		<div class="con_table" style="float:left;width:100%; background:#fff; margin:30px auto;">
			<table cellspacing="0" cellpadding="0" class="N_table">
				<tbody>
					<tr>
						<th>Parent code</th>
						<td>
							<asp:DropDownList id="UP_CD_NO" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<th>NAME</th>
						<td>
						   <asp:TextBox id="CD_NM" runat="server" Width="98%"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<th>
							SORT ORDER
						</th>
						<td>
							<asp:TextBox id="SORT_ORD" runat="server" Width="98%"></asp:TextBox>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn">
			<ul>
				<li><asp:LinkButton id="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click">SAVE</asp:LinkButton></li>
				<li><asp:LinkButton id="btn_del" runat="server" ToolTip="save" onclick="btn_del_Click">DELETE</asp:LinkButton></li>
				<li><a href="#" onclick="javascript:self.close();">CANCEL</a></li>
			</ul>
		</div>
	</div>
</form>
</body>
</html>
