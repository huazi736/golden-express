<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>top</title>
<style type="text/css">
body {literal}{{/literal}background:#CFE2F6 url({$url_images}top.gif) repeat-x{literal}}{/literal}
{literal}
* {margin:0;padding:0;font-size:12px;font-family:Verdana;}
#header {margin-left:10px;float:left;display:block;}
#right {font-size:12px;color:#333;float:right;height:45px;line-height:45px;display:block;margin-right:20px}
a {text-decoration: none;font-size:12px;color:#0033CC;}
a:hover {text-decoration: none;color:#CC3300}
{/literal}
.logo {literal}{{/literal}
	background:url({$url_images}logo-min.png) center top no-repeat;height:45px;width:121px;
	_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{$url_images}logo-min.png");
	_background:none;
{literal}}{/literal}

</style>
</head>
<body onselectstart="return false">
<div id="header">
	<img src="{$url_images}spacer.gif" alt="" class="logo"/>
</div>
<div id="right">
	{$smarty.session.admin_info.name}({$smarty.session.admin_info.gname}), <a href="index.php?do=logout" target="_top">退出登录</a>
</div>
</body>
</html>