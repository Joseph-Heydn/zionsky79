<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="info.aspx.cs" Inherits="_12sky2.web.guide.info" %>

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
                    <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="info" />
                    
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; ชั้นข้อมูล &gt; <span class="now">ชั้นข้อมูล</span></div>
					        <div class="page_tit">ชั้นข้อมูล-Guanyin</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="page_tab">
						        <div class="tab">
							        <ul>
								        <li class="on"><a href="/web/guide/info.aspx">GuanyIn</a></li>
								        <li><a href="/web/guide/fujin.aspx">Fujin</a></li>
								        <li><a href="/web/guide/jinong.aspx">Jinong</a></li>
								        <li><a href="/web/guide/nangin.aspx">Nangin</a></li>
							        </ul>
						        </div>
					        </div>
					        <div class="con_tit02">Guanyin</div>
					        <div class="con_img02">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/guanyin01.png" alt="" /></li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>นักรบGuanyinเป็นฝ่ายเงียบสงบ เชื่อในความกลมกลืนและความสมดุล นี้มักจะเกิดศัตรูประมาทพวกเขา สมมุติว่า จะอ่อนแอ อย่างไรก็ตาม ไม่มีอะไรอ่อนในนักรบเหล่านี้ และพวกเขาแสดงให้เห็นว่าสมดุลจุดแข็ง!</li>
						        </ul>
					        </div>
        					
					        <div class="con_tit02">ข้อมูลอักขระ</div>
					        <div class="con_text01">
						        <ul>
							        <li>City: Kailan Fortress </li>
							        <li>อาวุท: 
								        <ul>
									        <li>Sword</li>
									        <li>Blade</li>
									        <li>Marble</li>
								        </ul>
							        </li>
							        <li>Gate Master: Rei </li>
						        </ul>
					        </div>

					        <div class="con_tit01">How Stats Affect Performance</div>
					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="C_table">
							        <caption></caption>
							        <colgroup>
								        <col width="10%" />
								        <col width="20%" />
								        <col width="20%" />
								        <col width="10%" />
								        <col width="20%" />
								        <col width="20%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th colspan="6">+ Attack Success Rate (1.71)</th>
								        </tr>
							        </thead>
							        <tbody>
								        <tr>
									        <th>Strength</th>
									        <td class="b_none"><p>+Damage</p><p>+Damage</p><p>+Damage</p></td>
									        <td><p>Sword: 2.65</p><p>Blade: 2.80</p><p>Marble: 2.51</p></td>
									        <th>Dexterity</th>
									        <td colspan="2"><p>+ Defense (1.63)</p><p>+ Chance to Dodge (1.67)</p></td>
								        </tr>
								        <tr>
									        <th rowspan="2">Vitality</th>
									        <td rowspan="2" colspan="2"><p>+ Health (20.0) </p><p>+ Chance to Dodge (0.90)</p></td>
									        <th rowspan="2">Chi</th>
									        <td colspan="2">+ Character Chi (15.31)</td>
								        </tr>
								        <tr>
									        <td class="b_none"><p>+Damage</p><p>+Damage</p><p>+Damage</p></td>
									        <td><p>Sword:1.43</p><p>Blade:1.51</p><p>Marble:1.35</p></td>
								        </tr>
							        </tbody>
						        </table>
					        </div>

					        <div class="con_tit01">Guanyinชนิดขอองอาวุท</div>
					        <div class="img_text">
						        <div class="l_img"><img src="/resources/images/con_img/guide/guanyin02.png" alt="" /></div>
						        <div class="r_text">
							        <ul>
								        <li>Sword
									        <ul>
										        <li>Trainer: Swordmaster Lupai</li>
										        <li>While the Sword does not gain as high of a damage bonus from Stats, the weapon-specific buff for the Sword makes up for that deficiency.</li>
										        <li>Type: Melee </li>
									        </ul>
								        </li>
							        </ul>
						        </div>
					        </div>
					        <div class="img_text">
						        <div class="l_img"><img src="/resources/images/con_img/guide/guanyin03.png" alt="" /></div>
						        <div class="r_text">
							        <ul>
								        <li>Blade
									        <ul>
										        <li>Trainer: Bladekeeper Ro</li>
										        <li>The blade gains the most damage benefit from Stats.</li>
										        <li>Type: Melee </li>
									        </ul>
								        </li>
							        </ul>
						        </div>
					        </div>
					        <div class="img_text">
						        <div class="l_img"><img src="/resources/images/con_img/guide/guanyin04.png" alt="" /></div>
						        <div class="r_text">
							        <ul>
								        <li>Marble
									        <ul>
										        <li>Trainer: Master Brus Li </li>
										        <li>Marbles gain the least amount of damage bonus from Stats. However, their range easily compensates.</li>
										        <li>Type: Ranged </li>
									        </ul>
								        </li>
							        </ul>
						        </div>
					        </div>

				        </div> <!--// content page -->
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top" /></a>
				        </div>
			        </div>
		        </div> <!-- container -->                
            </div>
        
            <tail:layout id="tail" runat="server" /> 
        </div> 
    </form>
</body>
</html>
