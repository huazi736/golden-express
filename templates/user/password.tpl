<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>客户个人中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2 class="title-common">修改密码</h2>
				<form name="mypass" action="user.php?do=changePwd" method="post">
				<div class="uc_main clearfix">
                    <ul class="list_info">
                        <li><label>原密码：</label><input name="oldpwd" type="password" class="input-normal w-280" value=""/></li>
                        <li><label>新密码：</label><input name="pwd1" type="password" class="input-normal w-280" value=""/></li>
                        <li><label>确认新密码：</label><input name="pwd2" type="password" class="input-normal w-280" value=""/></li>
                    </ul>
					<div class="more_p" style="padding-left: 105px;">						
					   <a class="btn_gray fl" href="javascript://" onclick="document.mypass.submit()"><span>提 交</span></a>
					   {if $errormsg}<span style="color:red;margin-left:10px">{$errormsg}</span>{/if}
					</div>
					
				</div>
				
				</form>
				
			</div>
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
	
	</body>
</html>
