<%@ Page
	Language="C#"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="login.aspx.cs"
	Inherits="Web.Manage.login"
%>
<!DOCTYPE html>
<html>
<head>
<title>On Audit | Log in</title>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="/_common/bootstrap/css/bootstrap.min.css"/>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"/>
<!-- Ionicons -->
<link rel="stylesheet" href="/_common/ionicons/css/ionicons.min.css"/>
<!-- Theme style -->
<link rel="stylesheet" href="/_common/dist/css/AdminLTE.min.css"/>
<!-- iCheck -->
<link rel="stylesheet" href="/_common/plugins/iCheck/square/blue.css"/>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
	<script src="/_common/_js/plugin/html5shiv.min.js"></script>
	<script src="/_common/_js/plugin/respond.min.js"></script>
<![endif]-->
</head>

<body class="hold-transition login-page">
<form method="post" runat="server">
	<div class="login-box">
		<div class="login-logo">
			<b><asp:Literal runat="server" meta:resourcekey="lblTitle_01"/></b>
			<asp:Literal runat="server" meta:resourcekey="lblTitle_02"/>
			<asp:HiddenField id="pReturn" runat="server"/>
		</div>
		<!-- /.login-logo -->

		<div class="login-box-body">
			<p class="login-box-msg">
				<asp:Literal runat="server" meta:resourcekey="lblinfo_text"/>
			</p>
			<div class="form-group has-feedback">
				<asp:TextBox id="txtAccountId" TextMode="Email" class="form-control" runat="server" meta:resourcekey="lblAccount"/>
				<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
			</div>
			<div class="form-group has-feedback">
				<asp:TextBox id="txtPassword" TextMode="Password" class="form-control" runat="server" meta:resourcekey="lblPassword"/>
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<div class="row">
				<div class="col-xs-8">
					<div class="checkbox icheck">
						<label>
							<input id="chkSaveId" type="checkbox"/>
							<asp:Literal runat="server" meta:resourcekey="lblRemember"/>
						</label>
					</div>
				</div><!-- /.col -->
				<div class="col-xs-4">
					<asp:Button OnClick="btnLogin_Click" OnClientClick="fnSaveAccount();" class="btn btn-primary btn-block btn-flat" runat="server" meta:resourcekey="lblsignIn"/>
				</div><!-- /.col -->
			</div>

			<a href="#">
				<asp:Literal runat="server" meta:resourcekey="lblForgot"/>
			</a><br>
			<a href="/register.aspx" class="text-center">
				<asp:Literal runat="server" meta:resourcekey="lblRegister"/>
			</a>
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
</form>

<!-- jQuery 2.1.4 -->
<script type="text/javascript" src="/_common/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script type="text/javascript" src="/_common/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script type="text/javascript" src="/_common/plugins/iCheck/icheck.min.js"></script>
<script type="text/javascript" src="/_common/_js/__common.js"></script>

<script type="text/javascript">
	$(function () {
		$("input").iCheck(
			{	checkboxClass: "icheckbox_square-blue"
			,	radioClass: "iradio_square-blue"
			,	increaseArea: "20%" // optional
			}
		);
	});

	var txtAccountId = $("#<%= txtAccountId.ClientID %>");
	function fnSaveAccount() {
		if ( $("#chkSaveId").prop("checked") && txtAccountId.val().length > 1 ) {
			fnSetCookie("pAccountId", txtAccountId.val(), 30);
		} else {
			fnDropCookie("pAccountId");
		}
	}

	txtAccountId.val(fnGetCookie("pAccountId"));
	if ( txtAccountId.val().length > 1 ) {
		$("#chkSaveId").prop("checked", true);
	}
</script>
</body>
</html>
