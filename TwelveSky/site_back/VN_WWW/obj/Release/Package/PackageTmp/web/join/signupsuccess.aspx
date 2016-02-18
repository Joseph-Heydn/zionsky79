<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signupsuccess.aspx.cs" Inherits="_12sky2.web.join.signupsuccess" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<!-- Facebook Conversion Code for KJGAMES -->
<script>(function() {
  var _fbq = window._fbq || (window._fbq = []);
  if (!_fbq.loaded) {
	var fbds = document.createElement('script');
	fbds.async = true;
	fbds.src = '//connect.facebook.net/en_US/fbds.js';
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(fbds, s);
	_fbq.loaded = true;
  }
})();
window._fbq = window._fbq || [];
window._fbq.push(['track', '6024635441681', {'value':'0.01','currency':'USD'}]);
</script>
<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6024635441681&cd[value]=0.01&cd[currency]=USD&noscript=1"/></noscript>

<common:layout id="common" runat="server"/>
</head>

<body>
<form id="form1" runat="server">
	<div id="main_bg">
		<div id="wrap">
			<head:layout id="head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<div class="lnb">
					<div class="lnb_tit">Sign up</div>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; <span class="now">Sign up</span></div>
						<div class="page_tit">Sign up</div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						  <div class="con_text02">
							  <ul>
								<li><img src="succes_bg.png" alt="" usemap="#map"/>
									<map name="map">
										<area shape="rect" coords="81,509,611,571" href="/">
									</map>
								</li>
							  </ul>
<!--                              <div class="con_text02" style="background:#f5f5f5; padding:50px 20px; width:650px;">
							  <ul>
								<li style="font-size:17px;"><strong>Thank you for signing up TwelveSky2 WSP!</strong></li>
								<li style="font-size:17px;"><strong>You must login before download the game client.</strong></li>
								<li style="font-size:17px;"><br/><strong><a href="/" style="color: #fff;padding:15px;background-color: #0072bc;">Click here to go back to the main page to login</a></strong></li>
								<!--<li>Verification email has been sent to a registered account. <br/>
								Please verify your email account to finish the sign up process. <br/>
								If you have not received the verification email, please make sure to check your spam folder.
								 </li>
							  <li>- KJ Games support team</li>
							  <li style="margin-top:20px;">
								<span class="red_01">Add our email addresses to your address book or 'Safe Sender' list:</span><br/>
								<a href="mailto:kjgames15@gmail.com">kjgames15@gmail.com</a><br/>
							  </li>	-->
						  </div>
					</div>
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- wrap -->
		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
