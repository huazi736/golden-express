<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$data.Name}</title>
<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
<script type="text/javascript">
var url_js = '{$url_js}';
</script>
<script type="text/javascript" src="{$url_js}ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$url_js}ckfinder/ckfinder.js"></script>
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
    <td colspan="2" height="25" class="title">{$data.Name}</td>
  </tr>
  <tr>
    <td width="4%" class="line">内容<input name="DataId" value="{$data.DataId}" type="hidden" /></td>
    <td width="96%" class="line"><textarea name="Content" id="Content" cols="45" rows="10" style="height:200px">{$data.Content|html}</textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="button" id="button" value="保存并发布" class="btn" /></td>
  </tr>
  
</table>
</form>
<br />
<div class="bottom">{$cfg.footer}</div>
<script type="text/javascript">
{literal}
window.onload = function() {
	CKEDITOR.replace( 'Content', {height: 300} );
}
{/literal}
</script>
</body>
</html>