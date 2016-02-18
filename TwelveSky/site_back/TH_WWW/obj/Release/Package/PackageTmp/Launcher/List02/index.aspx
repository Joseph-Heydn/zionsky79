<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="_12sky2.Launcher.List02.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <link href="/Launcher/css/launcher_style_en.css" rel="stylesheet" type="text/css" />
</head>
<body style="overflow:hidden !important;">
    <form id="form1" runat="server">
        <div class="ts2_box ts2_back02">
            <!-- ประกาศ -->
            <div class="ts2_tit01">
                <a href="/web/news/announcement.aspx" target="_blank">
                    <img src="/hun/images/us/12sky2/launcher/btn_readmore.gif" alt="Read More" class="img_more" />
                </a>
            </div>
            <div class="ts2_list">
                <table border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <asp:Repeater ID="LIST1" runat="server">
                    <ItemTemplate>
                    <tr>
                        <td class="list_ts2">
                            <a href='/web/news/announcement_r.aspx?SEQ=<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' target="_blank">
                                • <%# DataBinder.Eval(Container, "DataItem.TITL") %><%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                            </a>
                        </td>
                        <td class="list_ts2_date"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
                    </tr>                
                    </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                </table>
            </div>
            <!-- Notice -->
            <div class="ts2_tit02">
                <a href="/web/news/notice.aspx" target="_blank">
                    <img src="/hun/images/us/12sky2/launcher/btn_readmore.gif" alt="Read More" class="img_more" />
                </a>
            </div>
            <div class="ts2_list">
                <table border="0" cellpadding="0" cellspacing="0">
                <asp:Repeater ID="LIST2" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="list_ts2">
                            <a href='/web/news/notice_r.aspx?SEQ=<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' target="_blank">
                                • <%# DataBinder.Eval(Container, "DataItem.TITL") %><%# DataBinder.Eval(Container, "DataItem.ICON_FILE") %><%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                            </a>
                        </td>
                        <td class="list_ts2_date"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
                    </tr>
                </ItemTemplate>                                
                </asp:Repeater>
                </table>           
            </div> 
        </div>
    </form>
</body>
</html>
