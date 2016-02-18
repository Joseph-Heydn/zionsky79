<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="requirements.aspx.cs" Inherits="_12sky2.web.guide.requirements" %>

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
		            <left:layout id="left" runat="server" setTITL="Game Guides" setSUB_TITL="requirements" />
		            
			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; แนะนำเกม &gt; <span class="now">ข้อกำหนดของระบบ</span></div>
					        <div class="page_tit">ข้อกำหนดของระบบ</div>
					        <div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_table">
						        <table cellspacing="0" cellpadding="0" class="C_table">
							        <caption></caption>
							        <colgroup>
								        <col width="10%" />
								        <col width="35%" />
								        <col width="55%" />
							        </colgroup>
							        <thead>
								        <tr>
									        <th>&nbsp;</th>
									        <th>Minimum System Requirement</th>
									        <th>Recommended System Requirement</th>
								        </tr>
							        </thead>
							        <tbody>
								        <tr>
									        <th>OS</th>
									        <td colspan="2" class="center">Windows (R) xp/2000 <br />(Windows Vista not officially supported. Operation n 64bit edition not guaranteed)</td>
								        </tr>
								        <tr>
									        <th>CPU</th>
									        <td class="center">Pentium III 800mhz</td>
									        <td class="center">Pentium IV 2.4 ghz</td>
								        </tr>
								        <tr>
									        <th>Memory</th>
									        <td class="center">Memory</td>
									        <td class="center">1GB</td>
								        </tr>
								        <tr>
									        <th>Hard Drive</th>
									        <td colspan="2" class="center">3 Gb free hard-drive space</td>
								        </tr>
								        <tr>
									        <th>Video Card</th>
									        <td class="center">GeForce FX 5200 or <br />Radeon 7600 64mb</td>
									        <td class="center">GeForce FX 5600 or <br />Radeon 9550 128mb</td>
								        </tr>
								        <tr>
									        <th>Direct X</th>
									        <td colspan="2" class="center">DirectX 9.0 Compatible sound card</td>
								        </tr>
								        <tr>
									        <th>Network</th>
									        <td class="center">Broadband Internet Connnection</td>
									        <td class="center">Broadband Internet Connnection with average ping time less than 90 ms to our website</td>
								        </tr>
							        </tbody>
						        </table>
					        </div>
					        <div class="con_text">
						        <ul>
							        <li>ติดตั้ง TwelveSky2 WSP ต้องประมาณ 1.7GB ของพื้นที่ว่าง (แต่ระบบของคุณควรมีข้อมูลเพิ่มเติม) บนฮาร์ดดิสก์ของคุณและเชื่อมต่อเครือข่ายอินเทอร์เน็ตความเร็วสูง เมื่อต้องการดูพื้นที่ว่างดิสก์ปัจจุบันบนคอมพิวเตอร์ของคุณ คลิกสองครั้งที่ไอคอน 'คอมพิวเตอร์ของฉัน' บนเดสก์ท็อปของคุณ</li>
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
