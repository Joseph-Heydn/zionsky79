<%@LANGUAGE="VBSCRIPT" %>
<!-- Include file for CAPTCHA configuration -->
<!-- #include file="CAPTCHA/CAPTCHA_configuration.asp" --> 
 
<!-- Include file for CAPTCHA form processing -->
<!-- #include file="CAPTCHA/CAPTCHA_process_form.asp" -->           
<%

'The line below will prevent the rest of the file from processing if the CAPTCHA code is entered incorrectly
'To use the line below remove the comment (') quote mark from in front of the line 
'If blnCAPTCHAcodeCorrect = False Then Call stopProcess()
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Web Wiz CAPTCHA Demo</title>
<style type="text/css">
<!--
.title {font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; }
.header {font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-weight: bold; }
.text {font-size: 12px; font-family: Arial, Helvetica, sans-serif;}
.small {font-size: 10px}
body { background-color: #CCCCCC; }
-->
</style>
</head>
<body>
<div align="center" class="header"> Web Wiz CAPTCHA <br />
  <br />
</div>
<form action="process_form.asp" method="post" name="form1" id="form1">
  <table width="300" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#000000">
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td><span class="title">Demo Form</span></td>
          </tr>
          <tr>
            <td><span class="text">Thank-you
              <% = Server.HTMLEncode(Request("name")) %>
              </span></td>
          </tr>
          <tr>
            <td class="text"><br />
              The CAPTCHA image code was entered:-<br />
              <span class="title"><%


'The variable 'blnCAPTCHAcodeCorrect' will be set to true if the security code is entered correctly

If blnCAPTCHAcodeCorrect Then 
	
	Response.Write("Correctly")
Else

	Response.Write("Incorrectly!!")
End If
              
              
              
              
              %></span><br />
              <br />
              <a href="example.asp">Try Again</a><br />
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
</body>
</html>
