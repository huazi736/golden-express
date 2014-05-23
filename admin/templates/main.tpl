<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>main</title>
<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
<style type="text/css">
{literal}
body {margin:0;padding:0;font-size:12px;font-family:Verdana;}
body {background:#F5FCFF}
.bottom{text-align:center;height:30px;line-height:30px;border-top:1px solid #b8d3e1;margin-top:20px;width:100%}
{/literal}
.logo {literal}{{/literal}
	background:url({$url_images}logo.png) center top no-repeat;height:64px;width:210px;
	_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{$url_images}logo.png");
	_background:none;
{literal}}{/literal}

</style>
</head>
<body>
<br />
<table border="0" align="center" cellpadding="4" cellspacing="1">
<tr>
	<td>
		<img src="{$url_images}spacer.gif" alt="" align="center" class="logo"/>
	</td>
</tr>
</table>

<br />
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="2" height="25" class="title">系统信息</td>
  </tr>
  <tr>
    <td width="14%" class="line">客户端IP:</td>
    <td width="86%" class="line">{php}echo $_SERVER['REMOTE_ADDR']{/php}</td>
  </tr>
  <tr>
    <td width="14%" class="line">服务器IP:</td>
    <td width="86%" class="line">{php}echo $_SERVER['SERVER_ADDR']{/php}</td>
  </tr>
  <tr>
    <td width="14%" class="line">操作系统版本:</td>
    <td width="86%" class="line">{php}echo php_uname(){/php}</td>
  </tr>
  <tr>
    <td class="line">PHP版本:</td>
    <td class="line">{php} echo PHP_VERSION {/php}</td>
  </tr>
  <tr>
    <td>服务器时间:</td>
    <td>{php} echo date("Y年m月d日 H:i:s") {/php}</td>
  </tr>
  <tr>
   <td>详细信息:</td>
    <td><a href="main.php?do=phpinfo" target="_blank">phpinfo</a></td>
  </tr>
  
</table>
<br />
<div class="bottom">{$cfg.footer}</div>
</body>
</html>