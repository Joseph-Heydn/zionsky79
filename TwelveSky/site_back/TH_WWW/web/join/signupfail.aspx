<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signupfail.aspx.cs" Inherits="_12sky2.web.join.signupfail" %>

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
				        <div class="lnb_tit">รายการลงทะเบียน</div>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; <span class="now">รายการลงทะเบียน</span></div>
					        <div class="page_tit">รายการลงทะเบียน</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
				            <div class="con_text02" style="background:#f5f5f5; padding:20px; width:650px;">
                                <ul>
                                    <li><strong>SingUp Faile!</strong></li>
                                    <li>
                                        คุณใส่ระหัสผิดพลาดกรุณาตรวจสอบอีกครั้งแล้วใส่ใหม่.
                                    </li>
                                    <li>- ทีมสนับสนุนKJ Games.</li>          
                                    <li style="margin-top:20px;">เพิ่มที่อยู่อีเมลของเราในสมุดของคุณเพื่อความปลอดภัยของผู้ส่งรายชื่อ.:<br />
                                    <a href="mailto:kjgames15@gmail.com">kjgames15@gmail.com</a><br />          
                                    </li>
                                </ul>
                            </div>				        
				        </div>
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
