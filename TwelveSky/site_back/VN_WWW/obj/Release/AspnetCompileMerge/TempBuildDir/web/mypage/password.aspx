<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="password.aspx.cs" Inherits="_12sky2.web.mypage.password" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<common:layout id="common" runat="server"/>

<script type="text/javascript">
	function Check_Alpha(checkStr) {
		var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		for ( var j = 0; j < checkOK.length; j++ ) {
			for ( var k = 0; k < checkStr.length; k++ ) {
				if ( checkStr.charAt(k).indexOf(checkOK.charAt(j)) > -1 ) {

					return (true);
				}
			}
		}
		return (false);
	}

	var vMessage = {
			Error_01 : "<%= fnLabelText("msgError_01") %>"
		,	Error_02 : "<%= fnLabelText("msgError_02") %>"
		,	Error_03 : "<%= fnLabelText("msgError_03") %>"
		,	Error_04 : "<%= fnLabelText("msgError_04") %>"
		,	Error_05 : "<%= fnLabelText("msgError_05") %>"
		,	Error_06 : "<%= fnLabelText("msgError_06") %>"
		,	Error_07 : "<%= fnLabelText("msgError_07") %>"
		,	Error_08 : "<%= fnLabelText("msgError_08") %>"
		,	Error_09 : "<%= fnLabelText("msgError_09") %>"
		,	Error_10 : "<%= fnLabelText("msgError_10") %>"
		};

	$(document).ready(function() {
		//패스워드 체크 시작
		$("#NewPassword").live('keyup', function() {
			$("#CheckMessage").hide();
			$("#CheckMessage").html('');

			if ( !Check_Alpha($("#NewPassword").val()) ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_01);
				return;
			}
			if ( $("#NewPassword").val().length < 8 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_02);
				return;
			}
			if ( $("#NewPassword").val().length > 16 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_02);
				return;
			}

			$("#CheckMessage").hide();
			$("#CheckMessage").html('');

			return;
		});
		//패스워드 체크 종료

		//패스워드 확인 체크 시작ConfirmPassword
		$("#NewConfirmPassword").live('keyup', function() {
			$("#CheckMessage").hide();
			$("#CheckMessage").html('');
			if ( $("#NewPassword").val().length === $("#NewConfirmPassword").val().length && $("#NewPassword").val() === $("#NewConfirmPassword").val() ) {
				$("#CheckMessage").hide();
				$("#CheckMessage").html('');
				return;
			} else {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_03);
				return;
			}
		});
		//패스워드 확인 체크 종료

		$("#ModifyButton").click(function() {
			if ( $("#UserID").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_04);
				return;
			}

			if ( $("#Password").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_05);
				return;
			}

			if ( $("#NewPassword").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_05);
				return;
			}

			if ( $("#NewConfirmPassword").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_06);
				return;
			}

			if ( $("#NewPassword").val().length < 8 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_07);
				return;
			}

			if ( $("#NewPassword").val().length > 16 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_07);
				return;
			}

			if ( $("#NewPassword").val() !== $("#NewConfirmPassword").val() ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html(vMessage.Error_03);
				return;
			}
			__doPostBack("btn_submit", "");
		});
	});
</script>
</head>

<body>
<form id="form1" runat="server">
	<div id="main_bg">
		<div id="wrap">
			<head:layout id="head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<div class="lnb">
					<div class="lnb_tit"><%= fnMainText("mypage") %></div>
					<div class="left_menu">
						<ul>
							<li><a href="/web/mypage/profile.aspx"><%= fnMainText("profile") %></a></li>
							<li><a href="/web/mypage/password.aspx" class="on"><%= fnMainText("password") %></a></li>
							<li><a href="/web/mypage/myquestions.aspx"><%= fnMainText("support") %></a>
								<ul>
									<li><a href="/web/mypage/myquestions.aspx"><%= fnMainText("myQuestion") %></a></li>
									<li><a href="/web/mypage/contact.aspx"><%= fnMainText("contatct") %></a></li>
								</ul>
							</li>
							<li><a href="/web/mypage/withdrawal.aspx"><%= fnMainText("deactivate") %></a></li>
						</ul>
					</div>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnMainText("mypage") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="message_box" id="CheckMessage" style="display:none;">
							<%= fnLabelText("msgError_04") %>
						</div>
						<div class="con_text">
							<ul>
								<li><asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/></li>
							</ul>
						</div>
						<div class="profile">
							<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
								<table cellspacing="0" cellpadding="0" class="C_table01">
									<caption></caption>
									<colgroup>
										<col width="30%"/>
										<col width="*"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="b_none"><span class="red_02">*</span>E-Mail Address:</th>
											<td>
												<asp:TextBox id="UserID" runat="server" Width="240"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>Current Password:</th>
											<td>
												<asp:TextBox id="Password" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>New Password:</th>
											<td>
												<asp:TextBox id="NewPassword" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>Confirm Password:</th>
											<td>
												<asp:TextBox id="NewConfirmPassword" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											</td>
										 </tr>
									</tbody>
								</table>
							</div>
						</div>

						<captcha:common id="Common1" runat="server"/>

						<p class="t_center">
							<span class="btn_type" id="ModifyButton"><a href="javascript:;">SAVE</a></span>
						</p>

						<asp:LinkButton id="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>
					</div><!-- -->

					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- wrap -->

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
