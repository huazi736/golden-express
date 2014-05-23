<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>幻灯片管理</title>
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
<form action="?do=Save" method="post" enctype="multipart/form-data" name="myform">
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="5" height="25" class="title">首页幻灯片管理1</td>
  </tr>
  <tr>
    <td width="9%" class="line"><strong>标题</strong></td>
    <td width="91%" colspan="4" class="line"><input type="text" name="title[]" class="txt" style="width:300px" value="{$play[0].title}" /></td>
  </tr>
  <tr>
    <td class="line"><strong>链接</strong></td>
    <td colspan="4" class="line"><input type="text" name="link[]" class="txt" style="width:300px" value="{$play[0].link}" /></td>
  </tr>
  <tr>
    <td><strong>图片</strong></td>
    <td colspan="4"><input type="file" name="file[]" />{if !empty($play[0].img)} <br /> <img src="{$play[0].img}" alt="" /> {/if}</td>
  </tr>
</table>

<br />
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="5" height="25" class="title">首页幻灯片管理2</td>
  </tr>
  <tr>
    <td width="9%" class="line"><strong>标题</strong></td>
    <td width="91%" colspan="4" class="line"><input type="text" name="title[]" class="txt" style="width:300px" value="{$play[1].title}"/></td>
  </tr>
  <tr>
    <td class="line"><strong>链接</strong></td>
    <td colspan="4" class="line"><input type="text" name="link[]"class="txt" style="width:300px" value="{$play[1].link}"  /></td>
  </tr>
  <tr>
    <td><strong>图片</strong></td>
    <td colspan="4"><input type="file" name="file[]" />{if !empty($play[1].img)} <br /> <img src="{$play[1].img}" alt="" /> {/if}</td>
  </tr>
</table>
<br />
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="5" height="25" class="title">首页幻灯片管理3</td>
  </tr>
  <tr>
    <td width="9%" class="line"><strong>标题</strong></td>
    <td width="91%" colspan="4" class="line"><input type="text" name="title[]" class="txt" style="width:300px" value="{$play[2].title}"/></td>
  </tr>
  <tr>
    <td class="line"><strong>链接</strong></td>
    <td colspan="4" class="line"><input type="text" name="link[]" class="txt" style="width:300px" value="{$play[2].link}" /></td>
  </tr>
  <tr>
    <td><strong>图片</strong></td>
    <td colspan="4"><input type="file" name="file[]" />{if !empty($play[2].img)} <br /> <img src="{$play[2].img}" alt="" /> {/if}</td>
  </tr>
</table>
<br />
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td colspan="5" height="25" class="title">首页幻灯片管理4</td>
  </tr>
  <tr>
    <td width="9%" class="line"><strong>标题</strong></td>
    <td width="91%" colspan="4" class="line"><input type="text" name="title[]" class="txt" style="width:300px" value="{$play[3].title}"/></td>
  </tr>
  <tr>
    <td class="line"><strong>链接</strong></td>
    <td colspan="4" class="line"><input type="text" name="link[]" class="txt" style="width:300px" value="{$play[3].link}"/></td>
  </tr>
  <tr>
    <td><strong>图片</strong></td>
    <td colspan="4"><input type="file" name="file[]"/>{if !empty($play[3].img)} <br /> <img src="{$play[3].img}" alt="" /> {/if}</td>
  </tr>
</table>
<br />
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" class="content" bgcolor="#ffffff">
  <tr>
    <td><input type="submit" name="save" id="save" value="保存全部" class="btn" /></td>
    </tr>
</table>


</form>
<br />
<div class="bottom">{$cfg.footer}</div>

</body>
</html>