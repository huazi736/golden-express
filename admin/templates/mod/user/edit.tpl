<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>客户编辑</title>
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
<form name="myform" action="?do=Save" method="post" >
  <table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
    <tr>
    <td colspan="2" height="25" class="title">修改客户信息</td>
  </tr>
  <tr>
    <td class="line">登录名称</td>
    <td class="line"><input type="text" name="Name" class="txt input200" value="{$user.Name}" readonly="readonly"/></td>
  </tr>
  <tr>
    <td width="12%" class="line">姓</td>
    <td width="88%" class="line"><input type="text" name="RealName" class="txt input200" value="{$user.RealName}" /><input type="hidden" name="UserId" class="txt input200" value="{$user.UserId}" /> 
    <label><input name="Vip" type="checkbox" id="Vip" value="1" {if $user.Vip == 1}checked="checked"{/if}/> 
      <span class="red">Vip</span></label></td>
  </tr>
  <tr>
    <td width="12%" class="line">密码</td>
    <td width="88%" class="line"><input type="password" name="Pass" class="txt input200"  />  若不修改密码, 留空即是.</td>
  </tr>
  <tr>
    <td class="line">联系电话</td>
    <td class="line"><input type="text" name="Phone" class="txt input200"  value="{$user.Phone}" /></td>
  </tr>
  <tr>
    <td class="line">Email</td>
    <td class="line"><input type="text" name="Email" class="txt input200" value="{$user.Email}" /></td>
  </tr>
  <tr>
    <td class="line">对应客服</td>
    <td class="line">
    	<select name="ServiceId" >
        <option value="0">未指定</option>
		{foreach from=$services item=group}      
         <option value="{$group.UserId}" {if $user.ServiceId == $group.UserId}selected="selected"{/if}>{$group.Name}</option>
		{/foreach}
   		</select></td>
  </tr>
  <tr>
    <td class="line">客户定价</td>
    <td class="line"><input type="text" name="Price" class="txt input200"  value="{$user.Price}" {if !empty($user.Price)}readonly="readonly"{/if}/> 无价格客服可以定价，有价格则不能操作  </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="button"  value="保存修改" class="btn" />
      <input type="button"  value="取消修改" class="btn" onclick="history.back()" /></td>
  </tr>
  
</table>
</form>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>