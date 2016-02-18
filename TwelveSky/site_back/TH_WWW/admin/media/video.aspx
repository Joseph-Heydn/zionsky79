<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="video.aspx.cs" Inherits="_12sky2.admin.media.video" %>

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
                    <admin_left:layout id="admin_left" runat="server" setTITL="Media" setSUB_TITL="video" />
			
					<!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Media &gt; <span class="now">วีดีโอ</span></div>
					        <div class="page_tit">วีดีโอ</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="media_area">
                                <asp:Repeater ID="LIST" runat="server">
                                <ItemTemplate>					        
						        <div class="media_img">
							        <ul>
								        <li class="thum_img">
								            <asp:LinkButton ID="LinkButton1" runat="server"
                                                CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click" ToolTip='<%# DataBinder.Eval(Container, "DataItem.TITL") %>'>
								            <%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>
								            </asp:LinkButton>
								        </li>
								        <li class="thum_tit">
                                            <asp:LinkButton ID="btn_list" runat="server"
                                                CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click" ToolTip='<%# DataBinder.Eval(Container, "DataItem.TITL") %>'>
                                                <%# DataBinder.Eval(Container, "DataItem.TITL2") %> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT") %> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW") %>
                                            </asp:LinkButton>
								        </li>
							        </ul>
						        </div>
                                </ItemTemplate>                                
                                </asp:Repeater>	
                                <asp:Panel ID="NO_LIST" runat="server" Visible="false">
							    no data
                                </asp:Panel>                                					        
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
        				</div><!-- -->                       
					
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>
			        </div>			        
                            
                    </ContentTemplate>
                    </asp:UpdatePanel>			        
		        </div> <!-- container -->            
            
            </div>
            <tail:layout id="tail" runat="server" /> 
        </div>
    </form>
</body>
</html>
