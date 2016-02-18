<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="_12sky2.admin.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <common:layout id="common" runat="server" />
    
    <script type="text/javascript">
        function EnterEvent(e) {
            if (e.keyCode == 13) {
                __doPostBack("btn_login", "");
            }
        }
       
    </script>

    <style>
        .admin_login {position:absolute; top:30%; left:40%; width:440px; padding:20px; background:#dbdbdb; border:1px solid #bbb; border-radius:5px;}
        .admin_login01 {float:left; background:#454545; padding:20px; width:400px; border:1px solid #aaa; border-radius:5px 5px 0 0; font-size:18px; color:#fff;}
        .loginform {float:left; background:#c8c8c8; padding:50px; border:1px solid #aaa;}
        .admin_bottom {float:left; width:420px; text-align:right; background:#999; padding:10px; border:1px solid #aaa; border-radius:0 0 5px 5px;}
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="wrap">
			    <div class="admin_login">
				    <div class="admin_login01">Administrator Login</div>
				    <div class="loginform">
                        <div class="login_input" style="background:none; width:340px; height:100px;">
                            <ul class="input_box" style="width:250px; margin-left:0;">
                                <li style="margin-bottom:5px;">
                                    <label for="id" id="label1" class="lbl_in">ID</label>
                                    <asp:TextBox ID="ID" runat="server" MaxLength="41" ToolTip="ID" CssClass="int"  style="margin-left:56px"></asp:TextBox>
                                </li>
                                <li>
                                    <label for="pw" id="label2" class="lbl_in">PASSWORD</label>
                                    <asp:TextBox ID="PSWD" runat="server" TextMode="Password" MaxLength="16" ToolTip="PASSWORD" CssClass="int" onkeypress="return EnterEvent(event)"></asp:TextBox>
                                </li>
                            </ul>
                            <ul class="login_btn" style="margin-top:21px; margin-left: 10px;">
                                <li>
                                    <asp:LinkButton ID="btn_login" runat="server" OnClick="btn_login_Click"><img src="/resources/images/img/login_btn.png" alt="" /></asp:LinkButton>						        
                                </li>
                            </ul>                
                        </div>
                    </div>
                    <div class="admin_bottom"><img src="/resources/images/img/kjgames_logo.png" alt="" /></div>
                </div>         
            </div>
        </div>
    </form>
</body>
</html>
