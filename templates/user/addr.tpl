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
				<h2 class="title-common">收货地址管理</h2>
				<div class="uc_main clearfix">
                	<div class="uc_title"><h3>新增收获地址</h3>电话号码、手机号选填一项，其余为必填</div>
                    <ul class="list_info">
                        <li><label>收货人：</label><input name="ReceiveName" type="text" class="input-normal w-280" value=""/></li>
                        <li><label>收货地址：</label><input name="ReceiveAddr" type="text" class="input-normal w-280" value=""/></li>
                        <li><label>联系电话：</label><input name="Phone" type="text" class="input-normal w-280" value=""/></li>
                        <li><label>邮政编码：</label><input name="Post" type="text" class="input-normal w-280" value=""/></li>
                    </ul>
					<div class="more_p clearfix" style="padding: 0 0 30px 105px;">
					   <a class="btn_gray fl" href="javascript://" onclick="add_new()"><span>新 增</span></a>
					</div>
                    
                    <div class="uc_title"><h3>已保存的收货地址</h3></div>
                    <div class="table">
                        <table class="table_s1">
                            <colgroup>
                                <col width="100">
                                <col width="120">
                                <col width="">
                                <col width="100">
                                <col width="100">
                            </colgroup>
                            <tr>
                                <th>收货人</th>
                                <th>联系电话</th>
                                <th>收货地址</th>
                                <th>邮政编码</th>
                                <th>操作</th>
                            </tr>
							{foreach from=$addrs item=list}
                            <tr>
                                <td>{$list.ReceiveName|html}</td>
                                <td>{$list.Phone|html}</td>
                                <td><div>{$list.ReceiveAddr|html}</div></td>
                                <td>{$list.Post|html}</td>
                                <td><a class="ml10" href="user.php?do=delAddr&aid={$list.AddressId}" onclick="{literal}if(confirm('确定要删除? 删除后无法恢复!')){return true}else{return false}{/literal}">删除</a></td>
                            </tr>
							{/foreach}
                          </table>
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
				'ReceiveName' : '收货人',
				'ReceiveAddr' : '收货地址',
				'Phone' : '联系电话',
				'Post' : '邮政编码'
			};
			function add_new()
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
					$.post('user.php?do=addAddr', tmp, function() {
						alert("新增收获地址成功!");
						location.reload();
					});
				}
			}
		{/literal}
		</script>
	
	</body>
</html>
