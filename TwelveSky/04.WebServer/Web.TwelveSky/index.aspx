<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="index.aspx.cs"
	Inherits="Web.TwelveSky.index"
%>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript" charset="utf-8" src="/_common/_js/jQuery/slides.min.jquery.js"></script>
	<script type="text/javascript" charset="utf-8" src="/_common/_js/__main.js"></script>

	<script type="text/javascript">
		var gMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Error_04 : "<%= fnLabelText("msgError_04") %>"
			};

		(function(d, s, id) {
			var fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) return;
			var js = d.createElement(s); js.id = id;

			js.src = "//connect.facebook.net/<%= C_NATE_CODE %>/sdk.js#xfbml=1&version=v2.3";
			fjs.parentNode.insertBefore(js, fjs);
		} (document, "script", "facebook-jssdk"));
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpMain" runat="server">
	<div id="container">
		<div id="top">
			<div class="event">
				<h2><asp:Literal runat="server" meta:resourcekey="lblEvent"/></h2>
				<div class="roll_img" style="min-height:326px;">
					<ul>
<asp:Repeater id="repTopRolling" runat="server">
	<ItemTemplate>
						<li onclick="javascript:;" gametype="<%# Eval("cWriteNo") %>"<%= fnHideImage() %>>
							<p class="img"><img src="<%# fnImageUrl(Eval("cFolder"), Eval("cImage"), Eval("cExts"), "m") %>" alt=""/></p>
							<p class="trans"><img src="/_common/_images/us/12sky2/main/trans.png" class="png24" alt=""/></p>
							<p class="txt"><span><%# Eval("cSubject") %></span></p>
						</li>
	</ItemTemplate>
</asp:Repeater>
					</ul>
				</div>
				<!-- roll_img -->

				<!-- roll_btn -->
				<div class="roll_btn">
					<p class="btn_pre" id="prevButton">
						<a href="javascript:moveMenu(-1);">
							<img src="/_common/_images/us/12sky2/main/event_btn_pre.jpg" alt="previous"/>
						</a>
					</p>
					<ul>
<asp:Repeater id="repTopRollBtn" runat="server">
	<ItemTemplate>
						<li gametype="<%# Eval("cWriteNo") %>">
							<a href="javascript:;">...</a>
						</li>
	</ItemTemplate>
</asp:Repeater>
					</ul>
					<p class="btn_next" id="nextButton">
						<a href="javascript:moveMenu(1);">
							<img src="/_common/_images/us/12sky2/main/event_btn_next.jpg" alt="next"/>
						</a>
					</p>
				</div>
				<!-- roll_btn -->
			</div>
			<!-- envent -->

			<div id="right_side">
				<div class="right_login">
					<div class="login_input">
<asp:Panel id="pnLoginPage" runat="server" Visible="false">
						<ul class="input_box">
							<li>
								<asp:TextBox id="txtAccountId" onkeypress="return fnEnterEvent(event);" MaxLength="50" CssClass="int" runat="server" meta:resourcekey="btnAccountId"/>
							</li>
							<li>
								<asp:TextBox id="txtPassword" TextMode="Password" onkeypress="return fnEnterEvent(event);" MaxLength="16" CssClass="int" runat="server" meta:resourcekey="btnPassword"/>
							</li>
							<li class="forget">
								<a href="/web/guest/findId.aspx?m=1000023">
									<asp:Literal runat="server" meta:resourcekey="lblLogin"/>
								</a>
							</li>
						</ul>
						<ul class="login_btn">
							<li>
								<asp:LinkButton id="btnLogin" OnClientClick="return fnWebLogin();" OnClick="btnLogin_OnClick" runat="server">
									<img src="/_common/_images/img/<%= C_LANG_CODE %>/login_btn.png" alt=""/>
								</asp:LinkButton>
							</li>
						</ul>
</asp:Panel>
<asp:Panel id="pnUserPage" runat="server" Visible="false">
						<ul class="input_box">
							<li class="Nickname">
								<asp:Literal runat="server" meta:resourcekey="lblNickName"/>
								<asp:Literal id="lblNickName" runat="server"/>
							</li>
							<li class="mypage">
								<a href="/web/privacy/profile.aspx?m=1000018">
									<asp:Literal runat="server" meta:resourcekey="lblPrivacy"/>
								</a>
							</li>
							<li class="logout">
								<asp:LinkButton OnClientClick="return fnWebLogOut();" OnClick="btnLogout_OnClick" runat="server" meta:resourcekey="btnLogout"/>
							</li>
						</ul>
</asp:Panel>
					</div>
					<div class="signup_btn">
						<ul>
							<li><a href="/web/guest/signup.aspx?m=1000025"><img src="/_common/_images/img/<%= C_LANG_CODE %>/signup_btn.png" alt="signup"/></a></li>
							<li>
								<a href="<%= C_GAMEDOWN_URL %>">
									<img src="/_common/_images/img/<%= C_LANG_CODE %>/download_btn.png" alt="game download"/>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- right_login -->
			</div>
			<!-- right_side -->

			<div id="content">
				<div id="center">
					<div id="news_list_main">
						<div class="article">
							<ul>
<asp:Repeater id="repAnnounce" runat="server">
	<ItemTemplate>
								<li>
									<h4>
										<a href="/web/board/view.aspx?m=<%# Eval("cMenuNo") %>&w=<%# Eval("cWriteNo") %>">
											<%# Eval("cSubject") %>
										</a>
									</h4>
									<p class="date">
										<asp:Literal runat="server" meta:resourcekey="lblBy"/>
										<span><%# Eval("cWriter") %></span>
										<%# fnDateOnly(Eval("cCreateTime")) %>
									</p>
									<dl>
										<dt>
											<a href="/web/board/view.aspx?m=<%# Eval("cMenuNo") %>&w=<%# Eval("cWriteNo") %>">
												<img src="<%# fnImageUrl(Eval("cFolder"), Eval("cImage"), Eval("cExts"), "s") %>" alt=""/>
											</a>
										</dt>
										<dd>
											<a href="/web/board/view.aspx?m=<%# Eval("cMenuNo") %>&w=<%# Eval("cWriteNo") %>">
												<%# Eval("cSummary") %>
											</a>
										</dd>
									</dl>
								</li>
	</ItemTemplate>
</asp:Repeater>
							</ul>
						</div>
					</div>
				</div>

				<div id="right_banner">
					<div class="right_tit"><asp:Literal runat="server" meta:resourcekey="lblMovie"/></div>
					<div class="movie" style="min-height:150px;">
						<h2><asp:Literal runat="server" meta:resourcekey="lblMovie"/></h2>
						<asp:Literal id="lblMovie" runat="server"/>
					</div>

					<div class="sns_facebook">
						<div class="right_tit"><asp:Literal runat="server" meta:resourcekey="lblFacebook"/></div>
						<div class="ri_box_t">
							<div class="ri_box_b" style="padding-top:10px; padding-left:13px; padding-right:0; padding-bottom:10px; float:left; background-color:#000; margin:0 0 20px 11px; width:236px;min-height:130px;">
								<div id="fb-root"></div>
								<div class="fb-page" data-href="<%= C_FACEBOOK_URL %>" data-width="218" data-height="258" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"></div>
							</div>
						</div>
					</div>
					<!-- sns_facebook -->

					<!-- social media -->
					<div class="social">
						<div class="ri_box_t">
							<div class="ri_box_b">
								<h2>Social Media</h2>
								<ul>
									<li>
										<a href="<%= C_FACEBOOK_URL %>" target="_blank">
											<img src="/_common/_images/us/12sky2/main/sns_facebook.jpg" alt="facebook"/>
										</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- social media -->
				</div>
				<!-- right_banner -->
			</div>
			<!--contents -->
		</div>
		<!-- top -->
	</div>
	<!-- container -->
</asp:Content>
