<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户登录 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content" >
				<h2 class="title-common"></h2>
				<div class="list-form" style=" padding: 30px 0 0 80px;">
					<ul>
                    	<li><label>邮件地址：</label><input name="Email" type="text" class="input-normal w-280" value=""/></li>
                        <li><label>密码：</label><input name="Password" type="password" class="input-normal w-280" value=""/></li>                      
                    </ul>					
					<p class="more_p" style="padding-left: 65px;">
					   <a class="btn_gray fl" href="javascript://" onclick="login()" ><span>登 录</span></a>
					</p>
				</div>
				
				
			</div>
			{include file="left_contact.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
		<script type="text/javascript">
		{literal}
		$("div.list-form input").eq(1).keydown(function(e) {
			if (e.keyCode == 13)
			{
				login();
			}
			return true;
		});		
		function login()
		{
			if ($("input[name='Email']").val() == '' || $("input[name='Password']").val() == '') {
				alert("请填写Email和密码");
				return false;
			}
			if (!/^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*(\.[a-zA-Z0-9]+[-a-zA-Z0-9]*)+[a-zA-Z0-9]+$/.test($("input[name='Email']").val()))
			{
				alert('请填写正确的Email');
				return false;
			}
			$.post('?do=login', {'email': $("input[name='Email']").val(), 'pwd': $("input[name='Password']").val()}, function(json) {
				if (json.status) {
					location = 'user.php';
				} else {
					alert(json.msg);
				}
			}, 'json');
			return false;
		}
		{/literal}
		</script>
	</body>
</html>
