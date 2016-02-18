<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="_12sky2.web.mypage.contact" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<common:layout id="common" runat="server"/>
<script type="text/javascript">
	$(document).ready(function() {
		var fileCnt = 1;
		var vMessage = {
				Alert_01 : "<%= fnLabelText("msgAlert_01") %>"
			,	Alert_02 : "<%= fnLabelText("msgAlert_02") %>"
			,	Alert_03 : "<%= fnLabelText("msgAlert_03") %>"
			,	Alert_04 : "<%= fnLabelText("msgAlert_04") %>"
			,	Alert_05 : "<%= fnLabelText("msgAlert_05") %>"
			};

		$("#AddFileButton").click(function() {
			fileCnt = fileCnt + 1;
			if ( fileCnt === 2 ) {
				$("#file2add").show();
				return;
			} else if ( fileCnt === 3 ) {
				$("#file3add").show();
				return;
			} else if ( fileCnt === 4 ) {
				$("#file4add").show();
				return;
			} else if ( fileCnt === 5 ) {
				$("#file5add").show();
				return;
			} else {
				$("#checkMessage").show();
				$("#checkMessage").html(vMessage.Alert_01);
				return;
			}
		});

		$("#SaveButton").click(function() {
			if ( $("#QUST_CD_1 option:selected").val() === "" ) {
				$("#checkMessage").show();
				$("#checkMessage").html(vMessage.Alert_02);
				return;
			}
			if ( $("#QUST_CD_2 option:selected").val() === "" ) {
				$("#checkMessage").show();
				$("#checkMessage").html(vMessage.Alert_03);
				return;
			}
			if ( $("#TITL").val() === "" ) {
				$("#checkMessage").show();
				$("#checkMessage").html(vMessage.Alert_04);
				return;
			}

			var str = escape(CKEDITOR.instances.CNTN.getData());
			if ( str === "" ) {
				$("#checkMessage").show();
				$("#checkMessage").html(vMessage.Alert_05);
				return;
			}

			__doPostBack('btn_submit', '');
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
					<div class="lnb_tit">My Page</div>
					<div class="left_menu">
						<ul>
							<li><a href="/web/mypage/profile.aspx"><%= fnMainText("profile") %></a></li>
							<li><a href="/web/mypage/password.aspx"><%= fnMainText("password") %></a></li>
							<li><a href="/web/mypage/myquestions.aspx" class="on"><%= fnMainText("support") %></a>
								<ul>
									<li><a href="/web/mypage/myquestions.aspx"><%= fnMainText("myQuestion") %></a></li>
									<li><a href="/web/mypage/contact.aspx" class="on"><%= fnMainText("contatct") %></a></li>
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
						<div class="con_table">
							<table cellpadding="0" cellspacing="0" class="C_table01">
								<colgroup>
									<col width="25%"/>
									<col/>
								</colgroup>
								<tbody>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Category:</th>
										<td>
											<asp:DropDownList id="QUST_CD_1" runat="server" onselectedindexchanged="QUST_CD_1_SelectedIndexChanged" AutoPostBack="true">
											</asp:DropDownList>
											<asp:DropDownList id="QUST_CD_2" runat="server">
											</asp:DropDownList>
										</td>
									</tr>
									<tr>
										<th class="b_none"><span class="red_02">*</span>Nick Name:</th>
										<td>
											<asp:TextBox id="NICK_NM" runat="server" Width="240"></asp:TextBox>
										</td>
									</tr>

									<tr>
										<th class="b_none"><span class="red_02">*</span>Subject:</th>
										<td>
											<asp:TextBox id="TITL" runat="server" Width="495" MaxLength="50"></asp:TextBox>
										</td>
									</tr>

									<tr>
										<th class="b_none"><span class="red_02">*</span>Send Email:</th>
										<td>
											<CKEditor:CKEditorControl id="CNTN" BasePath="/resources/ckeditor/" runat="server"></CKEditor:CKEditorControl>
										</td>
									</tr>

									<tr>
										<th class="b_none"><span class="red_02">*</span>Attached file.1:</th>
										<td>
											<asp:FileUpload id="FileUpload1" runat="server"/>
											<asp:HiddenField id="FILE_PATH_1" runat="server"/>
										</td>
									</tr>

									<tr id="file2add" style="display:none;">
										<th class="b_none"><span class="red_02">*</span>Attached file.2:</th>
										<td>
											<asp:FileUpload id="FileUpload2" runat="server"/>
											<asp:HiddenField id="FILE_PATH_2" runat="server"/>
										</td>
									</tr>

									<tr id="file3add" style="display:none;">
										<th class="b_none"><span class="red_02">*</span>Attached file.3:</th>
										<td>
											<asp:FileUpload id="FileUpload3" runat="server"/>
											<asp:HiddenField id="FILE_PATH_3" runat="server"/>
										</td>
									</tr>

									<tr id="file4add" style="display:none;">
										<th class="b_none"><span class="red_02">*</span>Attached file.4:</th>
										<td>
											<asp:FileUpload id="FileUpload4" runat="server"/>
											<asp:HiddenField id="FILE_PATH_4" runat="server"/>
										</td>
									</tr>

									<tr id="file5add" style="display:none;">
										<th class="b_none"><span class="red_02">*</span>Attached file.5:</th>
										<td>
											<asp:FileUpload id="FileUpload5" runat="server"/>
											<asp:HiddenField id="FILE_PATH_5" runat="server"/>
										</td>
									</tr>

									<tr>
										<th class="b_none"><span class="red_02">*</span>Add file:</th>
										<td><span class="btn_type" id="AddFileButton"><a href="javascript:;">ADD ATTACHED FILE</a></span></td>
									</tr>
								</tbody>
							</table>
						</div>

						<p class="t_center01">Bạn được phép tải tối đa la 5 File, mỗi File nhỏ hơn 1MB.</p>
							<div class="message01">
								<div class="message" id="checkMessage" style="display:none;"></div>
							</div>

						<p class="t_center">
						  <span class="btn_type" id="SaveButton"><a href="javascript:;">SAVE</a></span>
						</p>
					</div><!-- -->

					<asp:LinkButton id="btn_submit" runat="server" ToolTip="save" onclick="btn_submit_Click"></asp:LinkButton>

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
