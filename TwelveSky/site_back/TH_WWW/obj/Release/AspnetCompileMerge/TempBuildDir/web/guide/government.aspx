<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="government.aspx.cs" Inherits="_12sky2.web.guide.government" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="government" />
		            
                    <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; <span class="now">รัฐบาล</span></div>
					        <div class="page_tit">รัฐบาล</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">รัฐบาล</div>
					        <div class="con_text">
						        <ul>
							        <li><strong>Faction Leader</strong></li>
							        <li>It is always a time of war, and so each Faction elects a Leader among themselves to stand against the merciless onslaught of enemies. 
							        Warriors vote for those they feel best able to lead, and in the end, only one stands as Leader. Each Faction Leader serves a term of 30 days.</li>
						        </ul>
					        </div>
        					

					        <div class="con_tit01">Duties and Responsibilities</div>
					        <div class="con_text03">
						        <ul>
							        <li>Faction Notice: Grants the ability to send a notice to all Faction members across all maps. This aids in coordination of Faction activities.</li>
							        <li>Appointing Vice Faction Leaders: A Faction Leader can appoint up to 12 Vice Faction Leaders. Candidates for VFL must be M1+ and have over 1,000 CP.</li>
							        <li>Faction Treasury: The Faction Leader can  withdraw Silver if there are more than 3 Vice Faction Leaders appointed.</li>
							        <li>Faction Catapult: Can be purchased at the Elder and placed in maps prior to Yanggok Valley, with a maximum of 5 per map. VFLs can also purchase Faction Catapults.</li>
						        </ul>
					        </div>
					        <div class="r_img01"><img src="/resources/images/con_img/guide/gov01.png" alt="" width="200"></div>

					        <div class="con_tit01">Faction Leader Voting</div>
					        <div class="con_text01">
						        <ul>
							        <li>Day 1 to 5: Candidate Regsitration
								        <ul>
									        <li>Must be M1 or above</li>
									        <li>Must have over 1,000 CP</li>
								        </ul>
							        </li> 
							        <li>Day 6 to 10: Voting Period
								        <ul>
									        <li>Voters must be M1 or above</li>
								        </ul>
							        </li>
							        <li>Day 11: Tallying Votes  
								        <ul>
									        <li>Vote Points: 1 to 33</li>
									        <li>M1 = 1 Points</li>
									        <li>M33 = 33 Points</li>
								        </ul>
							        </li>
							        <li>Day 11: Faction Leader Announced  
								        <ul>
									        <li>Occurs at 9pm</li>
									        <li>All prior FLs and VFLs will have status removed</li>
								        </ul>
							        </li>
						        </ul>
					        </div>

					        <div class="con_tit01">Faction Alliances</div>
					        <div class="con_text">
						        <ul>
							        <li>Faction Leaders of two factions may come to terms of peace if a third faction's strength becomes too overwhelming. 
							        Faction Alliances present many benefits to weaker factions.</li>
						        </ul>
					        </div>

					        <div class="con_text03">
						        <ul class="bold">
							        <li>Alliance Requirements</li>
						        </ul>
						        <ul>
							        <li>Faction Points must be over 100</li>
							        <li>The Strongest Faction cannot enter an Alliance</li>
						        </ul>
						        <ul class="bold" style="margin-top:10px;">
							        <li>Peace Negotiations (Alliance Creation)</li>
						        </ul>
						        <ul>
							        <li>Faction Leaders must meet in Saigo Temple</li>
							        <li>Alliance begins 60 seconds after two Faction Leaders stand at the Alliance Altar.<br/ > 
							         (Alliance is ended the same way and no further Alliance allowed for the two factions within 2 weeks afterward)</li>
						        </ul>
					        </div>
					        <div class="r_img01"><img src="/resources/images/con_img/guide/gov02.png" alt="" width="200"></div>
        				    
					        <div class="con_tit01">Alliance Effects</div>
					        <div class="con_text01">
						        <ul>
							        <li>Faction Points are summed together</li>
							        <li>Party and Chat are allowed between Allied Factions</li>
							        <li>PvP is not allowed between Allied Factions (except by Duel)</li>
							        <li>Alliance Stone generated in each Faction's home city</li>
							        <li>Shared benefits of captured Faction Stones</li>
						        </ul>
					        </div>

        					
        					
				        </div><!-- -->
        				
        					
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>	
				    </div>		        
			    </div>                
            </div>
        
            <tail:layout id="tail" runat="server" /> 
        </div> 
    </form>
</body>
</html>
