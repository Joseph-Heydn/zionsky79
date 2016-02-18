<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="player.aspx.cs" Inherits="_12sky2.web.guide.player" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="player" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">Player Interaction</span></div>
					        <div class="page_tit">Player Interaction</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">COMMUNICATIONS AND CHAT</div>
					        <div class="con_text">
						        <ul>
							        <li>Chatting with other players can help you learn new strategies, better hunting areas, as well as helping you find someone to buy or sell an item. Chat has many functions, and so it has been divided in different sections to make all of these functions easier.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>This is the chat bar, which appears in the lower left corner of the game screen.</li>
						        </ul>
					        </div>
					        <div class="con_img02">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/player01.png" alt=""></li>
						        </ul>
					        </div>
					        <div class="con_text02">
						        <ul>
							        <li><strong>Different Chat Modes </strong>
								        <ul>
									        <li>Normal: Normal chat has a very short range. This is good to use to say hello to another member of your Faction that you meet while hunting monsters, since it won't go any further than visual range.</li>
									        <li>Party: When in a party, players can use Party chat in order to chat with each other regardless of zone. Only party members will see this chat.</li>
									        <li>Guild: Guild chat is similar to Party chat, in that all Guild members can chat with each other regardless of zone. However, Parties are limited to 5 and are temporary,	while Guilds have a much larger limit and generally last for a longer duration.</li>
									        <li>Faction: Faction chat allows players to chat with other members of their Faction within the same zone. All Faction members in the zone can read this type of chat.</li>
									        <li>Shout: Only usable in Saigo Temple. Members of all Factions can read this chat, so it is often used for trade purposes.</li>
									        <li>Whisper: A player can type in a character name next to the word "whisper" in order to send a message to one specific person. Whispers can be blocked through the Options Menu (Esc).</li>
								        </ul>
							        </li>
						        </ul>
					        </div>
        					
					        <div class="con_tit01">FRIENDS LIST</div>

					        <div class="img_text03">
						        <div class="l_text03" style="width:370px; margin-right:20px;">
							        <ul class="text_003">
								        <li style="margin-left:-10px;">The Friend List is a quick way to check for other players online.</li>
							        </ul>
							        <ul>
								        <li>To add someone, first Shift+Click, then press "Friend Req."</li>
								        <li>A player must accept the Friend Request, otherwise they will not be added to the Friend List</li>
								        <li>The Friend List can be accessed by pressing the letter F on the keyboard.</li>
								        <li>To remove someone, click the Select button next to their name, then click the Remove button in the Friend List.</li>
							        </ul>
							        <ul class="text_003">
								        <li style="margin-left:-10px;">* NOTE * It's considered polite to ask first! </li>
							        </ul>
						        </div>
						        <div class="r_img03"><img src="/resources/images/con_img/guide/player02.png" alt=""></div>
					        </div>

					        <div class="con_tit01">PARTY SYSTEM</div>
					        <div class="con_text02">
						        <ul>
							        <li>Teaming up to fight monsters, as well as other players, has several benefits. It not only helps develop strategy, but some skills can only be used with a full party, and all players in a party gain an exp boost. </li>
							        <li style="margin-top:20px;"><strong>Party Notes:</strong></li>
						        </ul>
						        <ul>
							        <li>
								        <ul>
									        <li>To invite another player into a Party, Shift+Click and select "Party"</li>
									        <li>Maximum Party members is 5</li>
									        <li>Exp reward increases proportionate to party size - 20% to 50%</li>
									        <li>Exp reward is based on exp rate of the monster killed</li>
									        <li>Formation Skills can only be used in a complete party</li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="con_text" style="margin-top:20px;">
						        <ul>
							        <li><strong>GUILD SYSTEM </strong> <br /></li>
							        <li>Once a player reaches level 30, they are able to create a Guild. There are 5 guild levels, and each has specific requirements as well as additional privileges. A Guild must be completely full (maximum members) before it can be expanded to the next rank.
							        </li>
						        </ul>
					        </div>

					        <div class="con_tit01">Guild Rank : Squad</div>
					        <div class="con_text01">
						        <ul>
							        <li>Guild Leader
								        <ul>
									        <li>Requirements : Level 30  </li>
								        </ul>
							        </li> 
							        <li>Cost : 10 Million Silver </li>
							        <li>Maximum Members : 10  </li>
							        <li>Guild Abilities (retained a thigher levels)  
								        <ul>
									        <li>Guild Chat  </li>
									        <li>Public Notice</li>
									        <li>Guild Member Dismissal</li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="con_tit01">Guild Rank : Group</div>
					        <div class="con_text03">
						        <ul>
							        <li>Guild Leader
								        <ul>
									        <li>Requirements : 100 +CP</li>
								        </ul>
							        </li> 
							        <li>Cost : 10 Million Silver </li>
							        <li>Maximum Members : 20  </li>
							        <li>Guild Abilities (retained a thigher levels)  
								        <ul>
									        <li>Guild Notification</li>
								        </ul>
							        </li>
						        </ul>
					        </div>
					        <div class="r_img01"><img src="/resources/images/con_img/guide/player03.png" alt="" width="200"></div>

					        <div class="con_tit01">Guild Rank : Sect</div>
					        <div class="con_text01">
						        <ul>
							        <li>Guild Leader
								        <ul>
									        <li>Requirements : 500 +CP </li>
								        </ul>
							        </li> 
							        <li>Cost : 20 Million Silver </li>
							        <li>Maximum Members : 30  </li>
							        <li>Guild Abilities (retained a thigher levels)  
								        <ul>
									        <li>Appoint Vice Guild Leader  </li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="con_tit01">Guild Rank : House  </div>
					        <div class="con_text01">
						        <ul>
							        <li>Guild Leader
								        <ul>
									        <li>Requirements : 1000 +CP  </li>
								        </ul>
							        </li> 
							        <li>Cost : 30 Million Silver </li>
							        <li>Maximum Members : 40  </li>
							        <li>Guild Abilities (retained a thigher levels)  
								        <ul>
									        <li>Grant Title    </li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="con_tit01">Guild Rank : House    </div>
					        <div class="con_text01">
						        <ul>
							        <li>Guild Leader
								        <ul>
									        <li>Requirements : 5000 +CP  </li>
								        </ul>
							        </li> 
							        <li>Cost : 50 Million Silver </li>
							        <li>Maximum Members : 50  </li>
							        <li>Guild Abilities (retained a thigher levels)  
								        <ul>
									        <li>from house chief to house Master </li>
								        </ul>
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
