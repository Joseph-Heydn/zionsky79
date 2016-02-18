<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="head.ascx.cs" Inherits="_12sky2.web.include.head" %>

<div class="header">
	<div class="logo">
	    <a href="/"><img src="/resources/images/img/12sky2_logo.png" class="png24" alt="12SKY2" title="Twelvesky2 WSP by KJ GAMES" /></a>
	</div>
	<div class="nav">
	    <div class="menu_1">
			<!-- active -->
			<h2><a href="/web/news/announcement.aspx"><img src="/resources/images/img/top_navi_01.png" rel="/resources/images/img/top_navi_01.png" rel2="/resources/images/img/top_navi_01_on.png" class="png24" alt="news" title="news" /></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="1" subMenuIndex="1"><a href="/web/news/announcement.aspx">Announcements</a></li>
					<li menuIndex="1" subMenuIndex="2"><a href="/web/news/notice.aspx">Notice</a></li>
					
				</ul>
			</div>
		</div>
		<div class="menu_2">
			<h2><a href="/web/guide/story.aspx">
				<img src="/resources/images/img/top_navi_02.png" rel="/resources/images/img/top_navi_02.png" rel2="/resources/images/img/top_navi_02_on.png" class="png24" alt="guide" title="guide" /></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="2" subMenuIndex="1"><a href="/web/guide/story.aspx">Story</a></li>
					<li menuIndex="2" subMenuIndex="2"><a href="/web/guide/Introduction.aspx">Introduction</a></li>
					<li menuIndex="2" subMenuIndex="3"><a href="/web/guide/feature.aspx">Game Feature</a></li>
					<li menuIndex="2" subMenuIndex="4"><a href="/web/guide/requirements.aspx">System Requirements</a></li>
					<li menuIndex="2" subMenuIndex="5"><a href="/web/guide/questions.aspx">General Questions</a></li>
					<li menuIndex="2" subMenuIndex="6"><a href="/web/guide/start.aspx">Getting Started</a></li>
					<li menuIndex="2" subMenuIndex="7"><a href="/web/guide/info.aspx">Class Info</a></li>
					<li menuIndex="2" subMenuIndex="8"><a href="/web/guide/play.aspx">Game Play</a></li>
					<li menuIndex="2" subMenuIndex="9"><a href="/web/guide/pet.aspx">Pet Information</a></li>
					<li menuIndex="2" subMenuIndex="10"><a href="/web/guide/item.aspx">Items</a></li>
					<li menuIndex="2" subMenuIndex="11"><a href="/web/guide/pvp.aspx">PvP Combat</a></li>
					<li menuIndex="2" subMenuIndex="12"><a href="/web/guide/player.aspx">Player Interaction</a></li>
					<li menuIndex="2" subMenuIndex="13"><a href="/web/guide/government.aspx">Government</a></li>
					<li menuIndex="2" subMenuIndex="14"><a href="/web/guide/npcs.aspx">NPCs</a></li>
					
				</ul>
			</div>
		</div>
		<div class="menu_3">
			<h2><a href="/web/community/list.aspx?DIV=discussion">
				<img src="/resources/images/img/top_navi_03.png" rel="/resources/images/img/top_navi_03.png" rel2="/resources/images/img/top_navi_03_on.png" class="png24" alt="forums" title="forums" /></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="2" subMenuIndex="1"><a href="/web/community/list.aspx?DIV=discussion">General Discussion</a></li>
					<li menuIndex="2" subMenuIndex="2"><a href="/web/community/list.aspx?DIV=tips">Tips / Knowhow</a></li>
					<li menuIndex="2" subMenuIndex="3"><a href="/web/community/list.aspx?DIV=problem">Problem Solution</a></li>
					<li menuIndex="2" subMenuIndex="4"><a href="/web/community/list.aspx?DIV=trade">Item Trade</a></li>						
				</ul>
			</div>
		</div>
		<div class="menu_4">
			<h2><a href="/web/media/video.aspx">
				<img src="/resources/images/img/top_navi_04.png" rel="/resources/images/img/top_navi_04.png" rel2="/resources/images/img/top_navi_04_on.png" class="png24" alt="Media" title="Media" /></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="4" subMenuIndex="1"><a href="/web/media/video.aspx">Video</a></li>
					<li menuIndex="4" subMenuIndex="2"><a href="/web/media/list.aspx?DIV=artwork">Artwork</a></li>
					<li menuIndex="4" subMenuIndex="3"><a href="/web/media/list.aspx?DIV=screenshots">Screenshots</a></li>
				</ul>
			</div>
		</div>
		<div class="menu_5">
			<h2><a href="/web/shop/upgrading.aspx">
				<img src="/resources/images/img/top_navi_05.png" rel="/resources/images/img/top_navi_05.png" rel2="/resources/images/img/top_navi_05_on.png" class="png24" alt="Item Mall" title="Item Mall" /></a></h2>
			<div class="bg" style="display: none;">
				<ul>
					<li menuIndex="5" subMenuIndex="1"><a href="/web/shop/upgrading.aspx">Item List</a></li>
					<li menuIndex="5" subMenuIndex="2" id="TOP_MENU_LIST" runat="server" visible="false">
					    <a href='<%=GETBILLURL()%>'>Cash</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
