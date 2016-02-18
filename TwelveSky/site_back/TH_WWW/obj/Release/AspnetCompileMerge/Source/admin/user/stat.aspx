<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="stat.aspx.cs" Inherits="_12sky2.admin.user.stat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
        
    <common:layout id="common" runat="server" />

    <link rel="stylesheet" href="/resources/css/custom-theme/jquery-ui-1.8.11.custom.css" type="text/css"  charset="utf-8" />
    <link rel='stylesheet' type='text/css' href='/resources/css/redmond/theme.css' />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="wrap">
                <admin_head:layout id="admin_head" runat="server" />
                
<script type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function EndRequestHandler(sender, args) {
        if (args.get_error() == undefined) {
            jqueryReady();
        }
    }
    function jqueryReady() {
        $(document).ready(function() {
            $("#STRT_DT").datepicker({
                changeYear: true
                , changeMonth: true
                , monthNames: ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
                , monthNamesShort: ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
                , dateFormat: 'yy-mm-dd'
                , dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                , dayNamesShort: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                , onSelect: function(dateText, inst) {
                    checkDTM();
                }
            });
            $("#END_DT").datepicker({
                changeYear: true
                , changeMonth: true
                , monthNames: ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
                , monthNamesShort: ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
                , dateFormat: 'yy-mm-dd'
                , dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                , dayNamesShort: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                , onSelect: function(dateText, inst) {
                    checkDTM();
                }
            });
        });
    }
    jqueryReady();

    function checkDTM() {
        if ($("#STRT_DT").val() && $("#END_DT").val()) {
            var sDateArray = $("#STRT_DT").val().split("-");
            var sDate = new Date(sDateArray[0], Number(sDateArray[1]) - 1, sDateArray[2]);
            var eDateArray = $("#END_DT").val().split("-");
            var eDate = new Date(eDateArray[0], Number(eDateArray[1]) - 1, eDateArray[2]);

            take1 = sDate.getTime();
            take2 = eDate.getTime();
            how_day = Math.ceil((take2 - take1) / 24 / 60 / 60 / 1000);
            how_Nday = how_day + 1;

            if (how_day < 0 || how_Nday < 0) {
                $("#END_DT").val('');
                alert('Start and end dates are incorrect!');
                return;
            }
        }
        else if ($("#STRT_DT").val()) {
            $("#END_DT").val($("#STRT_DT").val());

        }
        else if ($("#END_DT").val()) {
            $("#STRT_DT").val($("#END_DT").val());
        }
    }

    function fnExcelReport() {
        var tab_text = "<table border='2px'><tr>";
        var textRange; var j = 0;
        tab = document.getElementById('userList'); // id of table

        for (j = 0; j < tab.rows.length; j++) {
            tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
            //tab_text=tab_text+"</tr>";
        }

        tab_text = tab_text + "</table>";
        tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, ""); //remove if u want links in your table
        tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
        tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");

        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
        {
            txtArea1.document.open("txt/html", "replace");
            txtArea1.document.write(tab_text);
            txtArea1.document.close();
            txtArea1.focus();
            sa = txtArea1.document.execCommand("SaveAs", true, "Signup User Count.xls");
        }
        else                 //other browser not tested on IE 11
            sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));

        return (sa);
    }  
</script>                
<iframe id="txtArea1" style="display:none"></iframe>
                
                <div id="C_container">                    
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                    
                    <!-- left menu -->
                    <admin_left:layout id="admin_left" runat="server" setTITL="User" setSUB_TITL="stat" />
                    			        
                    <!-- content -->
                    <div id="contents">
                    	<div class="con_top">
					        <div class="nav_hint">Home &gt; User &gt; <span id="NAV_TITL" runat="server" class="now"></span></div>
					        <div class="page_tit"><span id="PAGE_TITL" runat="server"></span></div>
				        </div>
				        
				        <!-- contents start -->
				        <div class="content_page">  
				            <table width="100%">
				                <tr>
				                    <td>
				                        <asp:TextBox ID="STRT_DT" runat="server" Width="80"/>
				                        ~ <asp:TextBox ID="END_DT" runat="server" width="80"/>
				                        <asp:Button ID="btn_search" runat="server" Text="Search" onclick="btn_search_Click" />				                        
				                    </td>
				                    <td>
				                        <div class="btn">
                                            <ul>
                                                <li><a href="#" onclick="fnExcelReport();">Excel</a></li>
                                            </ul>
                                        </div>
				                    </td>
				                    
				                </tr>
				            </table>             	                            
                            <div class="con_table">
						        <table id="userList" cellspacing="0" cellpadding="0" class="N_table">
							        <caption></caption>
							        <colgroup>
								        <col width="40%">
								        <col width="30%">
								        <col width="30%">
							        </colgroup>
							        <thead>
								        <tr>
									        <th>Register Date</th>
									        <th>Unauthorized Member Count</th>
									        <th>Authorized Member Count</th>
								        </tr>
							        </thead>						        
                                    <tbody>
                                        <asp:Repeater ID="LIST" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.DT")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.CNT1")%></td>
                                                    <td class="center"><%# DataBinder.Eval(Container, "DataItem.CNT2")%></td>
                                                </tr>
                                            </ItemTemplate>                                
                                        </asp:Repeater>
                                        <asp:Panel ID="NO_LIST" runat="server" Visible="false">
                                            <tr>
                                                <td colspan="5" class="center">no data</td>
                                            </tr>
                                        </asp:Panel>
                                    </tbody>
                                </table>
                            </div>                       
                        </div>
                        <div class="page_top">
				            <a href="#"><img src="/resources/images/con_img/btn_pagetop.gif" alt="top" title="top"></a>
				        </div>
				    </div>
                    </ContentTemplate>
                    </asp:UpdatePanel>  
                </div>
            </div>
            
            <tail:layout id="tail" runat="server" /> 
        </div>
    </form>
</body>
</html>
