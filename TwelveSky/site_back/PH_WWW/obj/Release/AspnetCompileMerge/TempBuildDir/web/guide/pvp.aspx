<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pvp.aspx.cs" Inherits="_12sky2.web.guide.pvp" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="pvp" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">PvP Combat</span></div>
					        <div class="page_tit">PvP Combat</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">PvP Combat</div>
					        <div class="con_text">
						        <ul>
							        <li><strong>Battle Grounds</strong></li>
							        <li>Level Bracket PvP - <br />
							        In TwelveSky2 WSP, PvP Battle Grounds are split among different level brackets.
							        When a character is eligible for a specific level bracket, a notification message
							        will appear in the System Messages window.
							        This notification will occur every minute for the 10 minutes prior to the Zone
							        opening.</li>
						        </ul>
					        </div>
							<div class="con_text">
						        <ul>
							        <li><strong>Battle Grounds</strong></li>
								</ul>
							</div>
					        <div class="con_text01">
								<ul>
									<li>Once the Zone opens, you have 3 minutes to travel to the Battle Zone.</li>
									<li>Travel to Battle Grounds takes place through the Guard Captain NPC.</li>
									<li>After 3 minutes elapse, no more travel into the zone is allowed.</li>
									<li>Once the Zone closes, players are granted 1 minute to prepare before the Battle begins.</li>
									<li>There are three different types of Battles:
										<ul>
											<li>Annihilation: All other Faction members must DIE</li>
											<li>Holy Stone Destruction: The other 2 Faction Holy Stones must be destroyed.</li>
											<li>Zone Capture: Faction must hold a formation for a set time period</li>
										</ul>
									</li>
								</ul>
					        </div>
					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="C_table01">
							        <caption></caption>
							        <colgroup>
								        <col width="35%" />
								        <col width="35%" />
								        <col width="30%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th>Zone Name</th>
									        <th>Level Range</th>
									        <th>Battle Goal</th>
								        </tr>
							        </thead>
							        <tbody>
								        <tr>
									        <td class="center">Bui Di Grounds</td>
									        <td class="center">Level 10 - 19</td>
									        <td class="center">Annihilation</td>
								        </tr>
								        <tr>
									        <td class="center">Destati Grounds</td>
									        <td class="center">Level 20 - 29</td>
									        <td class="center">Holy Stone Destruction</td>
								        </tr>
								        <tr>
									        <td class="center">Saotsi Grounds</td>
									        <td class="center">Level 30 - 39</td>
									        <td class="center">Zone Capture</td>
								        </tr>
								        <tr>
									        <td class="center">Xing Dio Grounds</td>
									        <td class="center">Level 40 - 49</td>
									        <td class="center">Annihilation</td>
								        </tr>
								        <tr>
									        <td class="center">Finasy Grounds</td>
									        <td class="center">Level 50 - 59</td>
									        <td class="center">Holy Stone Destruction</td>
								        </tr>
								        <tr>
									        <td class="center">Ye Kan Grounds</td>
									        <td class="center">Level 60 - 69</td>
									        <td class="center">Zone Capture</td>
								        </tr>
								        <tr>
									        <td class="center">Lena Tsou Grounds</td>
									        <td class="center">Level 70 - 79</td>
									        <td class="center">Annihilation</td>
								        </tr>
								        <tr>
									        <td class="center">Haibo Grounds</td>
									        <td class="center">Level 80 - 89</td>
									        <td class="center">Holy Stone Destruction</td>
								        </tr>
								        <tr>
									        <td class="center">Tulang Grounds</td>
									        <td class="center">Level 90 - 99</td>
									        <td class="center">Zone Capture</td>
								        </tr>
							        </tbody>
						        </table>
					        </div>

					        <div class="con_tit">DUEL SYSTEM</div>
					        <div class="con_text">
						        <ul>
							        <li>The Duel system allows players of the same faction to battle one another. Because dueling is a friendly contest, the defeated character does not respawn at their nearest spawn location, but rather they respawn where they fell.</li>
						        </ul>
					        </div>

					        <div class="img_text03">
						        <div class="l_text03">
							        <ul>
								        <li>Shift+Click another character.</li>
								        <li>Select "Duel" from the character menu.</li>
								        <li>Players must agree on the terms of the duel: Pills and Tablets allowed or prohibited.</li>
								        <li>Once begun, the character names of the participants will change.</li>
								        <li>Last one standing wins the battle!</li>
							        </ul>
						        </div>
						        <div class="r_img03"><img src="/resources/images/con_img/guide/pvp01.png" alt=""></div>
					        </div>

					        <div class="con_tit">HOLY STONE BATTLE</div>
					        <div class="con_text02">
						        <ul>
							        <li><strong>Capturing Faction Stones - </strong> <br />
								        Each Faction has a Faction Stone in their maps. This stone grants benefits to other Factions if captured, so it must be protected during invasion! 
								        <ul>
									        <li>Capturing and retrieving Faction Stones is allowed every day from 8PM to 9PM.</li>
									        <li>No standard or mission battles will be held during this time.</li>
									        <li>Capturing a Faction Stone grants benefits:</li>
									        <li>1 Faction Stone increases 10% Damage, if it is from another Faction.</li>
									        <li>1 Faction Stone increases 10% Faction’s Treasury accumulation.</li>
									        <li>Punishment for loss of Faction Stone</li>
									        <li>Master Level and above players lose 10% Damage to Monsters</li>
								        </ul>
							        </li>
						        </ul>
					        </div>
					        <div class="con_img02">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/pvp02.png" alt=""></li>
						        </ul>
					        </div>
					        <div class="con_text02">
						        <ul>
							        <li><strong>Guardian Shield </strong> <br />
								        Guardian Shields defend Faction Zones from invasion. Invading Factions must destroy "all Guardians in the Shield in order to move into the next zone." 
							        </li>
						        </ul>
					        </div>
				        </div><!-- -->
        				
        					
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
