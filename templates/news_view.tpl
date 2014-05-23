<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>新闻中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2 class="title_big">{$news.Title}</h2>
				<div class="new_list_cont">
					{$news.Content}
				</div>				
			</div>
			{include file="left_contact.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}		
	</body>
</html>
