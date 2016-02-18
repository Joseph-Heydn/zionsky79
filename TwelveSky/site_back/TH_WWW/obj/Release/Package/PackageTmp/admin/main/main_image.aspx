<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main_image.aspx.cs" Inherits="_12sky2.admin.main.main_image" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Twelvesky2 - Admin Page</title>
    
    <common:layout id="common" runat="server" />
    
    <style type="text/css">
        .preView { width:120px; height:120px; text-align:center; border:1px solid silver; }
    </style>    
    
</head>
<body>
    <form id="form1" runat="server">
        <%--<div id="main_bg">--%>
        <div>
            <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" /> 

                <div id="C_container">
	
	                <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="Main" setSUB_TITL="main_image" />
                                        			        
                    <!-- content -->
                    <div id="contents">
                        <div class="con_top">
					        <div class="nav_hint">Home &gt; Main &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">
				            
                            <script type="text/javascript">
                                function setImg(data) {
                                    var seq = data.seq;
                                    var filename = data.filename;
                                    addFile(seq, filename);

                                    var imageUrl = data.imageurl;
                                    var _add = "<img src='" + imageUrl + "' width='500' height='320'/>";

                                    $("#TEMP_FILE_LIST").html($("#TEMP_FILE_LIST").html() + _add);
                                }

                                function addFile(seq, filename) {
                                    if ($("#_fileList").val()) $("#_fileList").val($("#_fileList").val() + "," + seq);
                                    else $("#_fileList").val(seq);
                                }

                                function fileDelete(seq, typ) {
                                    var target = $("#file_" + seq).html();
                                    $("#EDIT_FILE_LIST").html($("#EDIT_FILE_LIST").html().replace(target, ''));

                                    if ($("#DEL_FILE_SEQ").val()) $("#DEL_FILE_SEQ").val($("#DEL_FILE_SEQ").val() + "," + seq);
                                    else $("#DEL_FILE_SEQ").val(seq);

                                }
                                
                                function imageUpload() {
                                    popup("/resources/file/imageUpload.aspx", "imageUplad", 400, 250, 1);
                                }

                                function proc_save() {
                                    $("#_title").val($("#TITL").val());
                                    $("#_relt_link").val($("#RELT_LINK").val());
                                    $("#FILE_SEQ").val($("#_fileList").val());
                                    $("#_SORT_ORD").val($("#SORT_ORD").val());
                                    
                                    __doPostBack('btn_save', '');
                                }
                            </script>	
                        
                            <asp:HiddenField ID="_fileList" runat="server" />
                            <asp:HiddenField ID="FILE_SEQ" runat="server" />
                            <asp:HiddenField ID="DEL_FILE_SEQ" runat="server" />
                            <asp:HiddenField ID="_title" runat="server" />
                            <asp:HiddenField ID="_relt_link" runat="server" />
                            <asp:HiddenField ID="_SORT_ORD" runat="server" />
                        
                            <asp:HiddenField ID="MODE" runat="server" />
                            <asp:HiddenField ID="SEQ" runat="server" />
                            
                            <div>
                            	<div class="con_tit">Main Slide Image Upload</div>
                            	<div class="admin_red">※ Image size has been optimized for 500 X 320</div>
			                    <div class="con_table" style="border:1px solid #ccc;">                            
			                        
				                    <table cellspacing="0" cellpadding="0" class="N_table">
				                        <tbody>
                                            <tr>
                                                <th class="left" style="width:100px;">Title</th>
                                                <td>
                                                    <asp:TextBox ID="TITL" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="left">RELT_LINK</th>
                                                <td>
                                                    <asp:TextBox ID="RELT_LINK" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="left">IMAGE</th>
                                                <td>
                                                    <div class="btn2" style="margin-left:0">
                                                        <ul>
                                                            <li><a href="#" onclick="imageUpload();">Insert Image</a></li>
                                                        </ul>
                                                    </div>
                                                    <div style="float:left; width:100%; padding-top:10px;">
                                                        <span id="TEMP_FILE_LIST"></span>
                                                        <span id="EDIT_FILE_LIST" runat="server"></span>
                                                    </div>
                                                </td>
                                            </tr> 
                                            <tr>
                                                <th class="left">SORT ORDER</th>
                                                <td>
                                                    <asp:TextBox ID="SORT_ORD" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>                                    
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn">
				                    <ul>
				                        <li><a href="#" onclick="proc_save();">SAVE</a></li>						            
					                </ul>
					            </div>
					            <asp:LinkButton ID="btn_save" runat="server" ToolTip="save" onclick="btn_save_Click"></asp:LinkButton>                                
			                </div>
			                
                            <!-- LIST -->      
                            <div class="line">
                                <div class="con_tit">Main Slide Image List</div>			                
                                <asp:Repeater ID="LIST" runat="server">
                                <ItemTemplate>	
                               
                                <div class="con_table" style="border:1px solid #ccc;">                                              
				                <table cellspacing="0" cellpadding="0" class="N_table">			                
				                    <tbody>
				                        <tr>
				                            <td>
				                                <%=DATA_NUM()%> 
				                            </td>
				                            <td>
				                                <asp:LinkButton ID="btn_edit" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' onclick="btn_edit_Click">EDIT</asp:LinkButton>
				                                <asp:LinkButton ID="btn_del" runat="server" CommandName='<%# DataBinder.Eval(Container, "DataItem.SEQ")%>' onclick="btn_del_Click">DELETE</asp:LinkButton>
				                            </td>
				                        </tr>				                    
                                        <tr>
                                            <td style="width:100px;">Title</td>
                                            <td>
                                                <%# DataBinder.Eval(Container, "DataItem.TITL") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>RELT_LINK</td>
                                            <td>
                                                <%# DataBinder.Eval(Container, "DataItem.RELT_LINK") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>IMAGE</td>
                                            <td>
                                                <%# DataBinder.Eval(Container, "DataItem.IMG_SRC") %>
                                            </td>
                                        </tr>     
                                        <tr>
                                            <td>Sort Order</td>
                                            <td>
                                                <%# DataBinder.Eval(Container, "DataItem.SORT_ORD") %>
                                            </td>                                            
                                        </tr>                                                                    
                                    </tbody>
                                </table> 
                                </div> 
                                </ItemTemplate>
                            </asp:Repeater>   
                            </div>
                             
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
