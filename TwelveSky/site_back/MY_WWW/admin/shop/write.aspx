<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="write.aspx.cs" Inherits="_12sky2.admin.shop.write" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2 - Admin Page</title>
    
    <common:layout id="common" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <%--<div id="main_bg">--%>
        <div>
            <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" />    
           
                <div id="C_container">

                    <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="Shop" />
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; Shop &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">
				        			                                 
                        <script type="text/javascript">
                            function setImg(data) {
                                var seq = data.seq;
                                var filename = data.filename;
                                addFile(seq, filename);

                                if (data.imagealign) {
                                    var imageUrl = data.imageurl;
                                    IMG_SRC.innerHTML = "<img src='" + imageUrl + "' width='50'/>";
                                }
                            }

                            function addFile(seq, filename) {
                                $("#_fileList").val(seq);
                            }

                            function imageUpload() {
                                popup("/resources/file/imageUpload.aspx", "imageUplad", 400, 250, 1);
                            }

                            function proc_save() {
                                var str = escape(CKEDITOR.instances.CNTN.getData());
                                save(str);
                            }

                            function save(str) {
                                if (!check_field("ITEM_NM", "Please input to item name!")) return;
                                if (!check_field("SALE_QTY", "Please input to item stock!")) return;
                                if (!check_field("SALE_AMT", "Please input to item cost!")) return;
                                                            
                                $("#_ITEM_NM").val($("#ITEM_NM").val());
                                $("#_SALE_QTY").val($("#SALE_QTY").val());
                                $("#_SALE_AMT").val($("#SALE_AMT").val());
                                $("#_contents").val(str);
                                __doPostBack('btn_save', '');
                            }
                            function number_check() {

                                var txt = window.event.keyCode

                                if ((txt >= 48 && txt <= 57) || (txt >= 96 && txt <= 105) || txt == 9 || txt == 8 || txt == 46 || (txt >= 37 && txt <= 40)) {
                                    window.event.returnValue = true
                                } else {
                                    window.event.returnValue = false
                                }
                            }
                        </script> 
                        
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                        </ContentTemplate>
                        </asp:UpdatePanel> 
                    
                        <asp:HiddenField ID="_ITEM_NM" runat="server" />
                        <asp:HiddenField ID="_SALE_QTY" runat="server" />
                        <asp:HiddenField ID="_SALE_AMT" runat="server" />
                        <asp:HiddenField ID="_contents" runat="server" />
                        <asp:HiddenField ID="_fileList" runat="server" />

			            <div class="con_table">
                            <table cellspacing="0" cellpadding="0" class="I_table">
						        <caption></caption>
						        <colgroup>
							        <col width="15%">
							        <col width="*">
							        <col width="12%">
							        <col width="15%">
						        </colgroup>
						        <thead>
							        <tr>
								        <th>Image</th>
								        <th>Name</th>
								        <th>Stock</th>
								        <th>Cost</th>
							        </tr>
						        </thead>
						        <tbody>
							        <tr>
								        <th rowspan="3">
								            <span id="IMG_SRC" runat="server" />
                                            <div class="btn2" style="margin-top:5px;">
                                                <ul>
                                                    <li><a href="#" onclick="imageUpload();">Insert Image</a></li>
                                                </ul>
                                            </div> 									            
								        </th>
								        <td class="center_b">
                                            <asp:TextBox ID="ITEM_NM" runat="server"></asp:TextBox>								        
								        </td>
								        <td class="center"><asp:TextBox ID="SALE_QTY" runat="server" style="text-align:right" onKeydown="number_check()"></asp:TextBox></td>
								        <td class="center_c">
								            <asp:TextBox ID="SALE_AMT" runat="server" style="text-align:right" onKeydown="number_check()"></asp:TextBox>
								        </td>
							        </tr>
							        <tr>
								        <th class="center" colspan="3">Description</th>
							        </tr>
							        <tr>
								        <td colspan="3">
								            <CKEditor:CKEditorControl ID="CNTN" BasePath="/resources/ckeditor/" runat="server"></CKEditor:CKEditorControl>
								        </td>
							        </tr>
						        </tbody>
					        </table>
			            </div> 
                        <div class="btn">
				            <ul>						            
					            <li><a href="#" onclick="proc_save();">SAVE</a></li>					        
					            <li><asp:LinkButton ID="btn_list" runat="server" ToolTip="list" onclick="btn_list_Click">LIST</asp:LinkButton></li>
					        </ul>
					    </div>
					    <asp:LinkButton ID="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click"></asp:LinkButton>
                        
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
