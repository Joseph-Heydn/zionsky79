<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="item.aspx.cs" Inherits="_12sky2.web.guide.item" %>

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
                    <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="item" />
                    
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; <span class="now">รายการไอเท็ม</span></div>
					        <div class="page_tit">รายการไอเท็ม</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">Item Acquisition</div>
					        <div class="con_text">
						        <ul>
							        <li>There are two basic methods of acquiring items. The first is through NPCs. Players can use Silver (the TwelveSky2 WSP in-game currency) to purchase basic equipment from shopkeepers in their Faction's home town. Second is from hunting and killing monsters to gain a wider variety and rarities of goods.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Other Methods</li>
							        <li>While players will most likely encounter the two above methods first, they can also attain items through trading with other players, or purchasing from another player's personal store.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Item Rarities</li>
							        <li><strong>Common:</strong> Denoted with white text, lowest quality (items purchased at NPCs are typically Common).</li>
							        <li><strong>Unique:</strong> Denoted with orange text, moderate quality.</li>
							        <li><strong>Rare:</strong> Denoted with yellow text, high quality.</li>
							        <li><strong>Elite:</strong> Denoted with purple text, highest quality.</li>
						        </ul>
					        </div>

					        <div class="con_tit01">Item Improvements</div>
					        <div class="con_text">
						        <ul>
							        <li>Enchanting Items</li>
							        <li>Equipment can be enchanted to offer a higher bonus to the character. Success leads to a % increase based on the material, but failure can lead to a 3% loss or even item destruction.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>NPC: Blacksmith</li>
							        <li>Maximum Enchant: 120%</li>
							        <li>Enchanting Materials:</li>
							        <li style="margin-left:20px;">3% - Tin</li>
							        <li style="margin-left:20px;">6% - Dark Steel</li>
							        <li style="margin-left:20px;">9% - Black Steel</li>
							        <li style="margin-left:20px;">12% - Steel of Eternity</li>
						        </ul>
					        </div>
					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="C_table01">
							        <caption></caption>
							        <colgroup>
								        <col width="35%" />
								        <col widht="35%" />
								        <col widht="30%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th>Equipment</th>
									        <th>Increase</th>
									        <th style="background:#fff;">&nbsp;</th>
								        </tr>
							        </thead>
							        <tbody>
								        <tr>
									        <td class="center">Weapon</td>
									        <td class="center">Damage</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Armor</td>
									        <td class="center">Defense</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Gloves</td>
									        <td class="center">Chance to Hit</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Boots</td>
									        <td class="center">Dodge</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Cape</td>
									        <td class="center">Defense</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Ring</td>
									        <td class="center">Deadly</td>
									        <td>&nbsp;</td>
								        </tr>
								        <tr>
									        <td class="center">Amulet</td>
									        <td class="center">Luck</td>
									        <td>* 15% - Gold of Eternity</td>
								        </tr>
							        </tbody>
						        </table>
					        </div>

					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="C_table01">
							        <caption></caption>
							        <colgroup>
								        <col width="33%" />
								        <col widht="33%" />
								        <col widht="33%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th>Phase</th>
									        <th>Combine Cost</th>
									        <th>Success Rate</th>
								        </tr>
							        </thead>
							        <tbody>
								        <tr>
									        <td class="center">CS 1</td>
									        <td class="center">1 Million</td>
									        <td class="center">65%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 2</td>
									        <td class="center">1.5 Million</td>
									        <td class="center">60%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 3</td>
									        <td class="center">2 Million</td>
									        <td class="center">55%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 4</td>
									        <td class="center">2.5 Million</td>
									        <td class="center">50%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 5</td>
									        <td class="center">3 Million</td>
									        <td class="center">45%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 6</td>
									        <td class="center">3.5 Million</td>
									        <td class="center">40%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 7</td>
									        <td class="center">4 Million</td>
									        <td class="center">35%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 8</td>
									        <td class="center">4.5 Million</td>
									        <td class="center">30%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 9</td>
									        <td class="center">5 Million</td>
									        <td class="center">25%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 10</td>
									        <td class="center">5.5 Million</td>
									        <td class="center">20%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 11</td>
									        <td class="center">6 Million</td>
									        <td class="center">15%</td>
								        </tr>
								        <tr>
									        <td class="center">CS 12</td>
									        <td class="center">6.5 Million</td>
									        <td class="center">10%</td>
								        </tr>
							        </tbody>
						        </table>
					        </div>

					        <div class="con_tit01">Item Combination</div>
					        <div class="con_text">
						        <ul>
							        <li>Another method of item improvement is combining items. Items that have the rarity Rare or Elite can be combined with other items of the same type and rarity (Elite items can also combine with Rare items one step lower). NPC: Blacksmith</li>
							        <li>* NOTE * </li>
							        <li>"The equipment being combined into the target item cannot have an enchantment percent or combine stage."</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li><strong>Combining Equipment Increases the Following:</strong></li>
							        <li style="margin-left:20px;">Weapons: Damage and Chance to hit</li>
							        <li style="margin-left:20px;">Armor: Defense and Dodge</li>
							        <li style="margin-left:20px;">Gloves: Defense and Chance to hit</li>
							        <li style="margin-left:20px;">Boots: Defense and Dodge</li>
							        <li style="margin-left:20px;">Rings: Elemental Damage</li>
							        <li style="margin-left:20px;">Necklaces: Elemental Defense</li>
							        <li style="margin-left:20px;">Capes: Defense</li>
						        </ul>
					        </div>

					        <div class="con_tit01">Item Crafting</div>
					        <div class="con_text">
						        <ul>
							        <li>Crafting consists of using multiple lower quality items to create an item of higher quality. Currently players have the option to combine a few different materials.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>NPCs:</li>
							        <li>Blacksmith - Enchanting Materials and Jades</li>
							        <li>Elder - Archives</li>
						        </ul>
					        </div>

					        <div class="box_text">
						        <ul class="left">
							        <li>Red Jade</li>
						        </ul>
						        <ul class="center">
							        <li>Purple Jade x2</li>
						        </ul>
					        </div>
					        <div class="box_text">
						        <ul class="left">
							        <li>Random Ench. Material</li>
						        </ul>
						        <ul class="center">
							        <li>Tin x4</li>
						        </ul>
					        </div>
					        <div class="box_text">
						        <ul class="left">
							        <li>Heaven's Repulsion</li>
						        </ul>
						        <ul class="center">
							        <li>Gold Archive</li>
							        <li>Wood Archive</li>
							        <li>Lightning Archive</li>
							        <li>Fire Archive</li>
						        </ul>
					        </div>
					        <div class="box_text">
						        <ul class="left">
							        <li>Heaven's Flow </li>
						        </ul>
						        <ul class="center">
							        <li>Damnation Archive</li>
							        <li>Phantom Archive</li>
							        <li>Soul Archive</li>
							        <li>Star Archive</li>
						        </ul>
					        </div>

					        <div class="con_tit01">Item Upgrade / Downgrade</div>
					        <div class="con_text">
						        <ul>
							        <li>TwelveSky2 WSP has the option to increase or decrease an item's level. This is handy if you have spent time, silver, and effort improving your equipment, or if you find a piece of equipment several levels too high for your character.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>NPC: Beggar</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>Requires Purple or Red Jade</li>
						        </ul>
					        </div>
					        <div class="con_text_img">
						        <ul>
							        <li class="l_text">Item must be Rare (yellow item name) or Elite (purple item name) Cost to change the level increases with the item's level</li>
							        <li class="r_img"><img src="/resources/images/con_img/guide/item01.png" alt="" /></li>
						        </ul>
					        </div>
					        <div class="con_text_img">
						        <ul>
							        <li class="l_text">To upgrade an item, it must have at least 12% Enchant and at least 1 Combine Stage.</li>
							        <li class="r_img"><img src="/resources/images/con_img/guide/item02.png" alt="" /></li>
						        </ul>
					        </div>
					        <div class="con_text_img">
						        <ul>
							        <li class="l_text">Successful upgrades will remove half of the CS. Purple Jades will also remove up to 33% of the current Enchant.</li>
							        <li class="r_img"><img src="/resources/images/con_img/guide/item03.png" alt="" /></li>
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
