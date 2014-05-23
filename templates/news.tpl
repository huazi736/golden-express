<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>新闻中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
		<style type="text/css">
		{literal}
		.pages {text-align:left;line-height:24px;color:#999;width:auto;float:right;margin-right:20px;margin-top:20px}
		.pages a{text-decoration:none;color:#439FD3;border:1px solid #E6F2FB;background-color:#F3F9FD;text-align:center;display:block;padding:0 8px;width:auto;float:left;margin-right:2px;}
		.pages a:hover{text-decoration:none;color:#439FD3;background-color:#D9ECF7;border:1px solid #439FD3;}
		.pages strong {text-decoration:none;color:#000;border:1px solid #E6F2FB;background-color:#F3F9FD;text-align:center;display:block;padding:0 8px;width:auto;float:left;margin-right:2px;}
		{/literal}
		</style>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2>公司新闻</h2>
				<div class="new_list_item">
					<ul class="new_list">
						{foreach from=$news item=list}
						<li>
							<a href="news.php?nid={$list.NewsId}" target="_blank"><span style="color:{$list.Color}">{$list.Title|html}</span></a> <span>{$list.CreateTime|truncate:"10":""}</span>
						</li>
						{/foreach}
					</ul>
				</div>
				<div class="pages">{$pages}</div>
				
			</div>
			{include file="left_contact.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}		
	</body>
</html>
