<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="password.aspx.cs" Inherits="_12sky2.admin.user.password" %>
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

	$(document).ready(function() {
		//패스워드 체크 시작
		$("#NewPassword").live('keyup', function() {
			$("#CheckMessage").hide();
			$("#CheckMessage").html('');

			if ( !Check_Alpha($("#NewPassword").val()) ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html('Your password can contain letters, digits, and symbols.Must contain a mix of upper and lower case letters, andmust be between 8 - 16 characters long.');
				return;
			}
			if ( $("#NewPassword").val().length < 8 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html('Your password should be between 8 - 16 characters long.');
				return;
			}
			if ( $("#NewPassword").val().length > 16 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html('Your password should be between 8 - 16 characters long.');
				return;
			}

			$("#CheckMessage").hide();
			$("#CheckMessage").html('');

			return;
		});

		$("#ModifyButton").click(function() {
			if ( $("#UserID").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html("Hãy nhập địa chỉ Email của bạn");
				return;
			}
			if ( $("#Password").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html("Please enter your Password.");
				return;
			}
			if ( $("#NewPassword").val() === "" ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html("Please enter your Password.");
				return;
			}
			if ( $("#NewPassword").val().length < 8 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html('Your password should be between 8 - 16 characters long.');
				return;
			}
			if ( $("#NewPassword").val().length > 16 ) {
				$("#CheckMessage").show();
				$("#CheckMessage").html('Your password should be between 8 - 16 characters long.');
				return;
			}

			__doPostBack("btn_submit", "");
		});
	});
</script>
</head>

<body>
<form id="form1" runat="server">
	<%--<div id="main_bg">--%>
	<div>
		<div id="wrap">
			<admin_head:layout id="admin_head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<admin_left:layout id="admin_left" runat="server" setTITL="User" setSUB_TITL="password"/>

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">Home &gt; User &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="message_box" id="CheckMessage" style="display:none;">Hãy nhập địa chỉ Email của bạn</div>

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
											<th class="b_none"><span class="red_02">*</span>User ID:</th>
											<td>
												<asp:TextBox id="UserID" runat="server" Width="240"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>New Password:</th>
											<td>
												<asp:TextBox id="NewPassword" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<p class="t_center">
							<span class="btn_type" id="ModifyButton"><a href="javascript:;">SAVE</a></span>
						</p>

						<asp:LinkButton id="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>
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
