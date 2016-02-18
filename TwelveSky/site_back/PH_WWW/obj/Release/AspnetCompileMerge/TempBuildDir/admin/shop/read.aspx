<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="read.aspx.cs" Inherits="_12sky2.admin.shop.read" %>

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
			        <!-- left menu -->
			        <admin_left:layout id="admin_left" runat="server" setTITL="Shop" />

			        <!-- content -->
			        <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; Shop &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>

				        <!-- contents start -->
                        <div class="content_page">
					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="I_table">
						            <caption></caption>
						            <colgroup>
							            <col width="15%">
							            <col width="*">
							            <col width="12%">
							            <col width="15%">
						            </colgroup>
						            <thead>
							            <tr>
								            <th>Image</th>
								            <th>Name</th>
								            <th>Stock</th>
								            <th>Cost</th>
							            </tr>
						            </thead>
						            <tbody>
							            <tr>
								            <th rowspan="3">
								                <span id="IMG_SRC" runat="server" />									            
								            </th>
								            <td class="center_b">
                                                <span id="ITEM_NM" runat="server" />								        
								            </td>
								            <td class="center">
								                <span id="SALE_QTY" runat="server" />
								            </td>
								            <td class="center_c">
								                <span id="SALE_AMT" runat="server" />
								            </td>
							            </tr>
							            <tr>
								            <th class="center" colspan="3">Description</th>
							            </tr>
							            <tr>
								            <td colspan="3">
								                <span id="EXPL" runat="server" />
								            </td>
							            </tr>
						            </tbody>
					            </table>
					        </div>
					        	        
					        <!-- btn -->
					        <div class="btn">
					            <ul>
					                <li><asp:LinkButton ID="btn_edit" runat="server" ToolTip="list" onclick="btn_edit_Click">EDIT</asp:LinkButton></li>
					                <li>
					                    <a href="#" onclick="if(confirm('Do you want to delete?')){ __doPostBack('btn_del2',''); }">DELETE</a>
					                    
					                </li>
                                    <li><asp:LinkButton ID="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
					            </ul>
					        </div>
					        <asp:LinkButton ID="btn_del2" runat="server" ToolTip="list" onclick="btn_del_Click"></asp:LinkButton>
				        </div>				        
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>
			        </div>
		        </div> <!-- container -->
            </div>
            
            <tail:layout id="tail" runat="server" /> 
        </div>
    </form>
</body>
</html>
