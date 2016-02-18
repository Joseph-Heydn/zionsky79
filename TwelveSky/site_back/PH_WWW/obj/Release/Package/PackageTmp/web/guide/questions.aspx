<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="questions.aspx.cs" Inherits="_12sky2.web.guide.questions" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="questions" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">General Questions</span></div>
					        <div class="page_tit">General Questions</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">FREQUENTLY ASKED QUESTIONS</div>
					        <div class="con_text">
						        <ul>
							        <li><strong>Players New to TwelveSky2 WSP:</strong></li>
							        <li>Q: What is TwelveSky2 WSP?</li>
							        <li>A: TwelveSky2 WSP is a fast-paced Massively Multiplayer Online Role-Playing Game (MMORPG) that combines competitive Faction vs Faction game play with Player vs Environment (PvE) game play. </li>
							        <li>Q: Is this game free?</li>
							        <li>A: Yes! All of the games that we offers are Free to Download and Free to Play! </li>
							        <li>Q: What are the System Requirements? </li>
							        <li>A: You can find the System Requirements for TwelveSky2 WSP here</li>
							        <li>Q: Where can I download TwelveSky2 WSP?</li>
							        <li>A: Please visit the TwelveSky2 WSP download site</li>
							        <li>Q: Where can new players get more information on how to play?</li>
							        <li>A: Game Guide and Forums</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li><strong>Gameplay Questions:</strong></li>
							        <li>Q: How many Characters can I create on one Account?</li>
							        <li>A: You are able to create 3 Characters. </li>
							        <li>Q: How many Factions are there, and how many weapons?</li>
							        <li>A: There are three starting Factions, with an additional fourth available to join later in the game. Each starting faction has three weapons.</li>
							        <li>Q: How do I restore my Health and Chi?</li>
							        <li>A: The Herbalist sells Health and Chi Pills/Tablets, which can also be found as monster drops. </li>
							        <li>Q: How do I make money?</li>
							        <li>A: In game currency can be dropped from monsters, contained in an item called a Fortune Pouch, or gained through sale of items found (either to NPCs or other players).</li>
							        <li>Q: How many people can join a Party?</li>
							        <li>A: 5 people are able to be in one Party together.</li>
							        <li>Q: How do Parties work?</li>
							        <li>A: Party members receive a bonus to exp per monster killed that ranges from 20% to 50% depending on the number of party members. Monster drops are now shared among the party as well, with any party member able to pick up items dropped.</li>
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
