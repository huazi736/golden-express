<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>反馈管理</title>
<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
<script type="text/javascript" src="{$url_js}jquery-1.3.2.min.js"></script>
<style type="text/css">
{literal}
body {margin:0;padding:0;font-size:12px;font-family:Verdana;}
body {background:#F5FCFF}
.bottom{text-align:center;height:30px;line-height:30px;border-top:1px solid #b8d3e1;margin-top:20px;width:100%}
{/literal}
</style>
</head>
<body>


<br />
<form name="myform" action="?do=Add" method="post" onsubmit="return checkform()">
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="5" height="25" class="title">反馈管理</td>
  </tr>
  <tr>
    <td width="65%" class="line"><strong>标题</strong></td>
    <td width="15%" class="line"><strong>时间</strong></td>
    <td width="10%" class="line"><strong>类型</strong></td>
    <td width="10%" class="line"><strong>管理</strong></td>
  </tr>
  {foreach from=$gbook item=list}
  <tr>
    <td class="line">{$list.Title}</td>
    <td class="line">{$list.CreateTime}</td>
    <td class="line">{if $list.Type == 1}留言{elseif $list.Type == 2}建议{else}投诉{/if}</td>
    <td class="line"><a href="?do=view&gid={$list.GbookId}">查看</a> <a href="?do=del&gid={$list.GbookId}" onclick="{literal}if(confirm('确定要删除? 删除后无法恢复!')){return true}else{return false}{/literal}">删除</a></td>
  </tr>
  {/foreach}
  <tr>
    <td colspan="5"><div class="pages">{$pages}</div></td>
    </tr>
  
</table>
</form>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>