<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="tail.ascx.cs"
	Inherits="_12sky2.web.include.tail"
%>
<div id="footer">
	<div class="f_wrap">
		<div style="width:65%; display:inline-block; color:#979797;">
			<div style="width:105px; display:inline-block; vertical-align:top;">
				<img src="/resources/images/img/kjgames_logo.png" alt="KJ GAMES" title="KJ GAMES"/>
			</div>
			<div style="display:inline-block; font-weight:normal;">
				<asp:Literal runat="server" meta:resourcekey="lbl_copyright"/><br/>
				<asp:Literal runat="server" meta:resourcekey="lbl_Addr"/><br/>
				<asp:Literal runat="server" meta:resourcekey="lbl_Email"/>&nbsp;&nbsp;
				<asp:Literal runat="server" meta:resourcekey="lbl_Business"/>
			</div>
		</div>
		<div style="width:35%; float:right; text-align:right; display:inline-block;">
			<a href="/web/about/terms.aspx" target="_blank">
				<asp:Literal runat="server" meta:resourcekey="lbl_terms"/>
			</a>|
			<a href="/web/about/privacy.aspx" target="_blank">
				<asp:Literal runat="server" meta:resourcekey="lbl_privacy"/>
			</a>
		</div>
	</div>
</div>
