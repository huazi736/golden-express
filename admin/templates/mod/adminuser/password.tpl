<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码</title>
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
<form name="myform" action="?do=Change" method="post" onsubmit="return checkform()">
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="2" height="25" class="title">修改密码</td>
  </tr>
  <tr>
    <td width="8%" class="line">旧的密码</td>
    <td width="92%" class="line"><input type="password" name="pwd" class="txt input200"  /></td>
  </tr>
  <tr>
    <td width="8%" class="line">新的密码</td>
    <td width="92%" class="line"><input type="password" name="pwd1" class="txt input200" value="" /></td>
  </tr>
  <tr>
    <td class="line">确认密码</td>
    <td class="line"><input type="password" name="pwd2" class="txt input200"  value="" /></td>
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
	var pwd = $.trim($("input[name=pwd]").val());
	var pwd1 = $.trim($("input[name=pwd1]").val());
	var pwd2 = $.trim($("input[name=pwd2]").val());
	if (pwd == '') {
		alert('请输入旧密码!');
		return false;
	}
	if (pwd1 != pwd2) {
		alert('2次输入密码不一致!');
		return false;
	}
	if (pwd1 == '') {
		alert('新密码不能为空!');
		return false;
	}
	
	return true;
}
{/literal}
</script>
</body>
</html>