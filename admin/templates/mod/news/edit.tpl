<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻编辑</title>
<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
<script type="text/javascript">
var url_js = '{$url_js}';
</script>
<script type="text/javascript" src="{$url_js}jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="{$url_js}ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$url_js}ckfinder/ckfinder.js"></script>
<script type="text/javascript" src="{$url_js}My97DatePicker/WdatePicker.js"></script>
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
    <td colspan="2" height="25" class="title">新闻编辑<input type="hidden" name="NewsId" class="txt input200" value="{$news.NewsId}"/></td>
  </tr>
  <tr>
    <td width="8%" class="line">标题<span class="red">*</span></td>
    <td width="92%" class="line"><input type="text" name="Title" class="txt input200" value="{$news.Title|html}"/></td>
  </tr>
  <tr>
    <td width="8%" class="line">作者</td>
    <td width="92%" class="line"><input type="text" name="Author" id="Author" class="txt input200" value="{$news.Author|html}" /></td>
  </tr>
  <tr>
    <td width="8%" class="line">来源</td>
    <td width="92%" class="line"><input type="text" name="From" id="From" class="txt input200"  value="{$news.From|html}"/></td>
  </tr>
  <tr>
    <td class="line">时间</td>
    <td class="line"><input type="text" name="CreateTime" id="CreateTime" class="txt input200" onclick="WdatePicker()"  value="{$news.CreateTime}"/></td>
  </tr>
  <tr>
    <td class="line">置顶</td>
    <td class="line"><input name="Top" type="checkbox" id="Top" value="1" {if $news.Top == 1}checked="checked"{/if} />
      置顶</td>
  </tr>
  <tr>
    <td class="line">标题颜色</td>
    <td class="line"><input type="radio" name="Color"value="red" {if $news.Color == 'red'}checked="checked"{/if} />
      <span class="red">红色</span> 
      <input type="radio" name="Color" value="green" {if $news.Color == 'green'}checked="checked"{/if}  />
 <span class="green">绿色</span>
<input type="radio" name="Color" value="blue" {if $news.Color == 'blue'}checked="checked"{/if}  />
 <span class="blue">蓝色</span> </td>
  </tr>
  <tr>
    <td class="line">内容<span class="red">*</span></td>
    <td class="line"><textarea name="Content" id="Content" cols="45" rows="5">{$news.Content|html}</textarea></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
    <td><input type="submit" name="button" id="button" value="编辑保存" class="btn" /></td>
  </tr>
  
</table>
</form>
<br />
<div class="bottom">{$cfg.footer}</div>
<script type="text/javascript">
{literal}
window.onload = function() {
	CKEDITOR.replace( 'Content' );
}
function checkform()
{
	if ($("input[name='Title']").val() == '') {
		alert('请填写标题');
		return false;
	}
	/*
	if ($('#Content').val() == '') {
		alert('请填写内容');
		return false;
	}*/
	return true;
}
{/literal}
</script>
</body>
</html>