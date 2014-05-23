<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运单管理</title>
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
    <td colspan="9" height="25" class="title">运单管理</td>
  </tr>
  <tr>
	<td><b>运单编号</b></td>
	<td><b>创建日期</b></td>
	<td><b>收货城市</b></td>
	<td><b>收货人</b></td>
	<td><b>状态</b></td>
	<td><b>快递单号</b></td>
	<td><b>定价</b></td>
	<td><b>管理</b></td>
  </tr>
  {foreach from=$bills item=list}
	<tr>
		<td class="line">{$list.BillId}</td>
		<td class="line">{$list.CreateTime}</td>
		<td class="line">{$list.ToCity}</td>
		<td class="line">{$list.ToName}</td>
		<td class="line">{$bill_cfg[$list.Status]}</td>
		<td class="line">{if empty($list.BillKey)}未指定{else}{$list.BillKey}{/if}</td>
		<td class="line">{if empty($list.Price)}未定价{else}{$list.Price}{/if}</td>
		<td class="line">
			<a href="/bill.php?bid={$list.BillId}" target="_blank">查看订单</a> 
			<a href="?do=edit&bid={$list.BillId}">管理订单</a> 
			<a href="?do=cancel&bid={$list.BillId}" onclick="{literal}if(confirm('确定要取消?')){return true}else{return false}{/literal}">取消订单</a>
		</td>
	</tr>
	{/foreach}
  <tr>
    <td colspan="9"><div class="pages">{$pages}</div></td>
    </tr>
  
</table>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>