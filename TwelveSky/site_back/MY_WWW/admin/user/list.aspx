<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="_12sky2.admin.user.list" %>

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
                    <admin_left:layout id="admin_left" runat="server" setTITL="User" setSUB_TITL="user" />
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; User &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">
				            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="_USE_AUTH" runat="server" onselectedindexchanged="_USE_AUTH_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="All Member" Value="" Selected></asp:ListItem>
                                            <asp:ListItem Text="Temporary Member" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Active Member" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Administrator" Value="8"></asp:ListItem>
                                            <asp:ListItem Text="Withdrawal Member" Value="9"></asp:ListItem>
                                        </asp:DropDownList>	                                    
                                        <asp:TextBox ID="SCH_TXT" runat="server"></asp:TextBox>
                                        <asp:Button ID="btn_search" runat="server" Text="Search" onclick="btn_search_Click" />
                                    </td>
                                </tr>
                            </table>                            	                            
                            <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="7%">
								        <col width="*">
								        <col width="15%">
								        <col width="15%">
								        <col width="20%">
							        </colgroup>
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>ID</th>
									        <th>User No</th>
									        <th>Nickname</th>
									        <th>Use Authority</th>
								        </tr>
							        </thead>						        
                                    <tbody>
                                        <asp:Repeater ID="LIST" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.ROWNUM")%></td>
                                                    <td>
                                                        <asp:LinkButton ID="btn_list" runat="server"
                                                        CommandName='<%# DataBinder.Eval(Container, "DataItem.USER_ID") %>' onclick="btn_list_Click">
                                                            <%# DataBinder.Eval(Container, "DataItem.USER_ID")%>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.USER_NO")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.NICK_NM")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.USE_AUTH_NM")%></td>
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
                                    <li><asp:LinkButton ID="btn_reg" runat="server" ToolTip="ADD" onclick="btn_reg_Click" Visible="false">ADD</asp:LinkButton></li>
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
