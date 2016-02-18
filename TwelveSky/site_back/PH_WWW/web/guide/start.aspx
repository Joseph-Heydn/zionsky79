<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="start.aspx.cs" Inherits="_12sky2.web.guide.start" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="start" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">Getting Started</span></div>
					        <div class="page_tit">Getting Started</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">INSTALLATION AND LOGIN</div>
					        <div class="con_text">
						        <ul>
							        <li>Welcome to TwelveSky2 WSP!<br />  You can begin by downloading the game here: TwelveSky2 WSP Download Page</li>
						        </ul>
					        </div>
					        <div class="con_img01">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/start01.gif" alt=""></li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>- Logging In -</li>
							        <li>Once you have downloaded and installed the game,<br />
							        you are ready to begin playing!</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Your 12sky2 WSP account is required for login. You can register a free account at www.12sky2-ph.com.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Remember, accounts and passwords are case sensitive!</li>
						        </ul>
					        </div>
        					
					        <div class="con_tit01">Character Creation</div>
					        <div class="con_img01">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/start02.gif" alt=""></li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>There are several choices to make during character creation. You can customize your character's appearance, but you must also choose a Faction.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Each faction has different strengths and weaknesses, as well as different weapons. However, each faction has three types of weapons. While you select a weapon at this screen, you may also purchase and use a different weapon type once in game.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>1. Offense - Greater attack power, but lower defense.</li>
							        <li>2. Defense - Greater defense, but lower attack power.</li>
							        <li>3. Ranged - Skills can be used at range. </li>
						        </ul>
					        </div>

					        <div class="con_tit01">User Interface</div>
					        <div class="con_img">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/start03.png" alt=""></li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>1. Player Status Window: Shows current Health, Chi, and Experience percent. </li>
							        <li>2. Zone Mini-Map: The mini-map shows current location, as well as NPC, quests, monsters, and party members. The map can be hidden with the arrow button, and zoomed in/out with the +/- keys.</li>
							        <li>3. System Messages: System messages will appear in this window. This includes Battle Grounds information, PvP and PvE damage/defense, as well as Guild system messages.</li>
							        <li>4. Player Chat: Chat from other players will appear in this window. </li>
							        <li>5. Mini Menu: The Mini Menu offers quick shortcuts to often-used windows, such as Character Stats, Inventory, Guild Info, etc.</li>
							        <li>6. Shortcut Bar: Skills, Pills/Tablets, and Emotes can be assigned to this bar, enabling the associated hotkey.</li>
							        <li>7. Quick Menu: Game Help can be opened with the ? button. There are also Faction-related windows available through this menu, as well as the Item Mall.</li>
							        <li>8. Party Information: Shows Party member levels, names, and HP/Chi status. </li>
							        <li>9. Pet Status Window: Shows Pet's Activity and Exp growth. </li>
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
