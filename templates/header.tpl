<div class="header">
	<h1 class="logo">
		<a href="index.php"><img src="{$url_images}logo.gif"/></a>
	</h1>
	{if empty($smarty.session.ep_uid)}
	<div class="login_info">
		<span>您好，欢迎来到金链接快递</span>
		<a href="login.php">登录</a>
		<a href="register.php">注册</a>
		<a href="help.php">帮助</a>
	</div>
	{else}
	<div class="login_info">
		<span>{$smarty.session.ep_name} 您好，欢迎来到金链接快递</span>
        <a href="user.php" style="color:#F63">个人中心</a>
		<a href="login.php?do=logout">退出登录</a>
		<a href="help.php">帮助</a>
	</div>
	{/if}
	<div class="nav">
		<span class="nav_l"></span>
		<span class="nav_r"></span>
		<ul>
			<li {if $current == 'index'}class="current"{/if}><a href="index.php">首页</a></li>
			<li {if $current == 'service'}class="current"{/if}><a href="service.php">服务项目</a></li>
			<li {if $current == 'guide'}class="current"{/if}><a href="guide.php">服务指南</a></li>
			<li {if $current == 'price'}class="current"{/if}><a href="price.php">价格查询</a></li>
			<li {if $current == 'gbook'}class="current"{/if}><a href="gbook.php">客户留言</a></li>
			<li {if $current == 'join'}class="current"{/if}><a href="join.php">网点加盟</a></li>
			<li {if $current == 'contact'}class="current"{/if}><a href="contact.php">联系我们</a></li>
		</ul>
	</div>
	<div class="c"></div>
</div>