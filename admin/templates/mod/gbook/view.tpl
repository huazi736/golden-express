<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>反馈管理</title>
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
    <td colspan="3" height="25" class="title">反馈管理</td>
  </tr>
  <tr>
    <td width="11%" class="line"><strong>标题</strong></td>
    <td class="line">{$gbook.Title|html}</td>
  </tr>
  <tr>
    <td class="line"><strong>类型</strong></td>
    <td class="line">{if $gbook.Type == 1}留言{elseif $gbook.Type == 2}建议{else}投诉{/if}</td>
  </tr>
  <tr>
    <td class="line"><strong>姓名</strong></td>
    <td class="line">{$gbook.Name|html}</td>
  </tr>
  <tr>
    <td class="line"><strong>Email</strong></td>
    <td class="line">{$gbook.Email|html}</td>
  </tr>
  <tr>
    <td class="line"><strong>电话</strong></td>
    <td class="line">{$gbook.Phone|html}</td>
  </tr>
  <tr>
    <td class="line"><strong>内容</strong></td>
    <td class="line">{$gbook.Content|html}</td>
  </tr>
  <tr>
    <td colspan="3"><input type="button" class="btn" value="返回列表" onclick="history.back()" /></td>
    </tr>
  
</table>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>