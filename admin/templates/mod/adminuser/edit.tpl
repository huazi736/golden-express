<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理人员编辑</title>
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
<form name="myform" action="?do=Save" method="post" onsubmit="return checkform()">
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="2" height="25" class="title">编辑帐号</td>
  </tr>
  <tr>
    <td class="line">帐号组别</td>
    <td class="line">
	<select name="GroupId" >
		{foreach from=$groups item=group}
		<option value="{$group.GroupId}" {if $user.GroupId == $group.GroupId}selected="selected"{/if}>{$group.Name}</option>
		{/foreach}
    </select>
	</td>
  </tr>
  <tr>
    <td width="8%" class="line">帐号名称<span class="red"></span></td>
    <td width="92%" class="line"><input type="text" name="Name" class="txt input200" value="{$user.Name}" /><input type="hidden" name="UserId" class="txt input200" value="{$user.UserId}" /></td>
  </tr>
  <tr>
    <td width="8%" class="line">密码</td>
    <td width="92%" class="line"><input type="password" name="Pass" class="txt input200"  /> 若不修改密码, 留空即是.</td>
  </tr>
  <tr>
    <td width="8%" class="line">Email</td>
    <td width="92%" class="line"><input type="text" name="Email" class="txt input200" value="{$user.Email}" /></td>
  </tr>
  <tr>
    <td class="line">联系电话</td>
    <td class="line"><input type="text" name="Phone" class="txt input200"  value="{$user.Phone}" /></td>
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
<script type="text/javascript">
{literal}
function checkform()
{
	if ($("input[name='Name']").val() == '') {
		alert('请填写用户名!');
		return false;
	}
	if ($("input[name='Pass']").val() == '') {
		alert('请填写密码!');
		return false;
	}
	return true;
}
{/literal}
</script>
</body>
</html>