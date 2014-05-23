<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
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
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="6" height="25" class="title">用户管理</td>
  </tr>
  <tr>
    <td width="9%" class="line"><strong>用户ID</strong></td>
    <td width="15%" class="line"><strong>用户名称</strong></td>
    <td width="24%" class="line"><strong>用户类型</strong></td>
    <td width="12%" class="line"><strong>Email</strong></td>
    <td width="12%" class="line"><strong>联系电话</strong></td>
    <td width="28%" class="line"><strong>管理</strong></td>
  </tr>
  {foreach from=$users item=list}
  <tr>
    <td class="line">{$list.UserId}</td>
    <td class="line">{$list.Name}</td>
    <td class="line">{if $list.GroupId == 0}创始人{else}{$group_table[$list.GroupId]}{/if}</td>
    <td class="line">{$list.Email}</td>
    <td class="line">{$list.Phone}</td>
    <td class="line"><a href="?do=edit&uid={$list.UserId}">编辑</a> <a href="?do=del&uid={$list.UserId}" onclick="{literal}if(confirm('确定要删除用户? 删除后无法恢复!')){return true}else{return false}{/literal}">删除</a></td>
  </tr>
  {/foreach}
  <tr>
    <td colspan="6"><div class="pages">{$pages}</div></td>
    </tr>
  
</table>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>