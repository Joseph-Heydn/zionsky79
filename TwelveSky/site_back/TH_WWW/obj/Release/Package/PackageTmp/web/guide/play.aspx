<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="play.aspx.cs" Inherits="_12sky2.web.guide.play" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="play" />

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; <span class="now">การเล่นเกม</span></div>
					        <div class="page_tit">การเล่นเกม</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">LEVELING UP</div>
					        <div class="con_text">
						        <ul>
							        <li style="font-size:12px;">As your character gains Experience, you will also gain levels. Each level grants 5 Stat Points. Stat Points will affect each Faction differently (be sure to check out the Factions page for further details).</li>
						        </ul>
					        </div>
					        <div class="img_text01">
						        <div class="l_text01">
							        <ul>
								        <li>The Character Stats Screen will automatically open when your character gains a new level. You can choose to distribute all Stat Points into one Stat with the +5 button, or distrubute them individually. </li>
								        <li style="margin-top:10px;">Stat increases affect the following: </li>
								        <li style="margin-top:10px;">
									        <table cellspacing="0" cellpadding="0" class="C_table">
										        <caption></caption>
										        <colgroup>
											        <col width="30%" />
											        <col width="70%" />
										        </colgroup>
										        <tbody>
											        <tr>
												        <th class="center">Strength</th>
												        <td><p>Physical and Skill Damage</p><p>Attack Success Rate</p></td>
											        </tr>
											        <tr>
												        <th class="center">Dexterity</th>
												        <td><p>Chance to Dodge </p><p>Defense </p></td>
											        </tr>
											        <tr>
												        <th class="center">Vitality</th>
												        <td><p>Character Health  </p><p>Chance to Dodge </p></td>
											        </tr>
											        <tr>
												        <th class="center">Chi</th>
												        <td><p>Physical and Skill Damage</p></td>
											        </tr>
										        </tbody>
									        </table>
								        </li>
							        </ul>
						        </div>
						        <div class="r_img01"><img src="/resources/images/con_img/guide/play01.gif" alt="" /></div>
					        </div>

					        <div class="con_tit01">SKILL POINT</div>
					        <div class="con_text02">
						        <ul>
							        <li>Once a skill is learned, it can be assigned to the Shortcut Bar. Players can choose the default hotkeys 1-10 or switch to F1-F10.<br /> There are 3 Bars, toggled with "X" (forward) and "Z" (backward). 
								        <ul>
									        <li>Press "S" to open the character Skill window </li>
									        <li>Click and Drag the skill to the Shortcut Bar</li>
									        <li>Press the corresponding hotkey to use/activate </li>
									        <li>Note: Pills/Tablets can also be assigned to the Shortcut Bar.</li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="img_text01" style="margin-top:30px;">
						        <div class="l_text01">
							        <ul>
								        <li>Skill Points are gained with levels, and can be applied towards skills. At low levels, skills are learned through Weapon Trainers in the Faction home towns (see Factions for more information on the different weapon types). Weapon Trainers are located near the Faction Elder. </li>
								        <li style="margin-top:10px;">
									        <table cellspacing="0" cellpadding="0" class="C_table">
										        <caption></caption>
										        <colgroup>
											        <col width="30%" />
											        <col width="70%" />
										        </colgroup>
										        <tbody>
											        <tr>
												        <th class="center">Guanyin</th>
												        <td><p>Swordmaster Lupai</p> <p>Bladekeeper Ro</p> <p>Master Brus Li</p> </td>
											        </tr>
											        <tr>
												        <th class="center">Fujin</th>
												        <td><p>Katana Tutor Beitan</p> <p>Twinblade Phong</p> <p>Songsmith Seiren<p></td>
											        </tr>
											        <tr>
												        <th class="center">Jinong</th>
												        <td><p>Spearmaster Raji</p> <p>Bladelord Quon</p> <p>Scepter Adept Nao</p></td>
											        </tr>
										        </tbody>
									        </table>
								        </li>
							        </ul>
						        </div>
						        <div class="r_img01"><img src="/resources/images/con_img/guide/play02.png" alt="" /></div>
					        </div>

					        <div class="con_tit01">Using SKills</div>
					        <div class="con_text02">
						        <ul>
							        <li>Once a skill is learned, it can be assigned to the Shortcut Bar. Players can choose the default hotkeys 1-10 or switch to F1-F10.<Br /> There are 3 Bars, toggled with "X" (forward) and "Z" (backward).
								        <ul>
									        <li>Press "S" to open the character Skill window </li>
									        <li>Click and Drag the skill to the Shortcut Bar</li>
									        <li>Press the corresponding hotkey to use/activate </li>
									        <li>Note: Pills/Tablets can also be assigned to the Shortcut Bar.</li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="three_grid">
						        <div class="one_grid">
							        <ul>
								        <li>- Leveling Skills - </li>
								        <li>Once you have learned a skill, skill points can be applied directly to the skill's level without needing a Weapon Trainer.</li>
								        <li>Press the + to increase a skill's level. </li>
							        </ul>
						        </div>
						        <div class="m_img"><img src="/resources/images/con_img/guide/play03.png" alt="" /></div>
						        <div class="one_grid">
							        <ul>
								        <li>&nbsp;</li>
								        <li>- Skills must be re-assigned to the Shortcut Bar once their level is altered.</li>
								        <li>- Leveling down a skill (down button) can help preserve Chi when hunting monsters. </li>
							        </ul>
						        </div>
					        </div>

					        <div class="con_tit01">Portals</div>
					        <div class="con_text">
						        <ul>
							        <li>Travel between zones is commonly accomplished through use of Portals. These glowing transitions mark the entryways to the next area. <br /> However, this means that getting there is a bit of a walk.</li>
						        </ul>
					        </div>

					        <div class="con_tit01">GATE MASTERS</div>
					        <div class="img_text01">
						        <div class="l_text01" style="width:390px;">
							        <ul>
								        <li>Gate Masters provide instantaneous travel. While this method is not free (costing a small amount of Silver), it is reliable and efficient. Travel through the Gate Masters is available the following locations:</li>
							        </ul>
							        <ul style="margin-top:20px;">
								        <li>First four Faction Maps</li>
								        <li>Saigo Temple</li>
								        <li>Two Master Maps</li>
							        </ul>
						        </div>
						        <div class="r_img01"><img src="/resources/images/con_img/guide/play04.png" alt="" /></div>
					        </div>

					        <div class="con_tit01">SCROLLS AND SKILLS</div>
					        <div class="img_text02">
						        <div class="l_img02"><img src="/resources/images/con_img/guide/play05.png" alt="" /></div>
						        <div class="r_text02">
							        <ul>
								        <li>All Factions can learn a skill that increases speed. While the name varies, the symbol is the same for all Factions. This greatly increases movement speed, though it consumes Chi. Various scrolls also aid travel. Return Scrolls provide a quick return to the character's Faction city, and various Teleport scrolls move you to specific zones and even to your friends within a zone.</li>
							        </ul>
						        </div>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>The Master-Apprentice system allows players of Master level (M1 and up) to assist lower level players.(112 and below)</li>
						        </ul>
					        </div>

					        <div class="con_tit01">MASTER -APPRENTICE REQUEST</div>
					        <div class="img_text01">
						        <div class="l_text02">
							        <ul>
								        <li>Initiating the M-A System is simple. Once a player reaches Master level, they can Shift+Click on a player level 112 or below and select "M-A Req."</li>
								        <li style="margin-top:20px;"><strong>Benefits:</strong>
									        <ul>
										        <li>Master - Merit points will be awarded to the Master according to the Experience the Apprentice gains. They will also gain Experience from the Apprentice's kills.(must be in range)</li>
										        <li>Apprentice - 1.5x Exp when killing monsters</li>
									        </ul>
								        </li>
							        </ul>
						        </div>
						        <div class="r_img01"><img src="/resources/images/con_img/guide/play06.png" alt="" /></div>
					        </div>

				        </div><!-- //content page -->
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
