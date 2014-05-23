<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>{$site_title} 消息提示</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="expires" content="0">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<style type="text/css">
{literal}
body{background:#f5fcff;font-family:Verdana;color:#333;font-size:12px;}
img{border:0}
*{margin:0;padding:0;}
ul{list-style-type:none;}
a{color:#067098;text-decoration:none;}
a:hover{color:#FF6600;}
.input,.input2 input{border: 1px solid;border-color: #c0c0c0 #ededed #ededed #c0c0c0;padding:2px 0px 1px 1px;font-size:12px;vertical-align:middle;color:#000;margin-bottom:.3em;margin-right:.3em;}
.btn{background:#d9d9d9;border-width:1px;vertical-align:middle;height:21px;padding-left:0.15em;padding-right:0.15em;border: 1px solid; border-color: #c0c0c0 #555 #555 #c0c0c0;}
select{border: 1px solid;border-color: #c0c0c0 #ededed #ededed #c0c0c0;}
.btn2{cursor:pointer;border:1px solid #b8d3e1;color:#333333;padding:2px 5px 1px 5px; font-family:simsun;background:#f7fbff;}
textarea{border: 1px solid;border-color: #c0c0c0 #ededed #ededed #c0c0c0;font-size:12px;}
.tal{text-align:left}
.tac{text-align:center}
.tar{text-align:right}
.fr{float:right}
.fl{float:left}
.w{font-weight:normal;}
.c{clear:both;height:0;overflow:hidden;}
.cc{clear:both;margin-right:1em;border-top:1px solid #91c900;height:1px;}
.s1{color:#006699;} /*蓝*/
.s2{color:#1e5494;} /*深蓝*/
.s3{color:#008800;}
.gray{color:#888;}
.f14{font-size:14px;}
.b{font-weight:bold;}
.tt{margin:1em;color:#555;}
.bottom{text-align:center;height:30px;line-height:30px;border-top:1px solid #b8d3e1;}
.bottom {position:absolute;bottom:0;right:0;width:100%;}

/*提示样式*/
.message{margin:auto;width:500px;border:3px solid #b0cee6;background:#fff;}
.message .fl{margin:10px;}
.message .fr{text-align:left;line-height:30px;width:280px;margin-top:1.8em;}
{/literal}
</style>

</head>
<body>
<div class="tt">

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<div class="message" style="line-height:25px;">
<table width="100%">
<tr><td width="150" class="tac">
<img src="{$url_images}{$pic}"></td><td class="tal">
<p>{$msg}</p>

<p>

<a href="{$url}" target="{$target}">点 击 继 续 操 作</a>

</p>
</td></tr>
</table>
</div>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
<br/>
<br/>

</div>
<div class="bottom">{$cfg.footer}</div>
</body></html>
<!---->