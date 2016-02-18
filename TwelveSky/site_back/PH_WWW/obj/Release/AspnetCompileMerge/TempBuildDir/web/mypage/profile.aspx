<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="_12sky2.web.mypage.profile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <common:layout id="common" runat="server" />

<script type="text/javascript">
    var numEngSExp = /^[0-9a-zA-Z_]{6,16}$/;

    $(document).ready(function() {
        //닉네임 체크 시작
        $("#NICK_NM").live('keyup', function() {
            $("#formCheckText").html("");
            $("#NicknameCheckText").hide();
            $("#NicknameCheckText").html('');
            $("#NicknameCheckImg").html('');
            if ($("#NICK_NM").val().length > 5) {
                if (!numEngSExp.test($("#NICK_NM").val())) {
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
                    data: "{'Nickname':'" + $("#NICK_NM").val() + "'}",
                    success: function(data) {
                        var resultCode = data.d;

                        $("#NicknameCheckText").show();
                        $("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title="" />');
                        if (resultCode == "E1") {
                            $("#NicknameCheckText").html("To create new account, you should not be logged in.");
                            return;
                        } else if (resultCode == "E2" || resultCode == "E3") {
                            $("#NicknameCheckText").html("Please enter the Nickname");
                            return;
                        } else if (resultCode == "E4") {
                            $("#NicknameCheckText").html("That nick name is already used.");
                            return;
                        } else if (resultCode == "E5") {
                            $("#NicknameCheckText").html("Please create your nickname between 6~16 letters.");
                            return;
                        } else if (resultCode == "OK") {
                            $("#NicknameCheckText").hide();
                            $("#NicknameCheckText").html('');
                            $("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_check.jpg" />');
                            return;
                        }
                    },
                    error: function() {
                        return;
                    }
                });
            }
        });
    }); 
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
				        <div class="lnb_tit">My Page</div>
				        <div class="left_menu">
					        <ul>
						        <li><a href="/web/mypage/profile.aspx" class="on">Profile</a></li>
						        <li><a href="/web/mypage/password.aspx">Change Password</a></li>
						        <li><a href="/web/mypage/myquestions.aspx">Support</a>
							        <ul>
								        <li><a href="/web/mypage/myquestions.aspx">My Questions</a></li>
								        <li><a href="/web/mypage/contact.aspx">Contatct Us</a></li>
							        </ul>
						        </li>
						        <li><a href="/web/mypage/withdrawal.aspx">Deactivate my account</a></li>
					        </ul>
				        </div>
			        </div>
			        <!-- // left menu -->

			        <!-- content -->
			        <div id="contents">
				        <div class="con_top">
					        <div class="nav_hint">Home &gt; My Page &gt; <span class="now">Profile</span></div>
					        <div class="page_tit">Profile</div>
				        </div>

				        <!-- contents start -->
				        <div class="content_page">
					        <!--ERROR--> 
						        <div class="message_box" id="formCheckText" style="display:none;">error message</div>
					        <!--//ERROR-->
					        <div class="profile">
						        <div class="edit_img">
							        <ul>
								        <li class="profile_img">
								            <span id="REPR_IMGE_PATH" runat="server" />
								            <asp:HiddenField ID="FILE_PATH" runat="server" />
								        </li>
								        <li class="file">
                                            <asp:FileUpload ID="imageFile" runat="server" onchange="__doPostBack('imageSelect','')" />
                                            <asp:LinkButton ID="imageSelect" runat="server" OnClick="imageSelect_Click"></asp:LinkButton>
								        </li>
								        <li class="profile_text">
								            Maximum dimensions are 200x200 and the maximum size is 500 kB.
								        </li>
								        <li>
								            <span class="del_img">
                                                <asp:CheckBox ID="DEL_IMG" runat="server" style="margin:0 5px 0 0;" />
								                <label for="del">Delete Image</label>
								            </span>
								        </li>
							        </ul>
						        </div>
						        <div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
							        <table cellspacing="0" cellpadding="0" class="C_table01">
								        <caption></caption>
								        <colgroup>
									        <col width="30%" />
									        <col width="*" />
								        </colgroup>
								        <tbody>
									        <tr>
										        <th class="b_none"><span class="red_02">*</span>Nick Name:</th>
										        <td>
                                                    <asp:TextBox ID="NICK_NM" runat="server" Width="240"></asp:TextBox>
                                                    <span id="NicknameCheckImg"></span>
										            <p class="en_comment" id="NicknameCheckText" style="display: none;"></p>
										        </td>
									        </tr>
									        <tr>
										        <th class="b_none"><span class="red_02">*</span>Gender:</th>
										        <td>
                                                    <asp:RadioButtonList ID="SEX" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="male" Value="0" Selected></asp:ListItem> 
                                                        <asp:ListItem Text="female" Value="1"></asp:ListItem> 
                                                    </asp:RadioButtonList>
									            </td>
									        </tr>
									        <tr>
									            <th class="b_none"><span class="red_02">*</span>Date of Birth:</th>
									            <td>
                                                    <asp:DropDownList ID="YYYY" runat="server" Width="100">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="MM" runat="server" Width="70">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="DD" runat="server" Width="70">
                                                    </asp:DropDownList>
									            </td>
									        </tr>
								        </tbody>
							        </table>
						        </div>
					        </div>
					        <p class="t_center">
                                <asp:CheckBox ID="EMAIL_RECV_YN" runat="server" />
					            <label for="ch_2">Send me news about special events and offers from 12SKY2.</label>
					        </p>
					        <p class="t_center">
					            <span class="btn_type" id="SaveButton">
					                <asp:LinkButton ID="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click">SAVE</asp:LinkButton>
					            </span>
					        </p>
				        </div><!-- -->
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
