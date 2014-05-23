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
				<h2 class="title-common">个人信息</h2>
				<div class="uc_main clearfix">
                    <ul class="list_info" >
                        <li><label>用户姓名：</label><input name="RealName" type="text" class="input-normal w-280" value="{$user.RealName|html}"/></li>
                        <li><label>联系电话：</label><input name="Phone" type="text" class="input-normal w-280" value="{$user.Phone|html}"/></li>
						<li><label>联系地址：</label><input name="Adress" type="text" class="input-normal w-280" value="{$user.Adress|html}"/></li>
						<li><label>联系QQ：</label><input name="Qq" type="text" class="input-normal w-280" value="{$user.Qq|html}"/></li>
                    </ul>
					<div class="more_p" style="padding-left: 105px;">
					   <a class="btn_gray fl" href="javascript://" onclick="edit_user()"><span>修改信息</span></a>
					</div>
				</div>
				
			</div>
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
		<script type="text/javascript">
		{literal}
			var list = {
				'RealName' : '姓名',
				'Phone' : '联系电话',
				'Adress' : '联系地址',
				'Qq' : '联系QQ',
			};
			function edit_user()
			{
				var tmp = list;
				var flag = true;
				$(".list_info input").each(function() {
					var ipt = $(this);
					var val = $.trim(ipt.val());
					if (val == '') {
						alert("请填写: " + tmp[ipt.attr('name')]);
						flag = false;
						return false;
					} else {
						tmp[ipt.attr('name')] = val;
					}
				});
				if (flag) {
					$.post('user.php?do=updateInfo', tmp, function() {
						alert("用户信息修改成功!");
						location.reload();
					});
				}
			}
		{/literal}
		</script>	
	</body>
</html>
