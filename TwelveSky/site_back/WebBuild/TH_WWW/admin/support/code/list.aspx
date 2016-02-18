<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="_12sky2.admin.support.code.list" %>

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
                    <admin_left:layout id="admin_left" runat="server" setTITL="Support" setSUB_TITL="code"/>
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; Support &gt; <span class="now">Code Admin</span></div>
					        <div class="page_tit">Code Admin</div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">		 	                            
                            <div class="con_table" style="float:left; width:40%; margin-right:5px;">                                                          
						        <table cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="15%">
								        <col width="*">
								        <col width="12%">
							        </colgroup>
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>Name</th>
									        <th></th>
								        </tr>
							        </thead>
							        <tbody>
                                        <asp:Repeater ID="LIST" runat="server">
                                        <ItemTemplate>							        
								        <tr>
									        <th><%# DataBinder.Eval(Container, "DataItem.ROWNO")%></th>
									        <td class="center_b">
                                                <asp:LinkButton ID="btn_list" runat="server"
                                                    CommandName='<%# DataBinder.Eval(Container, "DataItem.CD_NO") %>' onclick="btn_list_Click">
                                                    <%# DataBinder.Eval(Container, "DataItem.CD_NM") %>
                                                </asp:LinkButton>									        
									        </td>
									        <td>
									            <a href="#" onclick="popup('/admin/support/code/upCd_e.aspx?SEQ=<%# DataBinder.Eval(Container, "DataItem.CD_NO")%>', 'UP_CD', 400, 200, 1);">EDIT</a>
									        </td>
								        </tr>
                                        </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                                            <tr>
                                                <td colspan="3" class="center">no data</td>
                                            </tr>
                                        </asp:Panel>								        
							        </tbody>
						        </table>
						        <br />
                                <div class="btn">
                                    <ul>
                                        <li><a href="#" onclick="popup('/admin/support/code/upCd.aspx', 'UP_CD', 400, 150, 1);">ADD</a></li>
                                    </ul>                            
                                </div>						        
                            </div>      
                            
                            <div class="con_table" style="float:left; width:59%;">                                                          
						        <table cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="15%">
								        <col width="*">
								        <col width="*">
								        <col width="12%">
							        </colgroup>
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>Parent</th>
									        <th>Name</th>
									        <th></th>
								        </tr>
							        </thead>
							        <tbody>
                                        <asp:Repeater ID="S_LIST" runat="server">
                                        <ItemTemplate>							        
								        <tr>
									        <th><%# DataBinder.Eval(Container, "DataItem.ROWNO")%></th>
									        <th><%# DataBinder.Eval(Container, "DataItem.UP_CD_NM")%></th>
									        <td class="center_b">
                                                <asp:LinkButton ID="btn_list" runat="server"
                                                    CommandName='<%# DataBinder.Eval(Container, "DataItem.CD_NO") %>' onclick="btn_list_Click">
                                                    <%# DataBinder.Eval(Container, "DataItem.CD_NM") %>
                                                </asp:LinkButton>									        
									        </td>
									        <td>
									            <a href="#" onclick="popup('/admin/support/code/cd_e.aspx?SEQ=<%# DataBinder.Eval(Container, "DataItem.CD_NO")%>', 'CD', 400, 200, 1);">EDIT</a>
									        </td>
								        </tr>
                                        </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Panel ID="NO_S_LIST" runat="server" Visible="false">
                                            <tr>
                                                <td colspan="3" class="center">no data</td>
                                            </tr>
                                        </asp:Panel>
							        </tbody>
						        </table>
						        <br />
                                <div class="btn">
                                    <ul>
                                        <li><a href="#" onclick="popup('/admin/support/code/cd.aspx', 'CD', 400, 200, 1);">ADD</a></li>
                                    </ul>                            
                                </div>                           
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
