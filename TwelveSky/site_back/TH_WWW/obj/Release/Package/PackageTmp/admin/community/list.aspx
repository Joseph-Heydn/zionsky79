﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="_12sky2.admin.community.list" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2 - Admin Page</title>
    
    <common:layout id="common" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <%--<div id="main_bg">--%>
        <div>
            <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" />
                
                <div id="C_container">                    
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                    
                    <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="Community" />
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; Community &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">			                            
                            <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="7%">
								        <col width="*">
								        <col width="20%">
								        <col width="12%">
								        <col width="10%">
							        </colgroup>
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>Title</th>
									        <th>Date</th>
									        <th>Writer</th>
									        <th>Hits</th>
								        </tr>
							        </thead>						        
                                    <tbody>
                                        <asp:Repeater ID="TOP_LIST" runat="server" Visible="false">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center" style=background:#E0F0EF ;"><img src="/resources/images/icon/news01.png" /></td>
                                                    <td style=background:#E0F0EF ;">
                                                        <asp:LinkButton ID="btn_list" runat="server"
                                                        CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                                            <%# DataBinder.Eval(Container, "DataItem.TITL") %> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT") %> <%# DataBinder.Eval(Container, "DataItem.ICON_FILE") %> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td class="center" style=background:#E0F0EF ;"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
                                                    <td class="center" style=background:#E0F0EF ;"><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM")%></td>
                                                    <td class="center" style=background:#E0F0EF ;"><%# DataBinder.Eval(Container, "DataItem.HIT_CNT")%></td>
                                                </tr>
                                            </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Repeater ID="TOP_5_LIST" runat="server" Visible="false">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center" style=background:#E7F0F7;"><img src="/resources/images/icon/like.png" width="20" /></td>
                                                    <td style=background:#E7F0F7;">
                                                        <asp:LinkButton ID="btn_list" runat="server"
                                                        CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                                            <%# DataBinder.Eval(Container, "DataItem.TITL") %> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT") %> <%# DataBinder.Eval(Container, "DataItem.ICON_FILE") %> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td class="center" style=background:#E7F0F7;"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
                                                    <td class="center" style=background:#E7F0F7;"><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM")%></td>
                                                    <td class="center" style=background:#E7F0F7;"><%# DataBinder.Eval(Container, "DataItem.HIT_CNT")%></td>
                                                </tr>
                                            </ItemTemplate>                                
                                        </asp:Repeater>                                      
                                        <asp:Repeater ID="LIST" runat="server">
                                            <ItemTemplate>
                                                <tr class='<%# DataBinder.Eval(Container, "DataItem.N_LIKE_CSS") %>'>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.ROWNUM")%></td>
                                                    <td>
                                                        <asp:LinkButton ID="btn_list" runat="server"
                                                        CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">
                                                            <%# DataBinder.Eval(Container, "DataItem.TITL") %> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT") %> <%# DataBinder.Eval(Container, "DataItem.ICON_FILE") %> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.REG_NICK_NM")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.HIT_CNT")%></td>
                                                </tr>
                                            </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                                            <tr>
                                                <td colspan="5" class="center">no data</td>
                                            </tr>
                                        </asp:Panel>
                                    </tbody>
                                </table>
                            </div>
                                                    
                            <div class="btn">
                                <ul>
                                    <li><asp:LinkButton ID="btn_reg" runat="server" ToolTip="Write" onclick="btn_reg_Click" Visible="false">WRITE</asp:LinkButton></li>
                                </ul>                            
                            </div> 
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
