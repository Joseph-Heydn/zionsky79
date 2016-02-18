<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myquestions_r.aspx.cs" Inherits="_12sky2.web.mypage.myquestions_r" %>

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
						        <li><a href="/web/mypage/withdrawal.aspx">ยกเลิกการใช้งาน</a></li>
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
					            <table cellpadding="0" cellspacing="0" class="N_table">
							        <colgroup>
								        <col width="25%">
								        <col width="">
							        </colgroup>
							        <tbody>            
								        <tr>
									        <th class="b_none">Category:</th>
									        <td> 
									            <span id="QUST_CD_1" runat="server" /> > <span id="QUST_CD_2" runat="server" />
									        </td>
								        </tr>            
								        <tr>
									        <th class="b_none">Nick Name:</th>
                                            <td>
                                                <span id="NICK_NM" runat="server" />
									        </td>
								        </tr>
                                        <tr>
                                            <th class="b_none">Status</th>
                                            <td>
                                                <span id="DEAL_STAT_NM" runat="server" />
                                            </td>    
                                        </tr>
        											 
								        <tr>
									        <th class="b_none">Subject:</th>
									        <td>
									            <span id="TITL" runat="server" />
									        </td>
								        </tr>
        											 
								        <tr style="min-height:200px;height:200px;">
									        <th class="b_none">Contents :</th>
									        <td style="vertical-align:top;">
									            <span id="CNTN" runat="server" />
									        </td>
								        </tr>
        								<asp:Panel ID="FILE1" runat="server" Visible="false">		 
								        <tr>
									        <th class="b_none">Attached file.1:</th>
									        <td>
									            <span id="FILE_PATH_1" runat="server" />
									        </td>
								        </tr>
        								</asp:Panel>
        								<asp:Panel ID="FILE2" runat="server" Visible="false"> 
								        <tr>
									        <th class="b_none">Attached file.2:</th>
									        <td>
									            <span id="FILE_PATH_2" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE3" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.3:</th>
									        <td>
									            <span id="FILE_PATH_3" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE4" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.4:</th>
									        <td>
									            <span id="FILE_PATH_4" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE5" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.5:</th>
									        <td>
									            <span id="FILE_PATH_5" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
							        </tbody>
						        </table>
                                <asp:Panel ID="STAT3" runat="server" Visible="false">
				                <table cellpadding="0" cellspacing="0" class="N_table">
							            <colgroup>
								            <col width="25%">
								            <col width="">
							            </colgroup>
							            <tbody>            
								            <tr style="min-height:200px;height:200px;">
									            <th class="b_none">Processing Contents:</th>
									            <td style="vertical-align:top;">
									                <span id="DEAL_CNTN2" runat="server" />
									            </td>
								            </tr>
									    </tbody>    
                                    </table>                            	
                                </asp:Panel>						        
						        				        
					            <!-- btn -->
					            <div class="btnArea">
					                <div class="btn">
					                    <ul>
					                        <li><asp:LinkButton ID="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
					                    </ul>
					                </div>
					            </div>
						     </div>			

                              <cmmt:layout ID="cmmt" runat="server" setRELT_DIV="myquestions" />
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
