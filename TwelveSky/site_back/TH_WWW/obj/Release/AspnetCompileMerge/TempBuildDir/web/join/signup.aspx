<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="_12sky2.web.join.signup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2</title>
    
    <common:layout id="common" runat="server" />
    
<script type="text/javascript">

    $(document).ready(function() {
        var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        var numEngSExp = /^[0-9a-zA-Z_]{6,16}$/;

        //계정 체크 시작
        $("#UserID").live('keyup', function() {
            $("#formCheckText").html("");
            $("#UserIDdoubleCheck").val("N");
            $("#UserIDCheckText").hide();
            $("#UserIDCheckImg").html('');
            $("#ConfirmUserIDCheckText").hide();
            $("#ConfirmUserIDCheckText").html('');
            $("#ConfirmUserIDCheckImg").html('');
            if ($("#UserID").val().length > 5 && $("#UserID").val().length <= 32) {
                if (!emailExp.test($("#UserID").val())) {
                    $("#UserIDCheckText").show();
                    $("#UserIDCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                    $("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                    return;
                }

                $.ajax({
                    url: "/webservice/services.asmx/getUserIdCheck",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    data: "{'UserID':'" + $("#UserID").val() + "'}",
                    success: function(data) {
                        var resultCode = data.d;

                        $("#UserIDCheckText").show();
                        $("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                        if (resultCode == "E1") {
                            $("#UserIDCheckText").html("หากจะเปิดการทำบัญชีใหม่อย่ากดเข้าสู่ระบบ.");
                            return;
                        } else if (resultCode == "E2" || resultCode == "E3") {
                            $("#UserIDCheckText").html("กรุณากรอกอีเมลของคุณ.");
                            return;
                        } else if (resultCode == "E4") {
                            $("#UserIDCheckText").html("ที่อยู่อีเมลที่ลงทะเบียนแล้วใช้มันเพื่อเข้าสู่บัญชีที่มีอยู่หรือลองอีกครั้ง.");
                            return;
                        } else if (resultCode == "E5") {
                            $("#UserIDCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                            return;
                        } else if (resultCode == "OK") {
                            $("#UserIDdoubleCheck").val("Y");
                            $("#UserIDCheckText").hide();
                            $("#UserIDCheckText").html('');
                            $("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
                            return;
                        }
                    },
                    error: function() {
                        alert("Page Error!.");
                        return;
                    }
                });
            } else {
                $("#UserIDCheckText").show();
                $("#UserIDCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                $("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }
        });

        //계정 체크 끝
        $("#SecurityEmail").live('keyup', function() {
            $("#SecurityEmailCheckText").hide();
            $("#SecurityEmailCheckText").html('');
            $("#SecurityEmailCheckImg").html('');
            if ($("#SecurityEmail").val().length > 5) {
                if (!emailExp.test($("#SecurityEmail").val())) {
                    $("#SecurityEmailCheckText").show();
                    $("#SecurityEmailCheckText").html("จะต้องเป็นรูปแบบอีเมลรองที่ถูกต้อง.");
                    $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                    return;
                }
                if ($("#SecurityEmail").val() == $("#UserID").val()) {
                    $("#SecurityEmailCheckText").show();
                    $("#SecurityEmailCheckText").html("อีเมลรองไม่สามารถจับคู่กับที่อยู่อีเมลเข้าสู่ระบบ.");
                    $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                }

                $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
            }
        });

        //계정 확인 체크 시작
        $("#ConfirmUserID").live('keyup', function() {
            $("#formCheckText").html("");
            $("#ConfirmUserIDCheckText").hide();
            $("#ConfirmUserIDCheckText").html('');
            $("#ConfirmUserIDCheckImg").html('');
            if ($("#UserID").val().length = $("#ConfirmUserID").val().length && $("#UserID").val() == $("#ConfirmUserID").val()) {
                $("#ConfirmUserIDCheckText").hide();
                $("#ConfirmUserIDCheckText").html('');
                $("#ConfirmUserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
                return;
            } else {
                $("#ConfirmUserIDCheckText").show();
                $("#ConfirmUserIDCheckText").html('ที่อยู่อีเมลไม่ตรงกัน.');
                $("#ConfirmUserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
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
            if (!Check_Alpha($("#Password").val())) {
                $("#PasswordCheckText").show();
                $("#PasswordCheckText").html('รหัสผ่านของคุณสามารถมีตัวอักษรเลขและสัญลักษ์รวมกัน8~16ตัว.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }
            if ($("#Password").val().length < 8) {
                $("#PasswordCheckText").show();
                $("#PasswordCheckText").html('รหัสผ่านของคุณต้องใช้8~16ตัวขึ้นไป.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }
            if ($("#Password").val().length > 16) {
                $("#PasswordCheckText").show();
                $("#PasswordCheckText").html('รหัสผ่านของคุณต้องใช้8~16ตัวขึ้นไป.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }

            $("#PasswordCheckText").hide();
            $("#PasswordCheckText").html('');
            $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
            return;
        });
        //패스워드 체크 종료

        //패스워드 확인 체크 시작ConfirmPassword
        $("#ConfirmPassword").live('keyup', function() {
            $("#ConfirmPasswordCheckText").hide();
            $("#ConfirmPasswordCheckText").html('');
            $("#ConfirmPasswordCheckImg").html('');
            if ($("#Password").val().length = $("#ConfirmPassword").val().length && $("#Password").val() == $("#ConfirmPassword").val()) {
                $("#ConfirmPasswordCheckText").hide();
                $("#ConfirmPasswordCheckText").html('');
                $("#ConfirmPasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
                return;
            } else {
                $("#ConfirmPasswordCheckText").show();
                $("#ConfirmPasswordCheckText").html('รหัสผ่านไม่ถูกต้อง.');
                $("#ConfirmPasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
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
            if ($("#Nickname").val().length > 5) {
                if (!numEngSExp.test($("#Nickname").val())) {
                    $("#NicknameCheckText").show();
                    $("#NicknameCheckText").html("โปรดสร้างชื่อเล่นของคุณต้องใช้6~16ตัวขึ้นไป.");
                    $("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                    return;
                }

                $.ajax({
                    url: "/webservice/services.asmx/getUserNicknameCheck",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    data: "{'Nickname':'" + $("#Nickname").val() + "'}",
                    success: function(data) {
                        var resultCode = data.d;

                        $("#NicknameCheckText").show();
                        $("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                        if (resultCode == "E1") {
                            $("#NicknameCheckText").html("หากจะเปิดการทำบัญชีใหม่อย่ากดเข้าสู่ระบบ.");
                            return;
                        } else if (resultCode == "E2" || resultCode == "E3") {
                            $("#NicknameCheckText").html("กรุณากรอกชื่อเล่นเข้า");
                            return;
                        } else if (resultCode == "E4") {
                            $("#NicknameCheckText").html("กรุณาตั้งชื่อใหม่เพราะมีชื่อซ้ำกัน.");
                            return;
                        } else if (resultCode == "E5") {
                            $("#NicknameCheckText").html("โปรดสร้างชื่อเล่นของคุณต้องใช้6~16ตัวขึ้นไป.");
                            return;
                        } else if (resultCode == "OK") {
                            $("#NicknameDdoubleCheck").val("Y");
                            $("#NicknameCheckText").hide();
                            $("#NicknameCheckText").html('');
                            $("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
                            return;
                        }
                    },
                    error: function() {
                        alert("Page Error!.");
                        return;
                    }
                });
            } else {
                $("#NicknameCheckText").show();
                $("#NicknameCheckText").html("โปรดสร้างชื่อเล่นของคุณต้องใช้6~16ตัวขึ้นไป.");
                return;
            }
        });
        //닉네임 체크 끝

        //가입 폼 체크 시작
        $("#JoinButton").click(function() {
            $("#formCheckText").html("");
            //*계정 체크
            //빈값체크 확인
            if ($("#UserID").val() == "") {
                $("#formCheckText").show();
                $("#formCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                $("#UserID").focus();
                return;
            }
            //이메일 형식 체크
            if (!emailExp.test($("#UserID").val())) {
                $("#formCheckText").show();
                $("#formCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                $("#UserID").focus();
                return;
            }
            //이메일 길이 제한
            if ($("#UserID").val().length > 32) {
                $("#formCheckText").show();
                $("#formCheckText").html("จะต้องเป็นรูปแบบของอีเมลที่ถูกต้อง.");
                $("#UserID").focus();
                return;
            }
            //중복체크 확인
            if ($("#UserIDdoubleCheck").val() != "Y") {
                $("#formCheckText").show();
                $("#formCheckText").html("กรุณาตรวจสอบIDว่ามีคนใช้อยู่ใหม.");
                $("#UserID").focus();
                return;
            }
            //계정 확인이랑 동일한지 체크
            if ($("#UserID").val() != $("#ConfirmUserID").val()) {
                $("#formCheckText").show();
                $("#formCheckText").html("ที่อยู่อีเมลไม่ตรงกัน.");
                $("#UserID").focus();
                return;
            }
            //*패스워드 체크
            if ($("#Password").val() == "") {
                $("#formCheckText").show();
                $("#formCheckText").html("รหัสผ่านของคุณต้องใช้8~16ตัวขึ้นไป.");
                $("#Password").focus();
                return;
            }
            //패스워드 규칙 체크
            if ($("#Password").val().length < 8) {
                $("#formCheckText").show();
                $("#formCheckText").html("รหัสผ่านของคุณต้องใช้8~16ตัวขึ้นไป.");
                $("#Password").focus();
                return;
            }
            if ($("#Password").val().length > 16) {
                $("#formCheckText").show();
                $("#formCheckText").html("รหัสผ่านของคุณต้องใช้8~16ตัวขึ้นไป.");
                $("#Password").focus();
                return;
            }
            //패스워드 확인 체크
            if ($("#Password").val() != $("#ConfirmPassword").val()) {
                $("#formCheckText").show();
                $("#formCheckText").html("รหัสผ่านไม่ถูกต้อง.");
                $("#Password").focus();
                return;
            }
            //발송 전용 메일 체크
            if ($("#SecurityEmail").val() == "") {
                $("#formCheckText").show();
                $("#formCheckText").html("กรุณากรอกอีเมลการรักษาความปลอดภัย.");
                $("#SecurityEmail").focus();
                return;
            }
            //발송 전용 메일 형식 체크
            if (!emailExp.test($("#SecurityEmail").val())) {
                $("#formCheckText").show();
                $("#formCheckText").html("จะต้องเป็นรูปแบของการรักษาความปลอดภัยของอีเมล.");
                $("#SecurityEmail").focus();
                return;
            }
            //*닉네임 체크
            //빈값 체크 확인
            if ($("#Nickname").val() == "") {
                $("#formCheckText").show();
                $("#formCheckText").html("กรุณากรอกชื่อเล่นเข้า");
                $("#Nickname").focus();
                return;
            }
            //형식 체크
            if (!numEngSExp.test($("#Nickname").val())) {
                $("#formCheckText").show();
                $("#formCheckText").html("โปรดสร้างชื่อเล่นของคุณต้องใช้6~16ตัวขึ้นไป.");
                $("#Nickname").focus();
                return;
            }
            //중복 체크 확인
            if ($("#NicknameDdoubleCheck").val() != "Y") {
                $("#formCheckText").show();
                $("#formCheckText").html("ตรวจสอบชื่อเล่นของคุณว่ามีคนใช้หรือไม่.");
                $("#Nickname").focus();
                return;
            }
            //*약관 동의 체크      
            if (!$("#IsAgree").is(':checked')) {
                $("#formCheckText").show();
                $("#formCheckText").html("คุณต้องยอมรับเงื่อนไขการใช้งานและนโยบายความเป็นส่วนตัว.");
                return;
            }
            __doPostBack("btn_submit", "");
        });
        //가입 폼 체크 끝
    });

    function Check_Alpha(checkStr) {
        var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (j = 0; j < checkOK.length; j++) {
            for (k = 0; k < checkStr.length; k++) {
                if (checkStr.charAt(k).indexOf(checkOK.charAt(j)) > -1) {

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
                <head:layout id="head" runat="server" />
                
		        <div id="C_container">
			        <!-- left menu -->
			        <div class="lnb">
				        <div class="lnb_tit">รายการลงทะเบียน</div>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; <span class="now">รายการลงทะเบียน</span></div>
					        <div class="page_tit">รายการลงทะเบียน</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
					        
    <!-- //tit_bar -->
    <input type="hidden" id="UserIDdoubleCheck" value="N" />
    <input type="hidden" id="NicknameDdoubleCheck" value="N" />		
    
        <!--ERROR-->
        <div class="message_box marB_10" id="formCheckText" style="display: none;">error message</div>
        <!--//ERROR-->    			        
					        
						        <table cellspacing="0" cellpadding="0" class="C_table01">
							        <colgroup>
								        <col width="35%" />
								        <col width="" />
							        </colgroup>
							        <tbody>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>E-mail address:</th>
									        <td>
                                                <asp:TextBox ID="UserID" runat="server" Width="240"></asp:TextBox>
										        <span id="UserIDCheckImg"></span>
										        <p class="en_comment" id="UserIDCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Confirm E-mail:</th>
									        <td>
                                                <asp:TextBox ID="ConfirmUserID" runat="server" Width="240"></asp:TextBox>
										        <span id="ConfirmUserIDCheckImg"></span>
										        <p class="en_comment" id="ConfirmUserIDCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Password:</th>
									        <td>
                                                <asp:TextBox ID="Password" runat="server" Width="240" TextMode="Password"></asp:TextBox>
										        <span id="PasswordCheckImg"></span>
										        <p class="en_comment" id="PasswordCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Confirm Password:</th>
									        <td>
									            <asp:TextBox ID="ConfirmPassword" runat="server" Width="240" TextMode="Password"></asp:TextBox>
										        <span id="ConfirmPasswordCheckImg"></span>
										        <p class="en_comment" id="ConfirmPasswordCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Security Email:</th>
									        <td>
									            <asp:TextBox ID="SecurityEmail" runat="server" Width="240" MaxLength="40"></asp:TextBox>
										        <span id="SecurityEmailCheckImg"></span>
										        <p class="en_comment" id="SecurityEmailCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Nickname:</th>
									        <td>
									            <asp:TextBox ID="Nickname" runat="server" Width="240"></asp:TextBox>
										        <span id="NicknameCheckImg"></span>
										        <p class="en_comment" id="NicknameCheckText" style="display: none;"></p>
									        </td>
								        </tr>
								        <tr>
									        <td colspan="2" height="15">
										        <p class="txt_type01 marT_10" style="color:Red;font-size:15px;"><strong>*Security Email</strong> : หากคุณลืม ID ของคุณทำให้ใส่อีเมลนี้. </p>
									        </td>
								        </tr>
							        </tbody>
						        </table><!-- //entry_table -->
					        </div>

					        <div class="con_text">
						        <ul>
							        <li>                                        
                                        <input type="checkbox" id="IsAgree" name="IsAgree" value="Y" class="check" style="margin: 0 5px 0 0;" />
                                        <label for="ch_1">เข้าใจและยอมรับข้อตกลงและ <a href="/web/about/terms.aspx" title="Terms of Use" target="_blank">เงื่อนไข</a> ที่เป็น <a href="/web/about/privacy.aspx" title="นโยบายความเป็นส่วนตัว" target="_blank">ส่วนตัว.</a>.</label>
                                    </li>
							        <li>
							            <asp:CheckBox ID="IsEmailChk" runat="server" Checked="true" CssClass="check" style="margin: 0 5px 0 0;" />
							            <label for="ch_2">ต้องการที่จะได้รับฟังข่าวจาก KJ ข่าวเกมส์,อัพเดท,และรับฟังเหตุการณ์ของงานอีเว้น.</label></li>
						        </ul>
					        </div>

                            <captcha:common ID="Common1" runat="server" />

					        <p class="t_center">
						        <span class="btn_type" id="JoinButton"><a href="javascript:;">CONTINUE</a></span>
						        <span class="btn_type"><a href="javascript:history.back();">CANCEL</a></span>
					        </p>
					        
					        <asp:LinkButton ID="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>
				        </div><!-- -->
				
					
				        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>
			        </div>
		        </div> <!-- container -->
	        </div><!-- wrap -->	
            <tail:layout id="tail" runat="server" /> 
        </div> 	        	        
    </form>
</body>
</html>
