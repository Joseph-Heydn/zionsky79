<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nangin.aspx.cs" Inherits="_12sky2.web.guide.nangin" %>

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
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; ชั้นข้อมูล &gt; <span class="now">Nangin</span></div>
					        <div class="page_tit">ชั้นข้อมูล-Nangin</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="page_tab">
						        <div class="tab">
							        <ul>
								        <li><a href="/web/guide/info.aspx">GuanyIn</a></li>
								        <li><a href="/web/guide/fujin.aspx">Fujin</a></li>
								        <li><a href="/web/guide/jinong.aspx">Jinong</a></li>
								        <li class="on"><a href="/web/guide/nangin.aspx">Nangin</a></li>
							        </ul>
						        </div>
					        </div>
					        <div class="con_tit02">Nangin</div>
					        <div class="con_img02">
						        <ul>
							        <li><img src="/resources/images/con_img/guide/nangin01.png" alt="" /></li>
						        </ul>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>จะประกอบด้วยสมาชิกจากฝ่ายหลัก 3 ต้นแบบ.จะได้รับเลือกให้เข้าร่วม Nangin และติดตามจากสมาคมของพวกเขา เพื่อน และที่ดินเพื่อทำตามอและออกจากพื้นที่ Nanginตัวเลือกการสมัคสมาชิกที่มีอู่ย.</li>
						        </ul>
					        </div>
        					
					        <div class="con_tit02">ข้อมูลอักขระ</div>
					        <div class="con_text01">
						        <ul>
							        <li>City: Taitu Fortress </li>
							        <li>อาวุท: สำหรับนางอินสามารถเอาอาวุทของคนที่เปลื่ยนเข้ามาเล่นได้เหมือนเดิม</li>
							        <li>Gate Master: Vuo</li>
						        </ul>
					        </div>

					        <div class="con_tit01">Joining the Nangin</div>
					        <div class="img_text">
						        <div class="l_img01"><img src="/resources/images/con_img/guide/nangin02.png" alt="" /></div>
						        <div class="r_text01">
							        <ul>
								        <li>Once you reach M1, you gave the option to join the Nangin. This choice means breaking all bonds with your former Faction and live in exile.  
									        <ul>
										        <li>Must be master level 1 or above Faction points must be over 100 Must breaks ties with Guild and clear Friends list. Speak to the Guardian of your Faction (in Palace) Declare Allegiance to the Nangin</li>
									        </ul>
								        </li>
							        </ul>
						        </div>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>**NOTE**</li>
							        <li>Faction Leaders and Vice Faction Leaders cannot declare Nangin allegiance. They must wait until their term expires.</li>
						        </ul>
					        </div>
        					

				        </div> <!--// content page -->
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top" /></a>
				        </div>
			        </div>
		        </div> <!-- container -->			        
	        </div><!-- wrap -->
        
            <tail:layout id="tail" runat="server" /> 
        </div> 			        
    </form>			        
    </form>
</body>
</html>
