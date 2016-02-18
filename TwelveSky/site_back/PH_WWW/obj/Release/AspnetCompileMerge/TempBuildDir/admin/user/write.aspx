<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="write.aspx.cs" Inherits="_12sky2.admin.user.write" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2 - Admin Page</title>
    
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
//                if (!emailExp.test($("#UserID").val())) {
//                    $("#UserIDCheckText").show();
//                    $("#UserIDCheckText").html("Must be a valid email format.");
//                    $("#UserIDCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
//                    return;
//                }

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
                        if (resultCode == "E2" || resultCode == "E3") {
                            $("#UserIDCheckText").html("Please enter your Email address.");
                            return;
                        } else if (resultCode == "E4") {
                            $("#UserIDCheckText").html("That email address is already registered. Use it to log in to an existing account or try again with a different address.");
                            return;
                        } else if (resultCode == "E1" || resultCode == "E5" || resultCode == "OK") {
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
                $("#UserIDCheckText").html("Must be a valid email format.");
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
                    $("#SecurityEmailCheckText").html("Must be a valid Secondary email format.");
                    $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                    return;
                }
                if ($("#SecurityEmail").val() == $("#UserID").val()) {
                    $("#SecurityEmailCheckText").show();
                    $("#SecurityEmailCheckText").html("A Secondary email cannot be matched with the login email address.");
                    $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                }

                $("#SecurityEmailCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
            }
        });

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
                $("#PasswordCheckText").html('Your password can contain letters, digits, and symbols. Must contain a mix of upper and lower case letters, and must be between 8 - 16 characters long.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }
            if ($("#Password").val().length < 8) {
                $("#PasswordCheckText").show();
                $("#PasswordCheckText").html('Your password should be between 8 - 16 characters long.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }
            if ($("#Password").val().length > 16) {
                $("#PasswordCheckText").show();
                $("#PasswordCheckText").html('Your password should be between 8 - 16 characters long.');
                $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                return;
            }

            $("#PasswordCheckText").hide();
            $("#PasswordCheckText").html('');
            $("#PasswordCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
            return;
        });
        //패스워드 체크 종료

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
                    $("#NicknameCheckText").html("Please create your nickname between 6~16 letters.");
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
                         if (resultCode == "E2" || resultCode == "E3") {
                            $("#NicknameCheckText").html("Please enter the Nickname");
                            return;
                        } else if (resultCode == "E4") {
                            $("#NicknameCheckText").html("That nick name is already used.");
                            return;
                        } else if (resultCode == "E1" || resultCode == "E5" || resultCode == "OK") {
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
                $("#NicknameCheckText").html("Please create your nickname between 6~16 letters.");
                return;
            }
        });
        //닉네임 체크 끝

        //가입 폼 체크 시작
        $("#JoinButton").click(function() {
            
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
        <%--<div id="main_bg">--%>
        <div>
            <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" />    
           
                <div id="C_container">

                    <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="User" setSUB_TITL="user" />
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; User &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">
				        			                                
                        
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                        </ContentTemplate>
                        </asp:UpdatePanel> 

			            <div class="con_table">
				            <table cellspacing="0" cellpadding="0" class="C_table01">
						        <colgroup>
							        <col width="35%" />
							        <col width="" />
						        </colgroup>
						        <tbody>
							        <tr>
								        <th class="b_none"><span class="red_02">*</span>User ID:</th>
								        <td>
                                            <asp:TextBox ID="UserID" runat="server" Width="240"></asp:TextBox>
									        <span id="UserIDCheckImg"></span>
									        <p class="en_comment" id="UserIDCheckText" style="display: none;"></p>
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
								        <th class="b_none"><span class="red_02">*</span>Secondary Email:</th>
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
							            <th class="b_none"><span class="red_02">*</span>Use Authority:</th>
							            <td>
							                <asp:DropDownList ID="USE_AUTH" runat="server">
                                                <asp:ListItem Text="Active Member" Value="2" Selected></asp:ListItem>
                                                <asp:ListItem Text="Administrator" Value="8"></asp:ListItem>
                                            </asp:DropDownList>	
							            </td>
							        </tr>
						        </tbody>
					        </table><!-- //entry_table -->
			            </div> 
				        <p class="t_center">
					        <span class="btn_type" id="JoinButton"><a href="javascript:;">SAVE</a></span>
					        <span class="btn_type"><a href="javascript:history.back();">CANCEL</a></span>
				        </p>
				        
				        <asp:LinkButton ID="btn_submit" runat="server" OnClick="btn_submit_Click"></asp:LinkButton>

                        </div>
                        <div class="page_top">
			                <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
			            </div>				            
				    </div>          
                </div>
            </div>
            
            <tail:layout id="tail" runat="server" /> 
        </div>
    </form>
</body>
</html>
