<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="announcement_m.ascx.cs" Inherits="_12sky2.web.include.announcement_m" %>

<div id="news_list_main">
    <div class="article">
        <ul>
            <asp:Repeater ID="LIST" runat="server">
                <ItemTemplate>
                    <li>
                        <h4>
                            <asp:LinkButton ID="btn_list" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                <%# DataBinder.Eval(Container, "DataItem.TITL")%>
                            </asp:LinkButton>
                        </h4>
                        <p class="date">by <span><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM") %></span> <%# DataBinder.Eval(Container, "DataItem.REG_DT") %></p>
                        <dl>
                            <dt>
                                <asp:LinkButton ID="btn_list2" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                    <%# DataBinder.Eval(Container, "DataItem.IMG_SRC")%>
                                </asp:LinkButton>
                            </dt>
                            <dd>
                                <asp:LinkButton ID="btn_list3" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                    <%# DataBinder.Eval(Container, "DataItem.CNTN2")%>
                                </asp:LinkButton>
                            </dd>
                        </dl>
                    </li>
                </ItemTemplate>                                
            </asp:Repeater>
        </ul>
    </div>
</div>