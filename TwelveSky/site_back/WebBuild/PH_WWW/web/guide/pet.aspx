<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pet.aspx.cs" Inherits="_12sky2.web.guide.pet" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="pet" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; Game Guides &gt; <span class="now">Pet Information</span></div>
					        <div class="page_tit">Pet Information</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_tit">PETS</div>
					        <div class="con_text">
						        <ul>
							        <li>Pets provide a wide variety of bonuses to characters. However, they must be fed Heavenly Fruit for these bonuses to take effect, as well as to gain Experience.</li>
						        </ul>
					        </div>
					        <div class="center_img">
						        <ul class="tit">
							        <li>Vespida Wasp</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet01.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: 1</li>
							        <li>Bonus: Increases Attack </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Cabochon Relic</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet02.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: 1</li>
							        <li>Bonus: Increases Defense</li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Feng Demon</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet03.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: 1</li>
							        <li>Bonus: Increases Health </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Imperial Moth</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet04.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: 1</li>
							        <li>Bonus: Increases Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Karabos Scarab</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet05.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Attack and Defense</li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Lamillar Owl</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet06.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Attack and Health </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Bainfu Bat</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet07.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Attack and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Turtalias Shell</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet08.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Defense and Health</li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Jade Kirin</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet09.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Defense and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Pinyin Spirit</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet10.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M1</li>
							        <li>Bonus: Increases Health and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Grace Falchion</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet11.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M15</li>
							        <li>Bonus: Increases Attack, Defense, and Health </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Emperor Phoenix</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet12.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M15</li>
							        <li>Bonus: Increases Attack, Defense, and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Siwang Dragon</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet13.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M15</li>
							        <li>Bonus: Increases Attack, Health, and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Geier Vulture</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet14.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Required Character Level: M15</li>
							        <li>Bonus: Increases Defense, Health, and Chi </li>
						        </ul>
					        </div>

					        <div class="center_img">
						        <ul class="tit">
							        <li>Verita Leviathan</li>
						        </ul>
						        <ul class="c_img">
							        <li><img src="/resources/images/con_img/guide/pet15.png" alt="" /></li>
						        </ul>
						        <ul class="b_text">
							        <li>Bonus: Increases Attack, Defense, Health, and Chi </li>
						        </ul>
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
