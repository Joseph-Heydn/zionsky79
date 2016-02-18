<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="announcement.aspx.cs" Inherits="_12sky2.web.news.announcement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2</title>
    
    <common:layout id="common" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="main_bg">
            <div id="wrap">
                <head:layout id="head" runat="server" />
                
                <div id="C_container">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                    <!-- left menu -->
                    <left:layout id="left" runat="server" setTITL="News" setSUB_TITL="announcement" />
                    
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; ข่าวคราว &gt; <span class="now">ประกาศ</span></div>
					        <div class="page_tit">ประกาศ</div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">
					        <asp:Repeater ID="LIST" runat="server">
                            <ItemTemplate>
                            <div class="announce">
                                <div class="announce_tit">
                                    <asp:LinkButton ID="btn_list" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                        <%# DataBinder.Eval(Container, "DataItem.TITL")%>
                                    </asp:LinkButton>
                                </div>
                                <div class="announce_date">
                                    by <span class="writer"><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM") %></span> <%# DataBinder.Eval(Container, "DataItem.REG_DT") %>
                                </div>
                                <div class="announce_img">
                                    <asp:LinkButton ID="btn_list2" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                        <%# DataBinder.Eval(Container, "DataItem.IMG_SRC")%>
                                    </asp:LinkButton>
                                </div>
                                <div class="announce_text">
                                    <ul>
                                        <li>
                                            <asp:LinkButton ID="btn_list3" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                                <%# DataBinder.Eval(Container, "DataItem.CNTN2")%>
                                            </asp:LinkButton>
                                        </li>
                                    </ul>  
                                </div>
                            </div>
                            </ItemTemplate>                                
                            </asp:Repeater>
                            <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                            <div class="announce">
                                no data
                            </div>
                            </asp:Panel>
                            <div class="pagingArea">
                                <div class="pagingText">(<asp:Label ID="NOW_PAGE" runat="server" /> / <asp:Label ID="TOTAL_PAGE" runat="server" /> Page )</div>
                                <div class="paging">
                                    <asp:Repeater ID="PAGING" runat="server">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container, "DataItem.PAGE")%>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>
				    </div>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        
            <tail:layout id="tail" runat="server" /> 
        </div>
    </form>
</body>
</html>
