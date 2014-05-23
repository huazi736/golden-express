<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理货运</title>
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
<form name="myform" action="?do=Save" method="post">
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="2" height="25" class="title">管理货运</td>
  </tr>
  <tr>
    <td width="12%" class="line">订单状态</td>
    <td width="88%" class="line">   
    <select name="Status" id="Status">
    	<option value="0" {if $bill.Status == 0}selected="selected"{/if}>入库</option>
        <option value="1" {if $bill.Status == 1}selected="selected"{/if}>出库</option>
        <option value="2" {if $bill.Status == 2}selected="selected"{/if}>已提交</option>
    </select>
    <input type="hidden" name="TransportId" value="{$bill.TransportId}" />
    <input type="hidden" name="GoodsId" value="{$goods.GoodsId}" />
    </td>
  </tr>
  <tr>
    <td class="line">到货仓库选择</td>
    <td class="line">
     <select name="WarehouseId" id="WarehouseId">      
    	{foreach from=$warehouse_cfg item=list key=key}    	
      	<option value="{$key}" {if $bill.WarehouseId == $key}selected="selected"{/if}>{$list}</option>
        {/foreach}    
   	 </select>
    </td>
  </tr>
  <tr>
    <td class="line">美国快递单号</td>
    <td class="line"><input name="BillKey" type="text" class="txt w400" id="BillKey" value="{$bill.BillKey|html}" /></td>
  </tr>
  <tr>
    <td class="line">快递公司名称</td>
    <td class="line"><input name="BillName" type="text" class="txt w400" id="BillName" value="{$bill.BillName|html}" /></td>
  </tr>
  <tr>
    <td class="line"><span class="title">货物详情</span></td>
    <td> {foreach from=$goods.Goods item=good key=pos}
      <table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
        <tr>
          <td height="25" colspan="2" class="title">货物箱子 ({$good.pos})</td>
          </tr>
        <tr>
          <td width="10%" class="line">重量</td>
          <td width="90%" class="line"><input name="weight{$good.pos}" type="text" class="txt" value="{$good.weight|html}" />
            <label>
              <input type="radio" value="kg" name="unit{$good.pos}" {if $good.unit == 'kg'}checked=checked{/if} />
              Kg</label>
            <label>
              <input type="radio" value="lb" name="unit{$good.pos}" {if $good.unit == 'lb'}checked=checked{/if} />
              Lb</label></td>
          </tr>
        <tr>
          <td class="line">体积重量</td>
          <td class="line"><input name="bulk{$good.pos}" type="text" class="txt" value="{$good.bulk|html}" />
            （L*W*H）为0表示重量/体积未知</td>
          </tr>
        {foreach from=$good.item item=items name=gitem}
        <tr>
          <td colspan="2" {if !$smarty.foreach.gitem.last}class="line"{/if}> 序号:
            <input name="key{$good.pos}[]" type="text" class="txt" value="{$items.key|html}" />
            描述:
            <input name="info{$good.pos}[]" type="text" class="txt" value="{$items.info|html}" />
            价值:
            <input name="money{$good.pos}[]" type="text" class="txt" value="{$items.money|html}" /></td>
          </tr>
        {/foreach}
        </table>
      <br />
      {/foreach} </td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="submit" name="button" id="button" value="保存修改" class="btn" />
      <input type="button" name="button2" id="button2" value="还原修改" class="btn" onclick="location.reload()" />
      <input type="button" name="button3" id="button3" value="取消修改" class="btn" onclick="history.back()"/></td>
  </tr>
  
</table>
</form>
<br />
<div class="bottom">{$cfg.footer}</div>
</body>
</html>