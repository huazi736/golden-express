<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>客户个人中心 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
		<style type="text/css">
		{literal}
		#content dl dt {font-size:12px;color:blue;font-weight:bold;border-bottom:1px solid #ececec;padding:5px;background:#fff;cursor:pointer;font-family:Verdana}
		#content dl dd {display:none;margin:5px 0;}
		#content .box table {border-spacing:1px;border-collapse:separate}
		#content .box table td {padding:5px;}
		{/literal}
		</style>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content" id="content">
				<h2 class="title-common" style="color:red">将拆分运单为 {$num}</h2>

				<dl>
					<dt style="color:green">[-] 收起原运单货物列表</dt>
					<dd style="display:block">
						<div class="box">
							{foreach from=$good.Goods item=list}
							<table width="98%" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#f4f4f4">
							  <tr>
								<td colspan="3" bgcolor="#FFFFFF">箱子{$list.pos} 重量: {$list.weight} {$list.unit} 体积重量: {$list.bulk} （L*W*H）为0表示重量/体积未知</td>
							  </tr>
							  <tr>
								<td bgcolor="#EBF1FF">商品序号</td>
								<td bgcolor="#EBF1FF">货物详细描述</td>
								<td bgcolor="#EBF1FF">现金价值</td>
							  </tr>
							  {foreach from=$list.item item=list2}
							  <tr>
								<td bgcolor="#FFFFFF">{$list2.key}</td>
								<td bgcolor="#FFFFFF">{$list2.info}</td>
								<td bgcolor="#FFFFFF">{$list2.money}</td>
							  </tr>
							  {/foreach}
							</table>
							<br />
							{/foreach}
						</div>
					</dd>
				</dl>

				{foreach from=$nums item=val}
				<dl>
					<dt>[+] 展开运单{$val}</dt>
					<dd>

						<form name="submitbox{$val}" action="user.php?do=saveExplodeBill" method="post" item="{$val}" target="ajax_iframe">
						<div class="shipping_main clearfix">
							<h3>寄件人</h3>
							<ul class="ship_list">
								<li><label>用户账号：</label>{$smarty.session.ep_nick}</li>
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
					   
					   <div class="shipping_main clearfix mybox">
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
						<!--
						<div class="more_p">
							<a href="javascript://" class="btn_gray fr add_box"><span>增加箱子</span></a>
						</div>
						-->
						<input type="hidden" name="transport" value="{$transport.TransportId}" />
						<input type="hidden" name="pos" value="{$val}" />
						</form>

					</dd>
				</dl>
				{/foreach}
				

				<div>
					<div class="more_p">
						<a href="javascript://" class="btn_gray fl" style="margin-left:300px" id="add_bill"><span>提交运单</span></a>
					</div>
					<div style="clear:both;color:red;text-align:center">
						<ul id="submit_res">							
						</ul>
					</div>
				</div>
				<iframe src="about:blank" id="ajax_iframe" name="ajax_iframe" style="display:none"></iframe>		
			</div>

			
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
		<script type="text/javascript" src="{$url_js}box_explode.js"></script>
	</body>
</html>