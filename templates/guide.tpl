<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>{$data.Name} - 服务指南 - {$cfg.site.title}</title>
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
							<h3>服务指南</h3>
						</div>
						<div class="box_cont">
							<ul class="items">
								<li><a href="?do=Process" {if $sid == 4}style="color:#FF6600"{/if}>操作流程</a></li>
								<li><a href="?do=Notice" {if $sid == 5}style="color:#FF6600"{/if}>寄货须知</a></li>
								<li><a href="?do=Claimant" {if $sid == 6}style="color:#FF6600"{/if}>索赔挂失</a></li>
							</ul>
						</div>
					</div>
				
			</div>
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}			
	</body>
</html>
