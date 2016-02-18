<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="story.aspx.cs" Inherits="_12sky2.web.guide.story" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="story" />
			        
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">Story</span></div>
					        <div class="page_tit">Story</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">History of the Nangin</div>
					        <div class="con_text">
						        <ul>
							        <li>Many years ago the country was ruled by the Twelve Legions. Their reign was brutal and harsh. Most knew little more than poverty and oppression, unable to claim mastery over their own lives. However, they were not unopposed. In the far northern region a leader openly opposed the cruelty inflicted upon the people, the Legacy Swordsman, Lord Chen. His Faction was the Nangin; one of the most prominent Factions in the Realm. It was during a fierce uprising, when one of the southern tribes began fighting back against the tyranny of the Legion Lord controlling their territory, that Lord Chen decided to put an end to the evil grip of the Twelve Legions. There had been many legends about the incredible abilities of the twelve High Masters, and about the sacred stones that were shared with the Twelve Legions. These stones, it was said, gave the Legions their powerful hold over the people. Lord Chen devised a plan to take back the control of the sacred shards and combine them once again, because they could grant the Nangin enough power to finally put an end to the inhuman suffering of the people.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>The battle was feared to last decades, yet it ended within only a few days. The power of Chen's sword was too great, even against the combined effort of the other Legions. Peace finally came to a nation that had for so long only knew pain and suffering. In the years that followed, the nation flourished under the watchful eyes of the Nangin. then one catastrophic morning, it all ended. The great Mountain Yunfeng Shan heaved a great plume of smoke, and against that fury the realm of the Nangin was engulfed.</li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>For years the people had believed the Legacy Swordsman and the rest of the Nangin had perished in that fatal blast, and with the loss of Lord Chen the land was left without a leader. Once again the 12 legions rose, but without the power of the shards that they had once possessed, they could no longer control the tides of war, and the land began to bleed as the cries of its people spread.</li>
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
