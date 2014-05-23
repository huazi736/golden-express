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
				<h2 class="title-common">个人中心</h2>
				<div class="uc_main">
					<div class="notice">
                    	{if $services.UserId > 0}
						友情提示：您的客服专员是<em>{$services.Name}</em><b>联系方式：</b><span>{$services.Phone}</span>
						{else}
						友情提示：您还未指定客服专员
						{/if}
						
					</div>
                    <h3>会员信息</h3>
                    <ul class="list_info">
                        <li><label>用户姓名：</label>{$user.RealName}</li>
                        <li><label>用户编号：</label>lax_{$user.UserId}</li>
                        <li><label>会员级别：</label>{if $user.Vip == 1}<span style="color:red">Vip会员</span>{else}普通会员{/if}</li>
                        <li><label>用户邮箱：</label>{$user.Email}</li>
                        <li><label>注册时间：</label>{$user.CreateTime}</li>
						<li><label>联系地址：</label>{if empty($user.Adress)}未填写{else}{$user.Adress}{/if}</li>
						<li><label>用户qq：</label>{if empty($user.Qq)}未填写{else}{$user.Qq}{/if}</li>
                    </ul>
				</div>
			</div>
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
	
	</body>
</html>
