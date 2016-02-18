<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="announcement_r.aspx.cs" Inherits="_12sky2.web.news.announcement_r" %>

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
			        <left:layout id="left" runat="server" setTITL="News" setSUB_TITL="announcement" />

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; News &gt; <span class="now">Announcements</span></div>
					        <div class="page_tit">Announcements</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="announce_view">
						        <div class="announce_view_tit"><span id="TITL" runat="server" /></div>
						        <div class="announce_view_date">by <span id="REG_NICK_NM" runat="server" class="writer" /> <span id="REG_DT" runat="server" /></div>
					        </div>
					        <div class="view_contents">
						        <span id="CNTN" runat="server" />
					        </div>

				        <!-- btn -->
					        <div class="btn">
						        <ul>
							        <li><asp:LinkButton ID="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
						        </ul>
					        </div>

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
