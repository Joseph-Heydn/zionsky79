<%@ Page
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="findAccount.aspx.cs"
	Inherits="Web.TwelveSky.web.email.findAccount"
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>

<body>
<div>
	<table style="width:650px; border:0; border-spacing:0; padding:0; background-color:#dedede;">
		<colgroup>
			<col style="width:10px;"/>
			<col style="width:315px;"/>
			<col style="width:315px;"/>
			<col style="width:10px;"/>
		</colgroup>
		<tbody>
			<tr>
				<td style="height:60px;"></td>
				<td>
					<a href="<%= gDomain %>" target="_blank">
						<img src="<%= gDomain %>/_common/_images/img/kjgames_logo.png" style="margin-left:10px; border:0;" alt="KJ GAMES"/>
					</a>
				</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2">
					<table style="width:630px; border:0; border-spacing:0; padding:0; background-color:#dedede;">
						<tbody>
							<tr>
								<td style="font-family:verdana; font-size:22px; font-weight:bold; color:#c30; line-height:25px; padding:20px 0; text-align:center; background-color:#fff;">
									<br/>
									<asp:Literal runat="server" meta:resourcekey="lblWelcome"/>
								</td>
							</tr>
							<tr>
								<td style="background-color:#fff;">
									<table style="width:590px; border:0; border-spacing:0; padding:0; text-align:center;">
										<tbody>
											<tr style="height:1px;">
												<td style="background-color:#ccc;"></td>
											</tr>
											<tr>
												<td style="padding:50px 20px;font-family:verdana;font-size:12px;line-height:20px">
													<%= Request.QueryString["pParam_01"] %>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2" style="text-align:center;">
					<table style="width:580px; border:0; border-spacing:0; padding:0;">
						<tbody>
							<tr>
								<td style="height:20px;"></td>
							</tr>
							<tr>
								<td style="font-family:verdana; font-size:10px; color:#363636; line-height:13px; text-align:center;">
									<asp:Literal runat="server" meta:resourcekey="lblBottom"/><br/><br/>
									<asp:Literal runat="server" meta:resourcekey="lblCopyRight"/>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4" style="height:30px;"></td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>
