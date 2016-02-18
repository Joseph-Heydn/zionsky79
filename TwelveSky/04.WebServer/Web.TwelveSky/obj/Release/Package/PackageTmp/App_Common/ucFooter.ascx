<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="ucFooter.ascx.cs"
	Inherits="Web.TwelveSky.App_Common.ucFooter"
%>
<div id="footer">
	<div class="f_wrap">
		<div style="width:65%; display:inline-block; color:#979797;">
			<div style="width:105px; display:inline-block; vertical-align:top;">
				<img src="/_common/_images/img/kjgames_logo.png" alt="KJ GAMES" title="KJ GAMES"/>
			</div>
			<div style="display:inline-block; font-weight:normal;">
				<asp:Literal runat="server" meta:resourcekey="lbl_copyright"/><br/>
				<asp:Literal runat="server" meta:resourcekey="lbl_Addr"/><br/>
				<asp:Literal runat="server" meta:resourcekey="lbl_Email"/>&nbsp;&nbsp;
				<asp:Literal runat="server" meta:resourcekey="lbl_Business"/>
			</div>
		</div>
		<div style="width:35%; float:right; text-align:right; display:inline-block;">
			<a href="javascript:fnPolicy(18);" target="_blank">
				<asp:Literal runat="server" meta:resourcekey="lbl_terms"/>
			</a>|
			<a href="javascript:fnPolicy(19);" target="_blank">
				<asp:Literal runat="server" meta:resourcekey="lbl_privacy"/>
			</a>
		</div>
	</div>
</div>
