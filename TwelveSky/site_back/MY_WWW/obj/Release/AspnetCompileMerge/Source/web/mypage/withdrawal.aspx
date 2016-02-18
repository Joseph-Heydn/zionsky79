<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="withdrawal.aspx.cs" Inherits="_12sky2.web.mypage.withdrawal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <common:layout id="common" runat="server" /> 
<script type="text/javascript">
    $(document).ready(function() {
        $("#ConfirmButton").click(function() {
            if (confirm("Are you sure you want to deacitivate your account?")) {
                __doPostBack("btn_submit", "");
            }
        });
    });
</script>         
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
						        <li><a href="/web/mypage/myquestions.aspx">Support</a>
							        <ul>
								        <li><a href="/web/mypage/myquestions.aspx">My Questions</a></li>
								        <li><a href="/web/mypage/contact.aspx">Contatct Us</a></li>
							        </ul>
						        </li>
						        <li><a href="/web/mypage/withdrawal.aspx" class="on">Deactivate my account</a></li>
					        </ul>
				        </div>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; My Page &gt; <span class="now">Deactivate my account</span></div>
					        <div class="page_tit">Deactivate my account</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">		
					        <div class="profile">
						        <div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
							        <table cellspacing="0" cellpadding="0" class="C_table01">
								        <caption></caption>
								        <colgroup>
									        <col width="30%" />
									        <col width="*" />
								        </colgroup>
								        <tbody>
									        <tr>
										        <th class="b_none"><span class="red_02">*</span>E-Mail Address:</th>
										        <td>
                                                    <asp:TextBox ID="UserID" runat="server" Width="240"></asp:TextBox>
										        </td>
									        </tr>
									        <tr>
										        <th class="b_none"><span class="red_02">*</span>Password:</th>
										        <td>
										            <asp:TextBox ID="Password" runat="server" Width="240" TextMode="Password"></asp:TextBox>
									            </td>
									        </tr>
								        </tbody>
							        </table>
						        </div>
					        </div>

					        <captcha:common ID="Common1" runat="server" /> 
					  
                            <p class="t_center">
                                <span class="btn_type" id="ConfirmButton"><a href="javascript:;">Confirm</a></span>    
                            </p>
                            
                            <asp:LinkButton ID="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>
                            
                            
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
