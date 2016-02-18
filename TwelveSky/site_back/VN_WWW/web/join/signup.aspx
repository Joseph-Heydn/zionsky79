<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="_12sky2.web.join.signup" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Twelvesky2</title>
<common:layout id="common" runat="server"/>
<script type="text/javascript">
	$(document).ready(function() {
		var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var numEngSExp = /^[0-9a-zA-Z_]{6,16}$/;
		var vErrorMsg =
			{	vError01 : "<%= fnLabelText("vError01") %>"
			,	vError02 : "<%= fnLabelText("vError02") %>"
			,	vError03 : "<%= fnLabelText("vError03") %>"
			,	vError04 : "<%= fnLabelText("vError04") %>"
			,	vError05 : "<%= fnLabelText("vError05") %>"
			,	vError06 : "<%= fnLabelText("vError06") %>"
			,	vError07 : "<%= fnLabelText("vError07") %>"
			,	vError08 : "<%= fnLabelText("vError08") %>"
			,	vError09 : "<%= fnLabelText("vError09") %>"
			,	vError10 : "<%= fnLabelText("vError10") %>"
			,	vError11 : "<%= fnLabelText("vError11") %>"
			,	vError12 : "<%= fnLabelText("vError12") %>"
			,	vError13 : "<%= fnLabelText("vError13") %>"
			,	vError14 : "<%= fnLabelText("vError14") %>"
			,	vError15 : "<%= fnLabelText("vError15") %>"
			,	vError16 : "<%= fnLabelText("vError16") %>"
			,	vError17 : "<%= fnLabelText("vError17") %>"
			,	vError18 : "<%= fnLabelText("vError18") %>"
			,	vError19 : "<%= fnLabelText("vError19") %>"
			};

		//계정 체크 시작
		$("#UserID").live('keyup', function() {
			$("#formCheckText").html("");
			$("#UserIDdoubleCheck").val("N");
			$("#UserIDCheckText").hide();
			$("#UserIDCheckImg").html('');
			$("#ConfirmUserIDCheckText").hide();
			$("#ConfirmUserIDCheckText").html('');
			$("#ConfirmUserIDCheckImg").html('');

			if ( $("#UserID").val().length > 5 && $("#UserID").val().length <= 32 ) {
				if ( !emailExp.test($("#UserID").val()) ) {
					$("#UserIDCheckText").show();
					$("#UserIDCheckText").html(vErrorMsg.vError01);
					$("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
					return;
				}

				$.ajax({
					url : "/webservice/services.asmx/getUserIdCheck",
					type : "post",
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					data : "{'UserID':'" + $("#UserID").val() + "'}",
					success : function(data) {
						var resultCode = data.d;

						$("#UserIDCheckText").show();
						$("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
						if ( resultCode === "E1" ) {
							$("#UserIDCheckText").html(vErrorMsg.vError02);
							return;
						} else if ( resultCode === "E2" || resultCode === "E3" ) {
							$("#UserIDCheckText").html(vErrorMsg.vError03);
							return;
						} else if ( resultCode === "E4" ) {
							$("#UserIDCheckText").html(vErrorMsg.vError04);
							return;
						} else if ( resultCode === "E5" ) {
							$("#UserIDCheckText").html(vErrorMsg.vError01);
							return;
						} else if ( resultCode === "OK" ) {
							$("#UserIDdoubleCheck").val("Y");
							$("#UserIDCheckText").hide();
							$("#UserIDCheckText").html('');
							$("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
							return;
						}
					},
					error : function() {
						alert("Page Error!.");
						return;
					}
				});
			} else {
				$("#UserIDCheckText").show();
				$("#UserIDCheckText").html(vErrorMsg.vError01);
				$("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}
		});

		//계정 체크 끝
		$("#SecurityEmail").live('keyup', function() {
			$("#SecurityEmailCheckText").hide();
			$("#SecurityEmailCheckText").html('');
			$("#SecurityEmailCheckImg").html('');
			if ( $("#SecurityEmail").val().length > 5 ) {
				if ( !emailExp.test($("#SecurityEmail").val()) ) {
					$("#SecurityEmailCheckText").show();
					$("#SecurityEmailCheckText").html(vErrorMsg.vError05);
					$("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
					return;
				}
				if ( $("#SecurityEmail").val() === $("#UserID").val() ) {
					$("#SecurityEmailCheckText").show();
					$("#SecurityEmailCheckText").html(vErrorMsg.vError06);
					$("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				}

				$("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
			}
		});

		//계정 확인 체크 시작
		$("#ConfirmUserID").live('keyup', function() {
			$("#formCheckText").html("");
			$("#ConfirmUserIDCheckText").hide();
			$("#ConfirmUserIDCheckText").html('');
			$("#ConfirmUserIDCheckImg").html('');
			if ( $("#UserID").val().length === $("#ConfirmUserID").val().length && $("#UserID").val() === $("#ConfirmUserID").val() ) {
				$("#ConfirmUserIDCheckText").hide();
				$("#ConfirmUserIDCheckText").html('');
				$("#ConfirmUserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
				return;
			} else {
				$("#ConfirmUserIDCheckText").show();
				$("#ConfirmUserIDCheckText").html(vErrorMsg.vError07);
				$("#ConfirmUserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}
		});
		//계정 확인 체크 종료

		//패스워드 체크 시작
		$("#Password").live('keyup', function() {
			$("#formCheckText").html("");
			$("#PasswordCheckText").hide();
			$("#PasswordCheckText").html('');
			$("#PasswordCheckImg").html('');
			$("#ConfirmPasswordCheckText").hide();
			$("#ConfirmPasswordCheckText").html('');
			$("#ConfirmPasswordCheckImg").html('');
			if ( !Check_Alpha($("#Password").val()) ) {
				$("#PasswordCheckText").show();
				$("#PasswordCheckText").html(vErrorMsg.vError08);
				$("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}
			if ( $("#Password").val().length < 8 ) {
				$("#PasswordCheckText").show();
				$("#PasswordCheckText").html(vErrorMsg.vError09);
				$("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}
			if ( $("#Password").val().length > 16 ) {
				$("#PasswordCheckText").show();
				$("#PasswordCheckText").html(vErrorMsg.vError09);
				$("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}

			$("#PasswordCheckText").hide();
			$("#PasswordCheckText").html('');
			$("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
			return;
		});
		//패스워드 체크 종료

		//패스워드 확인 체크 시작ConfirmPassword
		$("#ConfirmPassword").live('keyup', function() {
			$("#ConfirmPasswordCheckText").hide();
			$("#ConfirmPasswordCheckText").html('');
			$("#ConfirmPasswordCheckImg").html('');
			if ( $("#Password").val().length === $("#ConfirmPassword").val().length && $("#Password").val() === $("#ConfirmPassword").val() ) {
				$("#ConfirmPasswordCheckText").hide();
				$("#ConfirmPasswordCheckText").html('');
				$("#ConfirmPasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
				return;
			} else {
				$("#ConfirmPasswordCheckText").show();
				$("#ConfirmPasswordCheckText").html(vErrorMsg.vError10);
				$("#ConfirmPasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
				return;
			}
		});
		//패스워드 확인 체크 종료

		//닉네임 체크 시작
		$("#Nickname").live('keyup', function() {
			$("#formCheckText").html("");
			$("#NicknameDdoubleCheck").val("N");
			$("#NicknameCheckText").hide();
			$("#NicknameCheckText").html('');
			$("#NicknameCheckImg").html('');
			if ( $("#Nickname").val().length > 5 ) {
				if ( !numEngSExp.test($("#Nickname").val()) ) {
					$("#NicknameCheckText").show();
					$("#NicknameCheckText").html(vErrorMsg.vError11);
					$("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
					return;
				}

				$.ajax({
					url : "/webservice/services.asmx/getUserNicknameCheck",
					type : "post",
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					data : "{'Nickname':'" + $("#Nickname").val() + "'}",
					success : function(data) {
						var resultCode = data.d;

						$("#NicknameCheckText").show();
						$("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
						if ( resultCode === "E1" ) {
							$("#NicknameCheckText").html(vErrorMsg.vError02);
							return;
						} else if ( resultCode === "E2" || resultCode === "E3" ) {
							$("#NicknameCheckText").html(vErrorMsg.vError12);
							return;
						} else if ( resultCode === "E4" ) {
							$("#NicknameCheckText").html(vErrorMsg.vError13);
							return;
						} else if ( resultCode === "E5" ) {
							$("#NicknameCheckText").html(vErrorMsg.vError11);
							return;
						} else if ( resultCode === "OK" ) {
							$("#NicknameDdoubleCheck").val("Y");
							$("#NicknameCheckText").hide();
							$("#NicknameCheckText").html('');
							$("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg"/>');
							return;
						}
					},
					error : function() {
						alert(vErrorMsg.vError19);
						return;
					}
				});
			} else {
				$("#NicknameCheckText").show();
				$("#NicknameCheckText").html(vErrorMsg.vError11);
				return;
			}
		});
		//닉네임 체크 끝

		//가입 폼 체크 시작
		$("#JoinButton").click(function() {
			$("#formCheckText").html("");
			//*계정 체크
			//빈값체크 확인
			if ( $("#UserID").val() === "" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError01);
				$("#UserID").focus();
				return;
			}
			//이메일 형식 체크
			if ( !emailExp.test($("#UserID").val()) ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError01);
				$("#UserID").focus();
				return;
			}
			//이메일 길이 제한
			if ( $("#UserID").val().length > 32 ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError01);
				$("#UserID").focus();
				return;
			}
			//중복체크 확인
			if ( $("#UserIDdoubleCheck").val() !== "Y" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError14);
				$("#UserID").focus();
				return;
			}
			//계정 확인이랑 동일한지 체크
			if ( $("#UserID").val() !== $("#ConfirmUserID").val() ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError07);
				$("#UserID").focus();
				return;
			}
			//*패스워드 체크
			if ( $("#Password").val() === "" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError09);
				$("#Password").focus();
				return;
			}
			//패스워드 규칙 체크
			if ( $("#Password").val().length < 8 ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError09);
				$("#Password").focus();
				return;
			}
			if ( $("#Password").val().length > 16 ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError09);
				$("#Password").focus();
				return;
			}
			//패스워드 확인 체크
			if ( $("#Password").val() !== $("#ConfirmPassword").val() ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError10);
				$("#Password").focus();
				return;
			}
			//발송 전용 메일 체크
			if ( $("#SecurityEmail").val() === "" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError15);
				$("#SecurityEmail").focus();
				return;
			}
			//발송 전용 메일 형식 체크
			if ( !emailExp.test($("#SecurityEmail").val()) ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError16);
				$("#SecurityEmail").focus();
				return;
			}
			//*닉네임 체크
			//빈값 체크 확인
			if ( $("#Nickname").val() === "" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError12);
				$("#Nickname").focus();
				return;
			}
			//형식 체크
			if ( !numEngSExp.test($("#Nickname").val()) ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError11);
				$("#Nickname").focus();
				return;
			}
			//중복 체크 확인
			if ( $("#NicknameDdoubleCheck").val() !== "Y" ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError17);
				$("#Nickname").focus();
				return;
			}
			//*약관 동의 체크
			if ( !$("#IsAgree").is(':checked') ) {
				$("#formCheckText").show();
				$("#formCheckText").html(vErrorMsg.vError18);
				return;
			}

			__doPostBack("btn_submit", "");
		});
		//가입 폼 체크 끝
	});

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
					<div class="lnb_tit">
						<%= fnLabelText("Signup") %>
					</div>
				</div>
				<!-- // left menu -->

				<!-- content -->
				<div id="contents">
					<div class="con_top">
						<div class="nav_hint">
							Home &gt;
							<%= fnLabelText("Signup") %> &gt;
							<span id="NAV_TITL" runat="server" class="now"></span>
						</div>
						<div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
						<div class="write_date">by <span class="writer">SUPERManager</span> 20 Aug 2013</div>
					</div>

					<!-- contents start -->
					<div class="content_page">
						<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
							<!-- //tit_bar -->
							<input type="hidden" id="UserIDdoubleCheck" value="N"/>
							<input type="hidden" id="NicknameDdoubleCheck" value="N"/>

							<!--ERROR-->
							<div class="message_box marB_10" id="formCheckText" style="display: none;">error message</div>
							<!--//ERROR-->
							<table cellspacing="0" cellpadding="0" class="C_table01">
								<colgroup>
									<col width="35%"/>
									<col width=""/>
								</colgroup>
								<tbody>
									<tr>
										<th class="b_none"><span class="red_02">*</span>E-mail address:</th>
										<td>
											<asp:TextBox id="UserID" runat="server" Width="240"></asp:TextBox>
											<span id="UserIDCheckImg"></span>
											<p class="en_comment" id="UserIDCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Confirm E-mail:</th>
										<td>
											<asp:TextBox id="ConfirmUserID" runat="server" Width="240"></asp:TextBox>
											<span id="ConfirmUserIDCheckImg"></span>
											<p class="en_comment" id="ConfirmUserIDCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Password:</th>
										<td>
											<asp:TextBox id="Password" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											<span id="PasswordCheckImg"></span>
											<p class="en_comment" id="PasswordCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Confirm Password:</th>
										<td>
											<asp:TextBox id="ConfirmPassword" runat="server" Width="240" TextMode="Password"></asp:TextBox>
											<span id="ConfirmPasswordCheckImg"></span>
											<p class="en_comment" id="ConfirmPasswordCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Security Email:</th>
										<td>
											<asp:TextBox id="SecurityEmail" runat="server" Width="240" MaxLength="40"></asp:TextBox>
											<span id="SecurityEmailCheckImg"></span>
											<p class="en_comment" id="SecurityEmailCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Nickname:</th>
										<td>
											<asp:TextBox id="Nickname" runat="server" Width="240"></asp:TextBox>
											<span id="NicknameCheckImg"></span>
											<p class="en_comment" id="NicknameCheckText" style="display: none;"></p>
										</td>
									</tr>
									<tr>
										<td colspan="2" height="15">
											<p class="txt_type01 marT_10" style="color:Red;font-size:15px;">
												<strong><asp:Literal runat="server" meta:resourcekey="lbl_secEmail_01"/></strong>
												<asp:Literal runat="server" meta:resourcekey="lbl_secEmail_02"/>
											</p>
										</td>
									</tr>
								</tbody>
							</table>
							<!-- //entry_table -->
						</div>

						<div class="con_text">
							<ul>
								<li>
									<input type="checkbox" id="IsAgree" name="IsAgree" value="Y" class="check" style="margin: 0 5px 0 0;"/>
									<label for="ch_1">
										<asp:Literal runat="server" meta:resourcekey="lbl_chkAgree_01"/>
										<a href="/web/about/terms.aspx" title="Terms of Use" target="_blank">
											<asp:Literal runat="server" meta:resourcekey="lbl_terms"/>
										</a>
										<asp:Literal runat="server" meta:resourcekey="lbl_chkAgree_02"/>
										<a href="/web/about/privacy.aspx" title="Privacy Policy" target="_blank">
											<asp:Literal runat="server" meta:resourcekey="lbl_privacy"/>.
										</a>
									</label>
								</li>
								<li>
									<asp:CheckBox id="IsEmailChk" runat="server" Checked="true" CssClass="check" style="margin: 0 5px 0 0;"/>
									<label for="ch_2"><asp:Literal runat="server" meta:resourcekey="lbl_receiveMail"/></label>
								</li>
							</ul>
						</div>

						<captcha:common id="Common1" runat="server"/>

						<p class="t_center">
							<span class="btn_type" id="JoinButton">
								<a href="javascript:;"><asp:Literal runat="server" meta:resourcekey="lbl_continue"/></a>
							</span>&nbsp;
							<span class="btn_type">
								<a href="javascript:history.back();"><asp:Literal runat="server" meta:resourcekey="lbl_cancel"/></a>
							</span>
						</p>

						<asp:LinkButton id="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>
					</div>
					<!-- content_page -->

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
