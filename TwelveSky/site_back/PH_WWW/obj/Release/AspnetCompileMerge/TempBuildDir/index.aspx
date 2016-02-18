<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="_12sky2.index" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title></title> 
<common:layout id="common" runat="server" />
<script type="text/javascript">
	function EnterEvent(e) {
		if (e.keyCode == 13) {
			__doPostBack("btn_login", "");
		}
	}

	$(function() {
		//  var cssTop = parseInt($("#banner").css("top"));
		var cssTop = parseInt($("#banner1").css("top"));
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			$("#banner").stop().animate({ "top": position + cssTop + "px" }, 500);
			$("#banner1").stop().animate({ "top": position + cssTop + "px" }, 500);
		});
	});
</script>
</head>

<body>
    <form id="form1" runat="server">
        <div id="main_bg">
<!-- left banner AD -->
<asp:Repeater ID="L_LIST" runat="server">
	<ItemTemplate>
		<div id="banner"><img src='<%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>' alt="" /></div>
	</ItemTemplate>
</asp:Repeater>
<!-- right banner AD -->
<asp:Repeater ID="R_LIST" runat="server">
	<ItemTemplate>
		<div id="banner1"><img src='<%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>' alt="" /></div> 
	</ItemTemplate>
</asp:Repeater>
            <div id="wrap">
                <head:layout id="head" runat="server" />

		        <div id="container">
			        <div id="top">
				        <!-- event -->
				        <div class="event">
					    <h2>EVENT</h2>
					    <div class="roll_img" style="min-height:326px;">
						    <ul>
                            <asp:Repeater ID="LIST1" runat="server">
								<ItemTemplate>
									<li onclick="document.location.href='<%# DataBinder.Eval(Container, "DataItem.RELT_LINK") %>'" gametype='<%# DataBinder.Eval(Container, "DataItem.SORT_ORD") %>' style='<%# DataBinder.Eval(Container, "DataItem.CSS1") %>'>
										<p class="img"><img src='<%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>' width="500" height="320" alt="" /></p>
										<p class="trans"><img src="/hun/images/us/12sky2/main/trans.png" class="png24" width="500" height="320" alt="" /></p>
										<p class="txt"><span><%# DataBinder.Eval(Container, "DataItem.TITL") %></span></p>
									</li>
								</ItemTemplate>	
                            </asp:Repeater>
						    </ul>
					    </div>
					    <!-- btn -->
					    <div class="roll_btn">
						    <p class="btn_pre" id="prevButton">
						        <a href="javascript: moveMenu(-1);">
							    <img src="/hun/images/us/12sky2/main/event_btn_pre.jpg" alt="previous" title="previous" />
							    </a></p>
						    <ul>
                            <asp:Repeater ID="LIST2" runat="server">
                            <ItemTemplate>
							    <li gametype='<%# DataBinder.Eval(Container, "DataItem.SORT_ORD") %>' class='<%# DataBinder.Eval(Container, "DataItem.CSS2") %>'>
							        <a href="javascript:;"><img src='<%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>' width="74" height="48" alt="" /></a>
							    </li>
                            </ItemTemplate>	
                            </asp:Repeater>	
                            </ul>
						    <p class="btn_next" id="nextButton">
						        <a href="javascript: moveMenu(1);">
									<img src="/hun/images/us/12sky2/main/event_btn_next.jpg" alt="next" title="next" />
							    </a>
							</p>
					    </div>
					    <!-- //btn -->
				    </div> <!-- event -->

				    <!-- right login -->
				    <div id="right_side">
					    <div class="right_login">
						    <div class="login_input">
						        <asp:Panel ID="LOGIN_PAGE" runat="server" Visible="false">
							    <ul class="input_box">
								    <li>
								        <label for="id" id="label_id" class="lbl_in"></label>
                                        <asp:TextBox ID="ID" runat="server" MaxLength="41" ToolTip="ID" CssClass="int" ></asp:TextBox>
                                    </li>
								    <li>
								        <label for="pw" id="label_pw" class="lbl_in"></label>
                                        <asp:TextBox ID="PSWD" runat="server" TextMode="Password" MaxLength="16" ToolTip="PASSWORD" CssClass="int" onkeypress="return EnterEvent(event)"></asp:TextBox>
									</li>
									<li class="forget"><a href="/web/mypage/findid.aspx">Forgot your ID or password?</a></li>
							    </ul>
							    <ul class="login_btn">
								    <li>
								        <asp:LinkButton ID="btn_login" runat="server" OnClick="btn_login_Click"><img src="/resources/images/img/login_btn.png" alt="" /></asp:LinkButton>
								    </li>
							    </ul>
							    </asp:Panel>
							    <asp:Panel ID="USER_PAGE" runat="server" Visible="false">
							            <ul class="input_box">
							                <li class="Nickname">Nickname : <span id="USER_NM" runat="server" /></li>
							                <li class="mypage"><span id="MY_PAGE" runat="server" /></li>
							                <li class="logout">
							                    <a href="#" onclick="if(confirm('Are you sure to log out?')) { __doPostBack('btn_logout',''); }">Logout</a>
							                    <asp:LinkButton ID="btn_logout" runat="server" OnClick="btn_logout_Click"></asp:LinkButton>
							                </li>
							            </ul>
							    </asp:Panel>
						    </div>
						    <div class="signup_btn">
							    <ul>
								    <li><a href="/web/join/signup.aspx"><img src="/resources/images/img/signup_btn.png" alt="signup" /></a></li>
								    <li>
								        <asp:Panel ID="DOWN1" runat="server" Visible="false">
								            <a href='<%=SYS.EXE_URL %>'><img src="/resources/images/img/download_btn.png" alt="game download" /></a>
								        </asp:Panel>
								        <asp:Panel ID="DOWN2" runat="server" Visible="false">
								            <a href="#" onclick="alert('Please login before you download the client');$('#ID').focus();"><img src="/resources/images/img/download_btn.png" alt="game download" /></a>
								        </asp:Panel>
								    </li>
							    </ul>
						    </div>
					    </div>
				    </div> <!-- right login -->
			    </div> <!-- top -->

			    <!-- contents -->
			    <div id="content">
				    <div id="center">
                        <announcement_m:image id="announcement_m" runat="server" />
				    </div>

				    <!-- right banner -->
				    <div id="right_banner">
					    <div class="right_tit">Movie</div>
					    <div class="movie" style="min-height:150px;">
						    <h2>movie</h2>
						    <span id="MAIN_MOVIE" runat="server" />
					    </div>
					    <!-- facebook -->
					    <div class="sns_facebook">
						    <div class="right_tit">Facebook Fans</div>
						    <div class="ri_box_t">
							    <div class="ri_box_b" style="padding-top:10px; padding-left:13px; padding-right:0px; padding-bottom:10px; float:left; background-color:#000; margin:0px 0px 20px 11px; width:236px;min-height:130px;">
<div id="fb-root"></div>
<script type="text/javascript">
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/<%=SYS.FACEBOOK_LANG %>/sdk.js#xfbml=1&version=v2.3";
		fjs.parentNode.insertBefore(js, fjs);
	} (document, 'script', 'facebook-jssdk'));
</script>

<div class="fb-page" data-href='<%=SYS.FACEBOOK_URL %>' data-width="218" data-height="258" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"></div>
                                </div>
						    </div>
					    </div> <!-- //facebook -->
					    <!-- social media -->
					    <div class="social">
						    <div class="ri_box_t">
							    <div class="ri_box_b">
								    <h2>Social Media</h2>
								    <ul>
									    <li><a href='<%=SYS.FACEBOOK_URL %>' target="_blank">
										    <img src="/hun/images/us/12sky2/main/sns_facebook.jpg" alt="facebook" title="facebook" /></a></li>
									    <%--<li><a href="http://www.youtube.com/watch?v=ooSrE_uMzoY" target="_blank">
										    <img src="/hun/images/us/12sky2/main/sns_youtube.jpg" alt="youtube" title="youtube" /></a></li>--%>
								    </ul>
							    </div>
						    </div>
					    </div> <!-- social media -->

					    <%--<!-- search -->
					    <div class="ri_box_t">
						    <div class="right_tit">Search</div>
						    <div class="search_area">
							    <p>
								    <input type="text" id="keyword" name="keyword" value="" />
								    <a href="javascript: search();"><img src="/hun/images/us/12sky2/main/btn_academia_search.jpg" alt="search" title="search" /></a>
							    </p>
						    </div>
					    </div><!-- search -->--%>
				    </div> <!-- right banner -->
			    </div> <!--contents -->
		        </div> <!-- container -->
            </div><!-- wrap -->
            <tail:layout id="tail" runat="server" />
        </div>
    </form>
</body>
</html>
