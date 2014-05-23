<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>{$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body">
			<div class="content">
				<div class="slide">
					<div class="slide_cont" id="slide_cont">
						{foreach from=$play item=list}
						<a href="{$list.link}" target="_blank"><img src="{$list.img}" title="{$list.title}" alt=""/></a>
						{/foreach}
					</div>
					<ul class="slide_index" id="slide_index">
						<li class="current"><a href="javascript://">1</a></li>
						<li><a href="javascript://">2</a></li>
						<li><a href="javascript://">3</a></li>
						<li><a href="javascript://">4</a></li>
					</ul>
				</div>
				<div class="intro">
					<div class="box intro_0">
						<div class="box_title">
							<span class="box_s_l"></span>
							<span class="box_s_c"></span>
							<h3>产品与服务</h3>
						</div>
						<div class="box_cont">
							<div class="shadow_pic">
								<p>
									<img src="{$url_images}pic01.gif"/>
								</p>
							</div>
							<p>
								金链接为客户提供快捷、安全、准时的全国快递服务，及在此基础上为客户提供更多增值服务，及在增值此基础上为客户增值服务
							</p>
							<p class="more_p">
								<a class="more_a" href="service.php"><span>查看详情</span></a>
							</p>
						</div>
					</div>
					<div class="box intro_1">
						<div class="box_title">
							
							<span class="box_s_r"></span>
							<h3>特许加盟</h3>
						</div>
						<div class="box_cont">
							<div class="shadow_pic">
								<p>
									<img src="{$url_images}pic02.gif"/>
								</p>
							</div>
							<p>
								金链接为客户提供快捷、安全、准时的全国快递服务，及在此基础上为客户提供更多增值服务，及在增值此基础上为客户增值服务
							</p>
							<p class="more_p">
								<a class="more_a" href="join.php"><span>查看加盟流程</span></a>
							</p>
						</div>
					</div>
				</div>
				<div class="news">
					<div class="box box_n1">
						<div class="box_title">
							<span class="box_s_l"></span>
							<span class="box_s_r"></span>
							<h3>新闻</h3>
							<a class="more" href="news.php">更多</a>
						</div>
						<div class="box_cont">
							<ul class="new_list">
								{foreach from=$news item=list}
								<li>
									<a href="news.php?nid={$list.NewsId}" target="_blank"><span style="color:{$list.Color}">{$list.Title|html}</span></a> <span>{$list.CreateTime|truncate:"10":""}</span>
								</li>
								{/foreach}
							</ul>
						</div>
					</div>
					<div class="box box_n2">
						<div class="box_title">
							<span class="box_s_l"></span>
							<span class="box_s_r"></span>
							<h3>网点查询</h3>
							<a class="more" href="join.php">更多</a>
						</div>
						<div class="box_cont">
							<ul class="map_ul">
								<li><img src="{$url_images}pic_icon_0.gif"/>总公司</li>
								<li><img src="{$url_images}pic_icon_1.gif"/>分公司</li>
								<li><img src="{$url_images}pic_icon_2.gif"/>店铺</li>
							</ul>
							<div class="map_cont">
								<img src="{$url_images}pic_map.gif" alt="" width="236" height="123" border="0" usemap="#Map" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="side">
				<div class="query">
					<h3>查询快件号</h3>
					<textarea id="express_id">2</textarea>
					<p class="sub">
						<input type="button" class="submit c2" value="查询" onclick="location='bill.php?bid=' + $('#express_id').val()"/>
						<a href="javascript://" onclick="$('#express_id').val('').focus()">清空</a>
					</p>
				</div>
				{if empty($smarty.session.ep_uid)}
				<div class="login">
					<h3>登录</h3>
					<input id="index_email" type="text" class="inp" value=""/>
					<input id="index_pwd" type="password" class="inp" value=""/>
					<p class="sub">
						<input type="button" class="submit c2" value="登录" onclick="ajaxLogin()"/>
						<a href="register.php">立即注册</a>
					</p>
				</div>
				{/if}
				<div class="links">
					<h3>友情链接</h3>
					<a href="https://www.alipay.com/" target="_blank">
						<img src="{$url_images}img_link_1.gif"/>
					</a>
					<a href="https://www.paypal.com/" target="_blank">
						<img src="{$url_images}img_link_2.gif"/>
					</a>
					<a href="http://www.alibaba.com/" target="_blank">
						<img src="{$url_images}img_link_3.gif"/>
					</a>
					<a href="http://www.taobao.com/" target="_blank">
						<img src="{$url_images}img_link_4.gif"/>
					</a>
					<a href="http://www.bankofamerica.com/" target="_blank">
						<img src="{$url_images}img_link_5.gif"/>
					</a>
				</div>
			</div>
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}	
<map name="Map" id="Map">
  <area shape="circle" coords="63,56,9" href="javascript://" title="分公司" />
  <area shape="circle" coords="95,54,8" href="javascript://" title="总公司"  />
  <area shape="circle" coords="172,54,9" href="javascript://" title="分公司" />
  <area shape="circle" coords="79,65,7" href="javascript://" title="店铺" />
  <area shape="circle" coords="189,52,7" href="javascript://" title="店铺" />
</map>	
	<script type="text/javascript">
	{literal}

	function ajaxLogin() {
		var email = $.trim($("#index_email").val()),
			pwd = $.trim($("#index_pwd").val());
		if (email.length == 0 || pwd.length == 0) {
			alert("请填写Email和密码");
			return false;
		}
		if (!/^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*(\.[a-zA-Z0-9]+[-a-zA-Z0-9]*)+[a-zA-Z0-9]+$/.test(email))
		{
			alert('请填写正确的Email');
			return false;
		}
		$.post('login.php?do=login', {'email': email, 'pwd': pwd}, function(json) {
			if (json.status) {
				location = 'user.php';
			} else {
				alert(json.msg);
			}
		}, 'json');
		return false;
	}


	
	$(document).ready(function() {
		var t = n = 0, count;
		function showAuto()
		{
			n = n >=(count - 1) ? 0 : ++n;
			$("#slide_index li").eq(n).trigger('click');
		}
		count = $("#slide_cont a").length;
		$("#slide_cont a:not(:first-child)").hide();
		$("#slide_index li").click(function() {
			var i=$("#slide_index li").index($(this));
			n = i;
			if (i >= count) return;
			$("#slide_cont a").filter(":visible").css("z-index",0).fadeOut(500).parent().children().eq(i).css("z-index",1).fadeIn(1000);
			$(this).addClass("current").siblings().removeClass("current");
		});
		t = setInterval(showAuto, 4000);
		$("#slide_cont").hover(function(){clearInterval(t)}, function(){t = setInterval(showAuto, 4000);});
	});	
	
	{/literal}
	</script>
	</body>
</html>
