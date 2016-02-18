<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="head.ascx.cs" Inherits="_12sky2.web.include.head" %>
<div class="header">
	<div class="logo">
		<a href="/"><img src="/resources/images/img/12sky2_logo.png" class="png24" alt="12SKY2" title="Twelvesky2 WSP by KJ GAMES"/></a>
	</div>
	<div class="nav">
		<div class="menu_1">
			<!-- active -->
			<h2><a href="/web/news/announcement.aspx"><img src="/resources/images/img/top_navi_01.png" rel="/resources/images/img/top_navi_01.png" rel2="/resources/images/img/top_navi_01_on.png" class="png24" alt="news" title="news"/></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="1" subMenuIndex="1"><a href="/web/news/announcement.aspx"><%= fnLabelText("announcement") %></a></li>
					<li menuIndex="1" subMenuIndex="2"><a href="/web/news/notice.aspx"><%= fnLabelText("notice") %></a></li>
				</ul>
			</div>
		</div>
		<div class="menu_2">
			<h2>
				<a href="/web/guide/story.aspx">
					<img src="/resources/images/img/top_navi_02.png" rel="/resources/images/img/top_navi_02.png" rel2="/resources/images/img/top_navi_02_on.png" class="png24" alt="guide" title="guide"/>
				</a>
			</h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="2" subMenuIndex="1"><a href="/web/guide/story.aspx"><%= fnLabelText("story") %></a></li>
					<li menuIndex="2" subMenuIndex="2"><a href="/web/guide/Introduction.aspx"><%= fnLabelText("introduction") %></a></li>
					<li menuIndex="2" subMenuIndex="3"><a href="/web/guide/feature.aspx"><%= fnLabelText("feature") %></a></li>
					<li menuIndex="2" subMenuIndex="4"><a href="/web/guide/requirements.aspx"><%= fnLabelText("requirements") %></a></li>
					<li menuIndex="2" subMenuIndex="5"><a href="/web/guide/questions.aspx"><%= fnLabelText("questions") %></a></li>
					<li menuIndex="2" subMenuIndex="6"><a href="/web/guide/start.aspx"><%= fnLabelText("start") %></a></li>
					<li menuIndex="2" subMenuIndex="7"><a href="/web/guide/info.aspx"><%= fnLabelText("info") %></a></li>
					<li menuIndex="2" subMenuIndex="8"><a href="/web/guide/play.aspx"><%= fnLabelText("play") %></a></li>
					<li menuIndex="2" subMenuIndex="9"><a href="/web/guide/pet.aspx"><%= fnLabelText("pet") %></a></li>
					<li menuIndex="2" subMenuIndex="10"><a href="/web/guide/item.aspx"><%= fnLabelText("item") %></a></li>
					<li menuIndex="2" subMenuIndex="11"><a href="/web/guide/pvp.aspx"><%= fnLabelText("pvp") %></a></li>
					<li menuIndex="2" subMenuIndex="12"><a href="/web/guide/player.aspx"><%= fnLabelText("player") %></a></li>
					<li menuIndex="2" subMenuIndex="13"><a href="/web/guide/government.aspx"><%= fnLabelText("government") %></a></li>
					<li menuIndex="2" subMenuIndex="14"><a href="/web/guide/npcs.aspx"><%= fnLabelText("npcs") %></a></li>
				</ul>
			</div>
		</div>
		<div class="menu_3">
			<h2>
				<a href="/web/community/list.aspx?DIV=discussion">
					<img src="/resources/images/img/top_navi_03.png" rel="/resources/images/img/top_navi_03.png" rel2="/resources/images/img/top_navi_03_on.png" class="png24" alt="forums" title="forums"/>
				</a>
			</h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="2" subMenuIndex="1"><a href="/web/community/list.aspx?DIV=discussion"><%= fnLabelText("discussion") %></a></li>
					<li menuIndex="2" subMenuIndex="2"><a href="/web/community/list.aspx?DIV=tips"><%= fnLabelText("tips") %></a></li>
					<li menuIndex="2" subMenuIndex="3"><a href="/web/community/list.aspx?DIV=problem"><%= fnLabelText("problem") %></a></li>
					<li menuIndex="2" subMenuIndex="4"><a href="/web/community/list.aspx?DIV=trade"><%= fnLabelText("trade") %></a></li>
				</ul>
			</div>
		</div>
		<div class="menu_4">
			<h2>
				<a href="/web/media/video.aspx">
					<img src="/resources/images/img/top_navi_04.png" rel="/resources/images/img/top_navi_04.png" rel2="/resources/images/img/top_navi_04_on.png" class="png24" alt="Media" title="Media"/>
				</a>
			</h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="4" subMenuIndex="1"><a href="/web/media/video.aspx"><%= fnLabelText("video") %></a></li>
					<li menuIndex="4" subMenuIndex="2"><a href="/web/media/list.aspx?DIV=artwork"><%= fnLabelText("artwork") %></a></li>
					<li menuIndex="4" subMenuIndex="3"><a href="/web/media/list.aspx?DIV=screenshots"><%= fnLabelText("screenshots") %></a></li>
				</ul>
			</div>
		</div>
		<div class="menu_5">
			<h2>
				<a href="/web/shop/upgrading.aspx">
					<img src="/resources/images/img/top_navi_05.png" rel="/resources/images/img/top_navi_05.png" rel2="/resources/images/img/top_navi_05_on.png" class="png24" alt="Item Mall" title="Item Mall"/>
				</a>
			</h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="5" subMenuIndex="1"><a href="/web/shop/upgrading.aspx"><%= fnLabelText("upgrading") %></a></li>
					<li menuIndex="5" subMenuIndex="2" id="TOP_MENU_LIST" runat="server" visible="false">
						<a href='<%=GETBILLURL()%>'>Cash</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
