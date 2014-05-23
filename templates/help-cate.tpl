<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>帮助中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">				
				<h2 class="title_big">{$title}</h2>
				<div class="new_list_cont">
					{$data.Content}
				</div>
			</div>
			<div class="side">
					<div class="box">
						<div class="box_title">
							<span class="box_s_l"></span>
							<span class="box_s_r"></span>
							<h3>帮助中心</h3>
						</div>
						<div class="box_cont help_cont">
							{foreach from=$cate item=list}
							<h3>{$list.name}</h3>
							<ul class="items">
								{foreach from=$list.item item=val}
								<li><a href="help.php?do=View&id={$val.id}">{$val.name}</a></li>
								{/foreach}
							</ul>
							{/foreach}
						</div>
					</div>
				
			</div>
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}			
	</body>
</html>
