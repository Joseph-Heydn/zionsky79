<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="miscellaeous.aspx.cs" Inherits="_12sky2.web.shop.miscellaeous" %>

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
			        <!-- left menu -->
			        <div class="lnb">
				        <div class="lnb_tit">Shop</div>
				        <div class="left_menu">
					        <ul>
						        <li><a href="/web/shop/upgrading.aspx" class="on">Item List</a></li>
						        <asp:Panel ID="LEFT_MENU_LIST" runat="server" Visible="false">
						        <li><a href='<%=GETBILLURL()%>'>Cash</a>
						            <ul>
								        <li><a href='<%=GETBILLURL()%>'>Buy Gp coins</a></li>
								        <li><a href='<%=GETBILLURL()%>/History/FillUpHistory.aspx'>Fill-up history</a></li>
                                        <li><a href='<%=GETBILLURL()%>/History/PurchaseHistory.aspx'>Purchase History</a></li>
								        <li><a href='<%=GETBILLURL()%>/Policy/CoinsPolicy.aspx'>Coins policy</a></li>
							        </ul>
							    </li>
						        </asp:Panel>
					        </ul>
				        </div>
<%--
				        <div class="left_search">
					        <ul>
						        <li><input type="text" id="id" name="id" maxlength="41" title="search" placeholder="Search"></li>
						        <li><a href="#"><img src="/resources/images/con_img/btn_search.gif" alt="search"></a></li>
					        </ul>
				        </div>--%>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Shop &gt; Item List &gt; <span class="now">Miscellaeous</span></div>
					        <div class="page_tit">Item List</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="page_tab">
						        <div class="tab">
							        <ul>
								        <li><a href="/web/shop/upgrading.aspx">Upgrading</a></li>
								        <li><a href="/web/shop/buffs.aspx">Buffs</a></li>
								        <li><a href="/web/shop/vanity.aspx">Vanity</a></li>
								        <li class="on"><a href="/web/shop/miscellaeous.aspx">Miscellaeous</a></li>
							        </ul>
						        </div>
					        </div>
				            <asp:Repeater ID="LIST" runat="server">
                            <ItemTemplate>  	                            
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
									        <th rowspan="3"><%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %></th>
									        <td class="center_b"><%# DataBinder.Eval(Container, "DataItem.ITEM_NM") %></td>
									        <td class="center"><%# DataBinder.Eval(Container, "DataItem.SALE_QTY")%></td>
									        <td class="center_c"><img src="/resources/images/con_img/shop/icon_cash.gif" alt="" /><%# DataBinder.Eval(Container, "DataItem.SALE_AMT")%></td>
								        </tr>
								        <tr>
									        <th class="center" colspan="3">Description</th>
								        </tr>
								        <tr>
									        <td colspan="3"><%# DataBinder.Eval(Container, "DataItem.EXPL")%></td>
								        </tr>
							        </tbody>
						        </table>
                            </div>
                            </ItemTemplate>                                
                            </asp:Repeater>
                            <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                            <div class="con_table">
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
				        </div><!-- -->
				        
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
