<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>货运管理</title>
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
    <td colspan="9" height="25" class="title">货运管理</td>
  </tr>
  <tr>
	<td><b>货运ID</b></td>
	<td><b>到货仓库</b></td>
	<td><b>美国快递单号</b></td>
	<td><b>快递公司名称</b></td>
	<td><b>创建时间</b></td>
	<td><b>状态</b></td>
	<td><b>管理</b></td>
  </tr>
  {foreach from=$transports item=list}
	<tr>
		<td class="line">{$list.TransportId}</td>
		<td class="line">{$warehouse_cfg[$list.WarehouseId]}</td>
		<td class="line">{$list.BillKey}</td>
		<td class="line">{$list.BillName}</td>
		<td class="line">{$list.CreateTime}</td>
		<td class="line">{if $list.Status == 0}入库{elseif $list.Status == 1}出库{elseif $list.Status == 2}已提交{/if}</td>
		<td class="line">			
			<a href="?do=edit&tid={$list.TransportId}">管理货运</a> 
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