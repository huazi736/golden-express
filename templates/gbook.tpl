<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>客户留言 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
        	<form name="myform" action="?do=Submit" method="post">
			<div class="content">
				<h2 class="title-common">客户留言</h2>
				<div class="list-form">
					<ul>
                    	<li><label><span class="red">*</span> 标题：</label><input name="Title" type="text" class="input-normal w-280" value=""/></li>
                        <li><label><span class="red">*</span> 类型：</label>
                        <select name="Type">
                        	<option value="1">留言</option>
                            <option value="2">建议</option>
                            <option value="3">投诉</option>
                        </select>
                        </li>
                        <li><label><span class="red">*</span> 姓名：</label><input name="Name" type="text" class="input-normal w-280" value=""/></li>
                        <li><label><span class="red">*</span> Email：</label><input name="Email" type="text" class="input-normal w-280" value=""/></li>
                        <li><label><span class="red">*</span> 电话：</label><input name="Phone" type="text" class="input-normal w-280" value=""/></li>
                        <li><label><span class="red">*</span> 内容：</label><div class="textContent"><textarea name="Content" class="textarea-normal w-90"></textarea></div></li>
                    </ul>
					
					<p class="more_p" style="padding-left: 65px;">
					   <a class="btn_gray fl" href="javascript://" onclick="checkform()"><span>提 交</span></a>
					</p>
				</div>			
				
			</div>
            </form>
			{include file="left_contact.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}	
        <script type="text/javascript">
		{literal}
		function checkform()
		{
			var flag = false;
			$("form input,textarea").each(function() {
				if ($(this).val() == '')
				{
					alert('待填写字段不能为空');
					flag = true;
					return false;
				}
			});
			if (flag) {
				return false;
			}
			document.myform.submit()
			return true;
		}
		{/literal}
		</script>		
	</body>
</html>
