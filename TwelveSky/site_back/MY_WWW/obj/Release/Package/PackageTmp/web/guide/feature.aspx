<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="feature.aspx.cs" Inherits="_12sky2.web.guide.feature" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="feature" />
            
                    <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">Game Feature</span></div>
					        <div class="page_tit">Game Feature</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_text">
						        <ul>
							        <li>TwelveSky2 WSP is an adrenaline-pumping Massively Multiplayer Online Role-Playing Game(MMORPG) based on an oriental fantasy theme of ancient China. Offering a uniquely intense and addictive faction vs. faction based gaming system, TwelveSky2 WSP is filled with battle and action which is bound to satisfy all the PvP needs of veteran and new players alike.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Players may choose from any of the three classes of each faction, then develop their skills, sharpen their weapons and refine their armor to produce a character fit for battle against the other Factions. But it isn't all about PvP, TwelveSky2 WSP also caters to a player's solo and party needs too! Explore a factions' vast maps to kill monsters, party with comrades, complete an endless array of quests, or hunt down bosses and attain riches and fame along the way.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>TwelveSky2 WSP also introduces a fourth faction, the Nangin. However, this new faction is not available at character creation. Players must achieve a high level to join this Faction, leaving their previous teammates and friends.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>All this and more! Best of all is TwelveSky2 WSP is Free to Play!</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Features
								        <br />Brutal death animations and knockback against monsters
								        <br />Large-scale fast-paced Player vs. Player (PvP) battle system
								        <br />A large variety of authentic weapons and thousands of unique items
								        <br />Elaborate weapon and armor enchanting system
								        <br />Regularly updated content</li>
						        </ul>
					        </div>
					        <div class="con_img">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/feature_img.png" alt=""></li>
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
