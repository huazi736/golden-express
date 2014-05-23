<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>客户个人中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<form name="submitbox" action="user.php?do=addTran" method="post">
		<div class="body sub">
			<div class="content">
				<h2 class="title-common">美国订单</h2>
				

                <div class="shipping_main clearfix">
                	<h3>第一步：选择到货仓库</h3>
                    <ul>
                    	<li><em class="f_red">*</em>到货仓库选择：
							<select name="WarehouseId">
								<option value="0">选择到货仓库</option>
								{foreach from=$warehouse_cfg key=key item=list}
								<option value="{$key}">{$list}</option>
								{/foreach}
							</select>
						</li>
                        <li><em class="f_red">*</em>美国快递单号：<input name="TranBillKey" type="text" class="input-normal w-380" value=""/></li>
						 <li><em class="f_red">*</em>快递公司名称：<input name="TranBillName" type="text" class="input-normal w-380" value=""/></li>
                    </ul>
                </div>
                
				
                <div class="shipping_main clearfix" id="mybox">
                	<h3>第二步：货物明细</h3>
					
                    <!-- box -->
                    <div class="ship_box">
                    	<div class="ship_c">
							<input name="boxcount[]" type="hidden" value="1" />
							<a class="close" href="javascript://" title="删除箱子" style="display:none">删除</a>
							<span class="mr30">[第<span class="count">1</span>箱]</span>
							<span class="mr30">								
								重量：<input name="weight1" type="text" class="input-normal w-60 mr10" value="0"/>
								<label><input name="unit1" type="radio" value="kg" checked="checked">Kg</label>
								<label><input name="unit1" class="ml10" type="radio" value="lb">Lb</label>
							</span>
							<span>
								体积重量：<input name="bulk1" type="text" class="input-normal w-60 mr10" value="0"/></span>（L*W*H）
								为0表示重量/体积未知
						</div>
						
						<table class="table_s1">
							<colgroup>
								<col width="100"></col>
								<col width=""></col>
								<col width="220"></col>
								<col width="200"></col>
							</colgroup>
							<tr>
								<th align="center">商品序号</th>
								<th align="center">货物详细描述</th>
								<th align="center">现金价值</th>
								<th align="center">管理</th>
							</tr>								
							<tr align="center" class="start">
							   <td><input name="key1[]" type="text" class="input-normal w-100"/></td>
							   <td><input name="info1[]" type="text" class="input-normal w-380"/></td>
							   <td><input name="money1[]" type="text" class="input-normal w-80"/></td>
							   <td><a href="javascript://" class="addnew">新增</a></td>
							</tr>
						 </table>
                    </div>                    
                </div>
				
				<div class="more_p">
					<a href="javascript://" class="btn_gray fr" id="add_box"><span>增加箱子</span></a>
				</div>
				<div class="clearfix"></div>
				<br />

				<div class="more_p">
					<a href="javascript://" class="btn_gray fl ml200" id="submit_box"><span>提交货物转运单</span></a>
				</div>

                
                <!-- 第二步 end -->
				
				
			</div>
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		</form>
		{include file="footer.tpl"}
		<script type="text/javascript" src="{$url_js}box.js"></script>	
	</body>
</html>
