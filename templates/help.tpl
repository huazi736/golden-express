<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>{$data.Name} - 关于我们 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				{$data.Content}
			</div>
			<div class="side">
					<div class="box">
						<div class="box_title">
							<span class="box_s_l"></span>
							<span class="box_s_r"></span>
							<h3>关于我们</h3>
						</div>
						<div class="box_cont">
							<ul class="items">
								<li><a href="?do=About" {if $sid == 10}style="color:#FF6600"{/if}>关于我们</a></li>
								<li><a href="?do=Career" {if $sid == 12}style="color:#FF6600"{/if}>职业发展</a></li>
								<li><a href="?do=Pay" {if $sid == 13}style="color:#FF6600"{/if}>在线支付</a></li>
								<li><a href="?do=Professional" {if $sid == 14}style="color:#FF6600"{/if}>专业知识</a></li>
							</ul>
						</div>
					</div>
				
			</div>
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}			
	</body>
</html>
