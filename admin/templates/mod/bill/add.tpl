<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>客户个人中心</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}base.css" />
		<link rel="stylesheet" type="text/css" href="{$cfg.url.froot}public/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$cfg.url.froot}public/css/m.css"/>
		
		<script type="text/javascript" src="{$cfg.url.froot}public/js/jquery-1.6.2.min.js"></script>
		<style type="text/css">
		{literal}
			body {background: none repeat scroll 0 0 #F5FCFF}
			.body {width: 90%; margin:15px auto}
			.content {width: auto}
			.sub .content {float:none; width:auto;border:1px solid #B8D3E1}
			.shipping_main h3 {background: #EBF1FF}
		{/literal}
		</style>
	</head>
	<body>

		<div class="body sub">
			<form name="submitbox" action="add.php?do=saveBill" method="post">
			<div class="content">
				<h2 class="title-common">提交运单</h2>
                 <!-- 寄件人 -->
                <div class="shipping_main clearfix">
                	<h3>寄件人</h3>
                    <ul class="ship_list">
                    	<li><label>用户账号：</label>{$smarty.session.admin_info.name}</li>
                    	<li><span><label>寄件人：</label><input name="FromName" type="text" class="input-normal w-140" value=""/></span>
                        	<span><label>电话：</label><input name="FromPhone" type="text" class="input-normal w-140" value=""/></span></li>
                       <li><span><label>公司名称：</label><input name="FromCompany" type="text" class="input-normal w-380" value=""/></span></li>
                       <li><span><label>详细地址：</label><input name="FromAddr" type="text" class="input-normal w-380" value=""/></span></li>
                       <li><span><label>城市：</label><input name="FromCity" type="text" class="input-normal w-80" value=""/></span>
                       		<span><label>州或省份：</label><input name="FromProvince" type="text" class="input-normal w-80" value=""/></span>
                            <span><label>邮编区号：</label><input name="FromPost" type="text" class="input-normal w-80" value=""/></span>
                            <span><label>国家：</label><input name="FromCountry" type="text" class="input-normal w-80" value=""/></span></li>
                    </ul>
                </div>
                
                <!-- 收件人 -->
                <div class="shipping_main clearfix">
                	<h3>收件人</h3>
                    <ul class="ship_list">
                    	<li><span><label>收件人：</label><input name="ToName" type="text" class="input-normal w-140" value=""/></span>
                        	<span><label>电话：</label><input name="ToPhone" type="text" class="input-normal w-140" value=""/></span></li>
                       <li><span><label>公司名称：</label><input name="ToCompany" type="text" class="input-normal w-380" value=""/></span></li>
                       <li><span><label>详细地址：</label><input name="ToAddr" type="text" class="input-normal w-380" value=""/></span></li>
                       <li><span><label>城市：</label><input name="ToCity" type="text" class="input-normal w-80" value=""/></span>
                       		<span><label>州或省份：</label><input name="ToProvince" type="text" class="input-normal w-80" value=""/></span>
                            <span><label>邮编区号：</label><input name="ToPost" type="text" class="input-normal w-80" value=""/></span>
                            <span><label>国家：</label><input name="ToCountry" type="text" class="input-normal w-80" value=""/></span></li>
                    </ul>
                </div>
                
                <!-- 声明 -->
                <div class="mind">
                	<p><b class="f_red">Sender’s signature:</b> 
Use of this Air Waybill Constitutes your agreement to conditions in the contract on the back of this Air Waybill and you certify that this shipment does not require a U.S.State Department License or contain Dangerous Goods Gertain intermationl treaties,including the Warsaw Convention.may apply to this shipment and limit our liability for damage.loss,or delay,as described in the contract.
                	</p>
                    <div>寄件人签字：<input name="SendSign" type="text" class="input-normal w-140 mr10" value=""/>(本运单所载协议，已读并同意)</div>
                </div>
               
			   <div class="shipping_main clearfix" id="mybox">
                	<h3>运单详情</h3>
					<div class="ship_c">
						<span class="mr30">起运地：<input name="FromPos" type="text" class="input-normal w-140 mr10" value=""/></span>
						<span>目的地：<input name="ToPos" type="text" class="input-normal w-140 mr10" value=""/></span>
					</div>
                    <p class="totalNum">总件数：<b class="_boxcount">1</b> 件</p>
                    <!-- box -->
                    <div class="ship_box">
                    	<div class="ship_c">							
							<input name="boxcount[]" type="hidden" value="1" />
							<a class="close" href="javascript://" title="删除箱子" style="display:none">删除</a>
							<span class="mr30">[第<span class="count">1</span>箱]</span>
							<span class="mr30">								
								重量：<input name="weight1" type="text" class="input-normal w-60 mr10" value=""/>
								<label><input name="unit1" type="radio" value="kg" checked="checked">Kg</label>
								<label><input name="unit1" class="ml10" type="radio" value="lb">Lb</label>
							</span>
							<span>
								体积重量：<input name="bulk1" type="text" class="input-normal w-60 mr10" value=""/></span>（L*W*H）
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
				<div class="more_p">
					<a href="javascript://" class="btn_gray fl ml200" id="add_bill"><span>提交运单</span></a>
				</div>
				<div class="clearfix"></div>
				
			</div>
			</form>
			<div class="c"></div>
		</div>

		<br />
		<div class="bottom">{$cfg.footer}</div>

		<script type="text/javascript" src="{$cfg.url.froot}public/js/box.js"></script>
	</body>
</html>
