<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="_12sky2.web.mypage.contact" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <common:layout id="common" runat="server" />
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
						        <li><a href="/web/mypage/profile.aspx">Profile</a></li>
						        <li><a href="/web/mypage/password.aspx">Change Password</a></li>
						        <li><a href="/web/mypage/myquestions.aspx" class="on">Support</a>
							        <ul>
								        <li><a href="/web/mypage/myquestions.aspx">My Questions</a></li>
								        <li><a href="/web/mypage/contact.aspx" class="on">Contact Us</a></li>
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
					        <div class="nav_hint">Home &gt; My Page &gt; Support &gt; <span class="now">Contact Us</span></div>
					        <div class="page_tit">Contact Us</div>
				        </div>   
				        
				        <!-- contents start -->
				        <div class="content_page">
				            <div class="con_table">
						        <table cellpadding="0" cellspacing="0" class="C_table01">
							        <colgroup>
								        <col width="25%">
								        <col width="">
							        </colgroup>
							        <tbody>            
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Category:</th>
									        <td>     
                                                <asp:DropDownList ID="QUST_CD_1" runat="server" onselectedindexchanged="QUST_CD_1_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="QUST_CD_2" runat="server">
                                                </asp:DropDownList>
									        </td>
								        </tr>            
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Nick Name:</th>
                                            <td>
                                                <asp:TextBox ID="NICK_NM" runat="server" Width="240"></asp:TextBox>
									        </td>
								        </tr>
        											 
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Subject:</th>
									        <td>
									            <asp:TextBox ID="TITL" runat="server" Width="495" MaxLength="50"></asp:TextBox>
									        </td>
								        </tr>
        											 
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Send Email:</th>
									        <td>
									            <CKEditor:CKEditorControl ID="CNTN" BasePath="/resources/ckeditor/" runat="server"></CKEditor:CKEditorControl>
									        </td>
								        </tr>
        											 
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Attached file.1:</th>
									        <td>
                                                <asp:FileUpload ID="FileUpload1" runat="server" />
                                                <asp:HiddenField ID="FILE_PATH_1" runat="server" />
									        </td>
								        </tr>
        											 
								        <tr id="file2add" style="display:none;">
									        <th class="b_none"><span class="red_02">*</span>Attached file.2:</th>
									        <td>
									            <asp:FileUpload ID="FileUpload2" runat="server" />
									            <asp:HiddenField ID="FILE_PATH_2" runat="server" />
									        </td>
								        </tr>

								        <tr id="file3add" style="display:none;">
									        <th class="b_none"><span class="red_02">*</span>Attached file.3:</th>
									        <td>
									            <asp:FileUpload ID="FileUpload3" runat="server" />
									            <asp:HiddenField ID="FILE_PATH_3" runat="server" />
									        </td>
								        </tr>

								        <tr id="file4add" style="display:none;">
									        <th class="b_none"><span class="red_02">*</span>Attached file.4:</th>
									        <td>
									            <asp:FileUpload ID="FileUpload4" runat="server" />
									            <asp:HiddenField ID="FILE_PATH_4" runat="server" />
									        </td>
								        </tr>

								        <tr id="file5add" style="display:none;">
									        <th class="b_none"><span class="red_02">*</span>Attached file.5:</th>
									        <td>
									            <asp:FileUpload ID="FileUpload5" runat="server"/>
									            <asp:HiddenField ID="FILE_PATH_5" runat="server" />
									        </td>
								        </tr>
        											 
								        <tr>
									        <th class="b_none"><span class="red_02">*</span>Add file:</th>
									        <td><span class="btn_type" id="AddFileButton"><a href="javascript:;">ADD ATTACHED FILE</a></span></td>
								        </tr>
							        </tbody>
						        </table>
					        </div>

					        <p class="t_center01">* You are allowed to upload maximum 5 files, each files should be less than 1MB.</p>
						        <div class="message01">
							        <div class="message" id="checkMessage" style="display:none;"></div>
						        </div>

					        <p class="t_center">
					          <span class="btn_type" id="SaveButton"><a href="javascript:;">SAVE</a></span>      
					        </p>					        
				        </div><!-- -->
				        
<script type="text/javascript">
    $(document).ready(function() {
        var fileCnt = 1;
        $("#AddFileButton").click(function() {
            fileCnt = fileCnt + 1;
            if (fileCnt == 2) {
                $("#file2add").show();
                return;
            } else if (fileCnt == 3) {
                $("#file3add").show();
                return;
            } else if (fileCnt == 4) {
                $("#file4add").show();
                return;
            } else if (fileCnt == 5) {
                $("#file5add").show();
                return;
            } else {
                $("#checkMessage").show();
                $("#checkMessage").html("Up to five files can be attached.");
                return;
            }
        });

        $("#SaveButton").click(function() {
            if ($("#QUST_CD_1 option:selected").val() == "") {
                $("#checkMessage").show();
                $("#checkMessage").html("Please select The " + categoryIDName1);
                return;
            }

            if ($("#QUST_CD_2 option:selected").val() == "") {
                $("#checkMessage").show();
                $("#checkMessage").html("Please select The " + categoryIDName2);
                return;
            }

            if ($("#TITL").val() == "") {
                $("#checkMessage").show();
                $("#checkMessage").html("Please enter your Subject.");
                return;
            }

            var str = escape(CKEDITOR.instances.CNTN.getData());
            if (str == "") {
                $("#checkMessage").show();
                $("#checkMessage").html("Please enter your ContactContents.");
                return;
            }

            __doPostBack('btn_submit', '');
        });

    });
</script>		
<asp:LinkButton ID="btn_submit" runat="server" ToolTip="save" onclick="btn_submit_Click"></asp:LinkButton>		        
        					
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
