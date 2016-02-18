﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myquestions.aspx.cs" Inherits="_12sky2.web.mypage.myquestions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <common:layout id="common" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="main_bg">
            <div id="wrap">
                <head:layout id="head" runat="server" />
                
		        <div id="C_container">
			        <!-- left menu -->
			        <div class="lnb">
				        <div class="lnb_tit">My Page</div>
				        <div class="left_menu">
					        <ul>
						        <li><a href="/web/mypage/profile.aspx">Profile</a></li>
						        <li><a href="/web/mypage/password.aspx">Change Password</a></li>
						        <li><a href="/web/mypage/myquestions.aspx" class="on">Support</a>
							        <ul>
								        <li><a href="/web/mypage/myquestions.aspx"  class="on">My Questions</a></li>
								        <li><a href="/web/mypage/contact.aspx">Contact Us</a></li>
							        </ul>
						        </li>
						        <li><a href="/web/mypage/withdrawal.aspx">Deactivate my account</a></li>
					        </ul>
				        </div>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; My Page &gt; Support &gt; <span class="now">My Questions</span></div>
					        <div class="page_tit">My Questions</div>
				        </div>    
				        
				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_table">
					        
						        <table cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="7%" />
								        <col width="*" />
								        <col width="15%" />
								        <col width="20%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>Subject</th>
									        <th>Status</th>
									        <th>Last Update</th>
								        </tr>
							        </thead>
							        <tbody>
                                        <asp:Repeater ID="LIST" runat="server">
                                        <ItemTemplate>							        
								        <tr>
									        <td class="center"><%# DataBinder.Eval(Container, "DataItem.ROWNUM")%></td>
									        <td>
									            <asp:LinkButton ID="btn_list" runat="server"
                                                        CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ") %>' onclick="btn_list_Click">                                                        
									            <%# DataBinder.Eval(Container, "DataItem.TITL")%> <%# DataBinder.Eval(Container, "DataItem.CMMT_CNT")%> <%# DataBinder.Eval(Container, "DataItem.ICON_FILE")%> <%# DataBinder.Eval(Container, "DataItem.ICON_NEW")%>
									            </asp:LinkButton>
									        </td>
									        <td class="center"><%# DataBinder.Eval(Container, "DataItem.DEAL_STAT_NM")%></td>
									        <td class="center"><%# DataBinder.Eval(Container, "DataItem.REG_DT")%></td>
								        </tr>
                                        </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                                            <tr>
                                                <td colspan="4" class="center">no data</td>
                                            </tr>
                                        </asp:Panel>
							        </tbody>
						        </table>
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
		        </div> <!-- container -->
	        </div><!-- wrap -->
            <tail:layout id="tail" runat="server" /> 
        </div>	        				                    
    </form>
</body>
</html>
