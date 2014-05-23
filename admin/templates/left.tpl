<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>left</title>
<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
<script type="text/javascript" src="{$url_js}jquery-1.3.2.min.js"></script> 
<style type="text/css">
{literal}
body {margin:0;padding:0;font-size:12px;font-family:Verdana;background:#FFFFFF;}
#top {background:#F5FCFF;margin:0 auto 5px auto; width:100%;height:22px;text-align:center;padding-top:10px;border-bottom:1px solid #B8D3E1}
dl {padding:0 10px;margin:0 auto;}
dl dt {border-bottom:3px solid #91C900;color:#376585;height:30px;line-height:30px;padding-left:10px;font-weight:bold;cursor:pointer;margin-bottom:2px}
dl dd {line-height:24px;margin-left:20px;}
dd a:hover{color:#333;}
{/literal}
dl dd.on {literal}{{/literal}background:url({$url_images}left-hover.gif) no-repeat{literal}}{/literal}
dl dd.on1 {literal}{{/literal}background:url({$url_images}left-hover.gif) no-repeat{literal}}{/literal}
dd a {literal}{{/literal}background:url({$url_images}a.gif) 5px center no-repeat;color:#333;padding-left:25px;display:block;outline:0{literal}}{/literal}
</style>
</head>

<body onselectstart="return false">

<div id="top">
	<a href="main.php" target="main">首页</a>
	<a href="mod/adminuser/password.php" target="main">修改密码</a>
	<a href="index.php?do=logout" target="_top">退出登录</a>
</div>

{foreach from=$cfg.menu item=menu key=mainmenu}
<dl>
	{assign var="_mainmenu" value="$mainmenu-0"}
	{if $smarty.session.admin_info.gid == 0 || in_array($_mainmenu, $smarty.session.admin_info.group)}
		<dt>{$menu.name} <span>{if $menu.expand}-{else}+{/if}</span></dt>		
		{foreach from=$menu.menus item=menus key=submenu}
			{assign var="_submenu" value="$mainmenu-$submenu"}
			{if $smarty.session.admin_info.gid == 0 || in_array($_submenu, $smarty.session.admin_info.group)}
				<dd {if !$menu.expand}style="display:none"{/if}><a href="{$menus.url}" target="main" hidefocus="true">{$menus.name}</a></dd>
			{/if}
		{/foreach}		
	{/if}
</dl>
{/foreach}

<script type="text/javascript">
{literal}
$(function () {
	$("dl dt").toggle(function() {
		$(this).find('span').text('+')
		$(this).nextAll().slideUp('fast');
	}, function() {
		$(this).find('span').text('-')
		$(this).nextAll().slideDown('fast');
	});
	$("dd").click(function() {
		$("dd").removeClass('on');
		$(this).addClass('on');
	});
	$("dd").hover(function() {
		$(this).addClass('on1');
	}, function() {
		$(this).removeClass('on1');		
	});
	$("#top a").click(function(){
		$("dd").removeClass('on');
	})
});
// hide plugins when it's empty
window.onload = function () {
	var plugin_size = $("dl:last").find('dd').size();
	if (plugin_size == 0) {
		$("dl:last").hide();
	}
}
{/literal}
</script>
</body>
</html>