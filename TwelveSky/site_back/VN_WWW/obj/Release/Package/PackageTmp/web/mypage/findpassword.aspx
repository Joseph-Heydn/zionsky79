<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="findpassword.aspx.cs" Inherits="_12sky2.web.mypage.findpassword" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<common:layout id="common" runat="server"/>
</head>

<body>
<form id="form1" runat="server">
	<div id="main_bg">
		<div id="wrap">
			<head:layout id="head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<div class="lnb">
					<div class="lnb_tit">My Page</div>
					<div class="left_menu">
						<ul>
							<li>
								<a href="/web/mypage/findid.aspx">
									<asp:Literal runat="server" meta:resourcekey="lbl_findIdent"/>
								</a>
							</li>
							<li>
								<a href="/web/mypage/findpassword.aspx" class="on">
									<asp:Literal runat="server" meta:resourcekey="lbl_findPass"/>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt; My Page &gt;
							<span class="now"><asp:Literal runat="server" meta:resourcekey="lbl_findPass"/></span>
						</div>
						<div class="page_tit">
							<asp:Literal runat="server" meta:resourcekey="lbl_findPass"/>
						</div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="message_box" id="CheckMessage" style="display:none;">
							<asp:Literal runat="server" meta:resourcekey="lbl_InputEmail"/>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_loginInfo"/></li>
							</ul>
						</div>
						<div class="profile">
							<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
								<table cellspacing="0" cellpadding="0" class="C_table01">
									<colgroup>
										<col width="30%"/>
										<col width=""/>
									</colgroup>
									<tbody>
										<tr>
											<th class="b_none">
												<span class="red_02">*</span><asp:Literal runat="server" meta:resourcekey="lbl_emailAddr"/>
											</th>
											<td>
												<asp:TextBox id="USER_ID" runat="server" Width="240"></asp:TextBox>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<captcha:common id="Common1" runat="server"/>

						<p class="t_center">
							<span class="btn_type" id="ModifyButton">
								<asp:LinkButton id="btn_submit" OnClick="btn_submit_Click" runat="server" meta:resourcekey="lbl_sendEmail"/>
							</span>
						</p>
					</div><!-- -->

					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- wrap -->

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
