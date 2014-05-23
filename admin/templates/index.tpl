<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$site_title} 登陆</title>
<link rel="stylesheet" type="text/css" href="{$url_css}login.css" />
<style type="text/css">
#logo {literal}{{/literal}
	background:url({$url_images}logo.png) center top no-repeat;height:64px;width:210px;
	_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{$url_images}logo.png");
	_background:none;
{literal}}{/literal}
</style>
</head>
<body>
<div id="main">
    <div id="wrap">
         <div class="logo">
              <div id="logo"></div>

         </div>
    </div>
    <div id="wrapb"></div>
    <div id="wrapc">
         <div class="login">
              <form action="?do=Check" method="post" name="login">
                   <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
							<th>管理员账号</th>
							<td>
								<div class="logo-icon">
									<div class="pw"></div>
									<input class="input pw2" name="username" type="text" />
								</div>
							</td>
						</tr>

                        <tr><th>密码</th><td><div class="logo-icon"><div class="pwpd"></div><input class="input pwpd2" type="password" name="password" /></div></td></tr>


                        <tr><th></th><td><input name="submit" type="image" src="{$url_images}login.gif" style="margin-left:1.5em;margin-top:.5em;width:80px;height:30px;" /></td></tr>

						{if $notlogin == true}<tr><th></th><td><span style="color:red">账号或密码错误!</span></td></tr>{/if}
                   </table>
              </form>
         </div>
    </div>
</div>
<div class="bottom">{$cfg.footer}</div>
<script type="text/javascript">
{literal}
window.onload = function() {
	document.login.username.focus();
}
{/literal}
</script>
</body>
</html>