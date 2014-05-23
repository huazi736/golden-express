<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>查看订单 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
		<style type="text/css">
		{literal}
		label {font-weight:bold}
		{/literal}
		</style>
	</head>
	<body>
		{include file="header.tpl"}
		{if $error == true}
		<div class="body sub">
			<div class="content" style="float:none;width:auto">
				<h2 class="title-common" style="text-align:center">运单不存在或无权限查看</h2>
			</div>
		</div>
		{else}
		<div class="body sub">
			<div class="content" style="float:none;width:auto">
				<h2 class="title-common">查看订单 <input type="button" value=" 打印订单 " style="float:right" onclick="readyprint(this)"/></h2>
				
                 <!-- 寄件人 -->
                <div class="shipping_main clearfix">
                	<h3>寄件人</h3>
                    <ul class="ship_list">
                    	<li><span><label>寄件人：</label>{$bill.FromName}</span>
                        	<span><label>电话：</label>{$bill.FromPhone}</span></li>
                       <li><span><label>公司名称：</label>{$bill.FromCompany}</span></li>
                       <li><span><label>详细地址：</label>{$bill.FromAddr}</span></li>
                       <li><span><label>城市：</label>{$bill.FromCity}</span>
                       		<span><label>州或省份：</label>{$bill.FromProvince}</span>
                            <span><label>邮编区号：</label>{$bill.FromPost}</span>
                            <span><label>国家：</label>{$bill.FromCountry}</span></li>
                    </ul>
                </div>
                
                <!-- 收件人 -->
                <div class="shipping_main clearfix">
                	<h3>收件人</h3>
                    <ul class="ship_list">
                    	<li><span><label>收件人：</label>{$bill.ToName}</span>
                        	<span><label>电话：</label>{$bill.ToPhone}</span></li>
                       <li><span><label>公司名称：</label>{$bill.ToCompany}</span></li>
                       <li><span><label>详细地址：</label>{$bill.ToAddr}</span></li>
                       <li><span><label>城市：</label>{$bill.ToCity}</span>
                       		<span><label>州或省份：</label>{$bill.ToProvince}</span>
                            <span><label>邮编区号：</label>{$bill.ToPost}</span>
                            <span><label>国家：</label>{$bill.ToCountry}</span></li>
                    </ul>
                </div>
                
                <!-- 声明 -->
                <div class="mind">
                    <div>寄件人签字：<b>{$bill.SendSign}</b> (本运单所载协议，已读并同意)</div>
                </div>
               
			   <div class="shipping_main clearfix" id="mybox">
                	<h3>运单详情</h3>
					<div class="ship_c">
						<span class="mr30"><b>起运地：</b>{$bill.FromPos}</span>
						<span><b>目的地：</b>{$bill.ToPos}</span>
					</div>
                    <p class="totalNum"><b>总件数：</b><b class="_boxcount">{$bill.GoodsNum}</b> 件</p>
                    <!-- box -->
					
					{foreach from=$goods.Goods item=list}
                    <div class="ship_box">
                    	<div class="ship_c">							
							<span class="mr30">[第<span class="count">{$list.pos}</span>箱]</span>
							<span class="mr30">								
								重量：{$list.weight} {$list.unit}
							</span>
							<span>
								体积重量：{$list.bulk}（L*W*H）
						</div>
						
						<table class="table_s1">
							<colgroup>
								<col width="100"></col>
								<col width=""></col>
								<col width="220"></col>
							</colgroup>
							<tr>
								<th align="center">商品序号</th>
								<th align="center">货物详细描述</th>
								<th align="center">现金价值</th>
							</tr>
							{foreach from=$list.item item=val}
							<tr align="center">
							   <td>{$val.key}</td>
							   <td>{$val.info}</td>
							   <td>{$val.money}</td>
							</tr>
							{/foreach}
						 </table>
                    </div>
					{/foreach}

                </div>			
				
			</div>
			<div class="c"></div>
		</div>
		{/if}
		
		{include file="footer.tpl"}
		<script type="text/javascript">
		{literal}
		function readyprint(o)
		{
			$(o).hide();
			$("div.header, div.footer").hide();
			window.print();
		}
		{/literal}
		</script>
	</body>
</html>
