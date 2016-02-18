<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="_12sky2.web.mypage.profile" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<common:layout id="common" runat="server"/>
<script type="text/javascript">
	var numEngSExp = /^[0-9a-zA-Z_]{6,16}$/;
	var vMessage = {
			Error_01 : "<%= fnLabelText("msgError_01") %>"
		,	Error_02 : "<%= fnLabelText("msgError_02") %>"
		,	Error_03 : "<%= fnLabelText("msgError_03") %>"
		,	Error_04 : "<%= fnLabelText("msgError_04") %>"
		,	Error_05 : "<%= fnLabelText("msgError_05") %>"
		};

	$(document).ready(function() {
		//닉네임 체크 시작
		$("#NICK_NM").live('keyup', function() {
			$("#formCheckText").html("");
			$("#NicknameCheckText").hide();
			$("#NicknameCheckText").html("");
			$("#NicknameCheckImg").html("");

			if ( $("#NICK_NM").val().length > 5 ) {
				if ( !numEngSExp.test($("#NICK_NM").val()) ) {
					$("#NicknameCheckText").show();
					$("#NicknameCheckText").html(vMessage.Error_01);
					$("#NicknameCheckImg").html('<img src="/hun/images/us/portal/sub/icon_del.jpg" alt="" title=""/>');
					return;
				}

				$.ajax({
					url : "/webservice/services.asmx/getUserNicknameCheck",
					type : "post",
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					data : "{'Nickname':'"+ $("#NICK_NM").val() +"'}",
					success : function(data) {
						var resultCode = data.d;

						$("#NicknameCheckText").show();
						$("#NicknameCheckImg").html("<img src=\"/hun/images/us/portal/sub/icon_del.jpg\" alt=\"\"/>");

						switch ( resultCode ) {
							case "E1":
								$("#NicknameCheckText").html(vMessage.Error_02);
								return;
							case "E2":
							case "E3":
								$("#NicknameCheckText").html(vMessage.Error_03);
								return;
							case "E4":
								$("#NicknameCheckText").html(vMessage.Error_04);
								return;
							case "E5":
								$("#NicknameCheckText").html(vMessage.Error_05);
								return;
							case "OK":
								$("#NicknameCheckText").hide();
								$("#NicknameCheckText").html("");
								$("#NicknameCheckImg").html("<img src=\"/hun/images/us/portal/sub/icon_check.jpg\"/>");
								return;
						}
					},
					error : function() {
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
			<head:layout id="head" runat="server"/>

			<div id="C_container">
				<!-- left menu -->
				<div class="lnb">
					<div class="lnb_tit"><%= fnMainText("mypage") %></div>
					<div class="left_menu">
						<ul>
							<li><a href="/web/mypage/profile.aspx" class="on"><%= fnMainText("profile") %></a></li>
							<li><a href="/web/mypage/password.aspx"><%= fnMainText("password") %></a></li>
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
						<!--ERROR-->
						<div class="message_box" id="formCheckText" style="display:none;">
							error message
						</div>
						<!--//ERROR-->
						<div class="profile">
							<div class="edit_img">
								<ul>
									<li class="profile_img">
										<span id="REPR_IMGE_PATH" runat="server"/>
										<asp:HiddenField id="FILE_PATH" runat="server"/>
									</li>
									<li class="file">
										<asp:FileUpload id="imageFile" onchange="__doPostBack('imageSelect','')" runat="server"/>
										<asp:LinkButton id="imageSelect" OnClick="imageSelect_Click" runat="server"/>
									</li>
									<li class="profile_text">
										<asp:Literal runat="server" meta:resourcekey="lbl_conPage_01"/>
									</li>
									<li>
										<span class="del_img">
											<label>
												<asp:CheckBox id="DEL_IMG" runat="server" style="margin:0 5px 0 0;"/>
												<asp:Literal runat="server" meta:resourcekey="lbl_conPage_02"/>
											</label>
										</span>
									</li>
								</ul>
							</div>
							<div class="con_table" style="background:#f5f5f5; padding:10px 0; margin-top:30px;">
								<table cellspacing="0" cellpadding="0" class="C_table01">
									<caption></caption>
									<colgroup>
										<col width="30%"/>
										<col width="*"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="b_none">
												<span class="red_02">*</span>
												<asp:Literal runat="server" meta:resourcekey="lbl_conPage_03"/>
											</th>
											<td>
												<asp:TextBox id="NICK_NM" runat="server" Width="240"/>
												<span id="NicknameCheckImg"></span>
												<p class="en_comment" id="NicknameCheckText" style="display:none;"></p>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>
												<asp:Literal runat="server" meta:resourcekey="lbl_conPage_04"/>
											</th>
											<td>
												<asp:RadioButtonList id="SEX" runat="server" RepeatDirection="Horizontal">
													<asp:ListItem Value="0" Selected="True" meta:resourcekey="lbl_conPage_05"/>
													<asp:ListItem Value="1" meta:resourcekey="lbl_conPage_06"/>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<th class="b_none"><span class="red_02">*</span>
												<asp:Literal runat="server" meta:resourcekey="lbl_conPage_07"/>
											</th>
											<td>
												<asp:DropDownList id="YYYY" runat="server" Width="100"/>
												<asp:DropDownList id="MM" runat="server" Width="70"/>
												<asp:DropDownList id="DD" runat="server" Width="70"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="t_center">
							<asp:CheckBox id="EMAIL_RECV_YN" runat="server"/>
							<label for="ch_2">
								<asp:Literal runat="server" meta:resourcekey="lbl_conPage_08"/>
							</label>
						</p>
						<p class="t_center">
							<span class="btn_type" id="SaveButton">
								<asp:LinkButton id="btn_save" onclick="btn_save_Click" ToolTip="save" runat="server" meta:resourcekey="lbl_conPage_09"/>
							</span>
						</p>
					</div><!-- -->
					<div class="page_top">
						<a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"/></a>
					</div>
				</div>
			</div>
		</div>

		<tail:layout id="tail" runat="server"/>
	</div>
</form>
</body>
</html>
