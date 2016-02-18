<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="findmessage.aspx.cs" Inherits="_12sky2.web.mypage.findmessage" %>

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
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; My Page &gt; <span class="now">Find Message</span></div>
					        <div class="page_tit">Find Message</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="message_box" id="CheckMessage" style="display:none;">Please enter your E-Mail Address.</div>
					        <div class="con_text" style="background:#f5f5f5; margin-top:20px; padding:20px 10px;">
						        <ul>
							        <li>Log-in information has been sent to your security email account.</li>
						        </ul>
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
