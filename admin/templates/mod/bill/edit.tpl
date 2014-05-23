<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理运单</title>
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
    <td colspan="2" height="25" class="title">管理运单</td>
  </tr>
  <tr>
    <td width="12%" class="line">订单状态</td>
    <td width="88%" class="line">   
    <select name="Status" id="Status">
    	{foreach from=$bill_cfg item=list key=key}
    	<option value="{$key}" {if $bill.Status == $key}selected="selected"{/if}>{$list}</option>
        {/foreach}
    </select>
    <input type="hidden" name="BillId" value="{$bill.BillId}" />
    <input type="hidden" name="GoodsId" value="{$goods.GoodsId}" />
    </td>
  </tr>
  <tr>
    <td class="line">定价</td>
    <td class="line"><input name="Price" type="text" class="txt" id="Price" value="{$bill.Price|html}" style="width:70px" /></td>
  </tr>
  <tr>
    <td class="line">快递单号</td>
    <td class="line"><input name="BillKey" type="text" class="txt w400" id="BillKey" value="{$bill.BillKey|html}" /></td>
  </tr>
  <tr>
    <td colspan="2" class="line">
      <br />
      <table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
        <tr>
          <td height="25" colspan="2" class="title">寄件人</td>
          </tr>
        <tr>
          <td width="10%" class="line">寄件人</td>
          <td width="90%" class="line"><input name="FromName" type="text" class="txt w200" id="FromName" value="{$bill.FromName|html}" /></td>
          </tr>
        <tr>
          <td class="line">电话</td>
          <td class="line"><input name="FromPhone" type="text" class="txt w200" id="FromPhone" value="{$bill.FromPhone|html}" /></td>
          </tr>
        <tr>
          <td class="line">公司名称</td>
          <td class="line"><input name="FromCompany" type="text" class="txt w200" id="FromCompany" value="{$bill.FromCompany|html}" /></td>
          </tr>
        <tr>
          <td class="line">详细地址</td>
          <td class="line"><input name="FromAddr" type="text" class="txt w200" id="FromAddr" value="{$bill.FromAddr|html}" /></td>
          </tr>
        <tr>
          <td class="line">城市</td>
          <td class="line"><input name="FromCity" type="text" class="txt w200" id="FromCity" value="{$bill.FromCity|html}" /></td>
          </tr>
        <tr>
          <td class="line">州或省份</td>
          <td class="line"><input name="FromProvince" type="text" class="txt w200" id="FromProvince" value="{$bill.FromProvince|html}" /></td>
          </tr>
        <tr>
          <td class="line">邮编区号</td>
          <td class="line"><input name="FromPost" type="text" class="txt w200" id="FromPost" value="{$bill.FromPost|html}" /></td>
          </tr>
        <tr>
          <td class="line">国家</td>
          <td class="line"><input name="FromCountry" type="text" class="txt w200" id="FromCountry" value="{$bill.FromCountry|html}" /></td>
        </tr>
        <tr>
          <td>寄件人签字</td>
          <td><input name="SendSign" type="text" class="txt w200" id="SendSign" value="{$bill.SendSign|html}" /></td>
          </tr>
        
        </table>
      <br />
      <table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
        <tr>
          <td height="25" colspan="2" class="title">收件人</td>
          </tr>
        <tr>
          <td width="10%" class="line">收件人</td>
          <td width="90%" class="line"><input name="ToName" type="text" class="txt w200" id="ToName" value="{$bill.ToName|html}" /></td>
          </tr>
        <tr>
          <td class="line">电话</td>
          <td class="line"><input name="ToPhone" type="text" class="txt w200" id="ToPhone" value="{$bill.ToPhone|html}" /></td>
          </tr>
        <tr>
          <td class="line">公司名称</td>
          <td class="line"><input name="ToCompany" type="text" class="txt w200" id="ToCompany" value="{$bill.ToCompany|html}" /></td>
          </tr>
        <tr>
          <td class="line">详细地址</td>
          <td class="line"><input name="ToAddr" type="text" class="txt w200" id="ToAddr" value="{$bill.ToAddr|html}" /></td>
          </tr>
        <tr>
          <td class="line">城市</td>
          <td class="line"><input name="ToCity" type="text" class="txt w200" id="ToCity" value="{$bill.ToCity|html}" /></td>
          </tr>
        <tr>
          <td class="line">州或省份</td>
          <td class="line"><input name="ToProvince" type="text" class="txt w200" id="ToProvince" value="{$bill.ToProvince|html}" /></td>
          </tr>
        <tr>
          <td class="line">邮编区号</td>
          <td class="line"><input name="ToPost" type="text" class="txt w200" id="ToPost" value="{$bill.ToPost|html}" /></td>
          </tr>
        <tr>
          <td>国家</td>
          <td><input name="ToCountry" type="text" class="txt w200" id="ToCountry" value="{$bill.ToCountry|html}" /></td>
          </tr>
        </table>
      <br />
      <table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
        <tr>
          <td height="25" colspan="2" class="title">运单详情</td>
          </tr>
        <tr>
          <td width="10%" class="line">起运地</td>
          <td width="90%" class="line"><input name="FromPos" type="text" class="txt w200" id="FromPos" value="{$bill.FromPos|html}" /></td>
          </tr>
        <tr>
          <td class="line">目的地</td>
          <td class="line"><input name="ToPos" type="text" class="txt w200" id="ToPos" value="{$bill.ToPos|html}" /></td>
          </tr>
        <tr>
          <td colspan="2">
          {foreach from=$goods.Goods item=good key=pos}
          <table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
            <tr>
              <td height="25" colspan="2" class="title">货物箱子 ({$good.pos})</td>
            </tr>
            <tr>
              <td width="10%" class="line">重量</td>
              <td width="90%" class="line">              	
              	  <input name="weight{$good.pos}" type="text" class="txt" value="{$good.weight|html}" />
              	  <label><input type="radio" value="kg" name="unit{$good.pos}" {if $good.unit == 'kg'}checked=checked{/if}>Kg</label>
				  <label><input type="radio" value="lb" name="unit{$good.pos}" {if $good.unit == 'lb'}checked=checked{/if}>Lb</label>
              </td>
            </tr>
            <tr>
              <td class="line">体积重量</td>
              <td class="line"><input name="bulk{$good.pos}" type="text" class="txt" value="{$good.bulk|html}" />（L*W*H）为0表示重量/体积未知</td>
            </tr>
            {foreach from=$good.item item=items name=gitem}
            <tr>
              <td colspan="2" {if !$smarty.foreach.gitem.last}class="line"{/if}>
              	序号:
                <input name="key{$good.pos}[]" type="text" class="txt" value="{$items.key|html}" /> 
                描述:
                <input name="info{$good.pos}[]" type="text" class="txt" value="{$items.info|html}" /> 
                价值:
                <input name="money{$good.pos}[]" type="text" class="txt" value="{$items.money|html}" />
              </td>
            </tr>
            {/foreach}
          </table>
          {/foreach}
          </td>
          </tr>
      </table>
      <br /></td>
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