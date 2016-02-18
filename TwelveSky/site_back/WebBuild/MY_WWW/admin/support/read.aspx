<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="read.aspx.cs" Inherits="_12sky2.admin.support.read" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title></title>
    
    <common:layout id="common" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" />
                
		        <div id="C_container">
			        <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="Support" setSUB_TITL="questions"/>
                   
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Support &gt; <span class="now">Contatct Us</span></div>
					        <div class="page_tit">Contatct Us</div>
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
									        <td colspan="3"> 
									            <span id="QUST_CD_1" runat="server" /> > <span id="QUST_CD_2" runat="server" />
									        </td>
								        </tr>            
								        <tr>
									        <th class="b_none">Nick Name:</th>
                                            <td>
                                                <span id="NICK_NM" runat="server" />
									        </td>
									        <th class="b_none">User No:</th>
                                            <td>
                                                <span id="USER_NO" runat="server" />
									        </td>
									    </tr>            
								        <tr>
									        <th class="b_none">User ID:</th>
                                            <td>
                                                <span id="USER_ID" runat="server" />
									        </td>
									        <th class="b_none">Secondary Email:</th>
                                            <td>
                                                <span id="SCRT_EMAIL" runat="server" />
									        </td>									        									        
								        </tr>
                                        <tr>
                                            <th class="b_none">Status :</th>
                                            <td colspan="3">
                                                <span id="DEAL_STAT_NM" runat="server" />
                                            </td>    
                                        </tr>
        											 
								        <tr>
									        <th class="b_none">Subject:</th>
									        <td colspan="3">
									            <span id="TITL" runat="server" />
									        </td>
								        </tr>
        											 
								        <tr style="min-height:200px;height:200px;">
									        <th class="b_none">Contents:</th>
									        <td colspan="3" style="vertical-align:top;">
									            <span id="CNTN" runat="server" />
									        </td>
								        </tr>
        								<asp:Panel ID="FILE1" runat="server" Visible="false">		 
								        <tr>
									        <th class="b_none">Attached file.1:</th>
									        <td colspan="3">
									            <span id="FILE_PATH_1" runat="server" />
									        </td>
								        </tr>
        								</asp:Panel>
        								<asp:Panel ID="FILE2" runat="server" Visible="false"> 
								        <tr>
									        <th class="b_none">Attached file.2:</th>
									        <td colspan="3">
									            <span id="FILE_PATH_2" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE3" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.3:</th>
									        <td colspan="3">
									            <span id="FILE_PATH_3" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE4" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.4:</th>
									        <td colspan="3">
									            <span id="FILE_PATH_4" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
                                        <asp:Panel ID="FILE5" runat="server" Visible="false">
								        <tr>
									        <th class="b_none">Attached file.5:</th>
									        <td colspan="3">
									            <span id="FILE_PATH_5" runat="server" />
									        </td>
								        </tr>
								        </asp:Panel>
							        </tbody>
						        </table>
						        			
                            <asp:Panel ID="STAT2" runat="server" Visible="false">
					            <table cellpadding="0" cellspacing="0" class="N_table">
							        <colgroup>
								        <col width="25%">
								        <col width="">
							        </colgroup>
							        <tbody>            
								        <tr>
								            <th class="b_none">Processing Status :</th>
								            <td>
                                                <asp:DropDownList ID="DEAL_STAT_SELECT" runat="server">
                                                    <asp:ListItem Text="Processing" Value="2" Selected></asp:ListItem>
                                                    <asp:ListItem Text="Processing complete" Value="3" ></asp:ListItem>
                                                </asp:DropDownList>
								            </td>
								        </tr>
								        <tr>
									        <th class="b_none">Processing Contents :</th>
									        <td>
									            <asp:TextBox ID="DEAL_CNTN" runat="server" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
									        </td>
									    </tr>
									</tbody>    
                                </table>
                            </asp:Panel>
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
					            <asp:Panel ID="STAT1" runat="server" Visible="false">
					                <div class="btn2">
					                    <ul>
					                        <li><asp:LinkButton ID="btn_ok" runat="server" ToolTip="Receipt complete" onclick="btn_ok_Click">Receipt complete</asp:LinkButton></li>
					                    </ul>
					                </div>	
					            </asp:Panel>				            
					                <div class="btn">
					                    <ul>
					                        <li><asp:LinkButton ID="btn_save" runat="server" onclick="btn_save_Click" Visible="false">SAVE</asp:LinkButton></li>
					                        <li><a href="#" onclick="if(confirm('Do you want to delete?')){ __doPostBack('btn_del',''); }">DELETE</a></li>
					                        <li><asp:LinkButton ID="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
					                    </ul>
					                </div>
					                <asp:LinkButton ID="btn_del" runat="server" ToolTip="list" onclick="btn_del_Click"></asp:LinkButton>
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
