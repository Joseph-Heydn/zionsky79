<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="file.ascx.cs" Inherits="_12sky2.web.include.file" %>
<asp:Panel ID="APND_FILE" runat="server" Visible="false">
    <div class="con_table" style="border-bottom: 2px solid #ccc;">
        <table cellspacing="0" cellpadding="0" class="N_table">
            <thead>
                <tr>
                    <td colspan="2"><b>Attach Files</b></td>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="FILE_LIST" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# DataBinder.Eval(Container, "DataItem.FILE_LINK")%></td>
                            <td width="100" align="right"><%# DataBinder.Eval(Container, "DataItem.FILE_SIZE")%> Mb</td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Panel>
