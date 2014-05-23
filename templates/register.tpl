<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户注册 - {$cfg.site.title}</title>
		<link rel="stylesheet" type="text/css" href="{$url_css}reset.css"/>
		<link rel="stylesheet" type="text/css" href="{$url_css}m.css"/>
		<script type="text/javascript" src="{$url_js}jquery-1.6.2.min.js"></script>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2 class="title-common">用户注册(系统需要审核用户信息,请认真填写)</h2>
				<div class="list-form" style=" padding: 30px 0 0 80px;">
					<ul>
                    	<li><label>邮件地址：</label><input name="Email" type="text" class="input-normal w-280" value=""/> <span class="red">*</span></li>
                        <li><label>用户密码：</label><input name="Password1" type="password" class="input-normal w-280" value=""/> <span class="red">*</span></li>
                        <li><label>确认密码：</label><input name="Password2" type="password" class="input-normal w-280" value=""/> <span class="red">*</span></li>
                        <li><label>用户姓名：</label><input name="RealName" type="text" class="input-normal w-280" value=""/> <span class="red">*</span></li>
                        <li><label>联系电话：</label><input name="Phone" type="text" class="input-normal w-280" value=""/> <span class="red">*</span></li>
						<li><label>联系地址：</label><input name="Adress" type="text" class="input-normal w-280" value=""/></li>
						<li><label>用户QQ：</label><input name="Qq" type="text" class="input-normal w-280" value=""/></li>
						<li><label>客服编号：</label>
                            <select id="ServiceId" name="ServiceId" class="w-280">
                            	{foreach from=$cs item=list}
                            	<option value="{$list.UserId}">{$list.Name}</option>
                                {/foreach}
                                <option value="0">还未指定客服编号</option>
                            </select>
                        </li>
                        <li><label>协议：</label><input id="agreement" type="checkbox" name="agreement" value="1" /> 我同意并遵守金链接服务协议</li>
                    </ul>
					
					<p class="more_p" style="padding-left: 65px;">
					   <a class="btn_gray fl" href="javascript://" onclick="register()"><span>注 册</span></a>
					</p>
					
					<p style="clear:both">&nbsp;</p>
					<textarea style="width:400px;height:100px" readonly="readonly">
					国际快件邮寄须知

凡属使用本公司国际快递服务的客户，被认为自动接收和遵守本公司的承运条款：
       安全条款：邮寄人清楚的知道包裹或邮件内不允许夹带任何易燃易爆、易腐蚀、放射性、毒性的危险物品、麻醉药物、精神药品、现金、以及法律禁止邮寄的物品；违者将承担相关法律责任。
       保费：按照5%计算，金卡VIP的保费为2.5%，以一个地址为一票计，保额最高不超过$500美金，电子类产品和高档货物价值超过$500美金的，本公司一律不提供保险，客户需向本公司提供包裹详情单和形式发票。
理赔：客户在不买保险的情况下，发生丢失或损坏，本公司的赔偿金额最多不超过$100美金，在货物的重量不超过10磅，客户没有在邮寄前主动向本公司提供货物详情单和发票的情况下，对货物的估值以1磅10美金计，最多不超过$100美金的赔偿金；如果客户要求全额赔偿，并且在货物邮寄之前主动向我公司提供货物清单和发票，我公司可以考虑按照客户在邮寄初期，所提供的货物发票价值进行赔偿，但赔偿的方式是采取在我公司邮寄货物并付运费之后，在本公司标准运费的基础上，抵扣20%作为对客户的赔偿；以此方式来累计我公司赔偿客户的全部货值，如果客户终止在我公司运输，则本公司不再履行对此客户的赔偿义务；以上两种赔偿办法只能选其一； 
海关罚没：保费是对运输的过程中发生货物损坏或丢失的担保，但保费不能取代关税、同时也不能为对非正常报关形式下的运输，而导致的海关扣货和罚没等进行担保；要选择全保险，客户必须不仅购买保险，同时履行正式报关手续。
收货与货物丢失、损坏的确认：如果想得到很恰当的理赔处理，客户在收件时需注意检查货物缺损情况，发现异常，如丢失、或者损坏，收件人在第一时间内可做如下处理：
1，	要求派件公司根据货物签收的实际情况签字。
2，	及时在3天之内，向本公司索赔部门和中国派送公司挂失，挂失时需提供美国单号和中国派送公司转单号；
3，	申请索赔要求如下：①登录我公司网站索取索赔表格，请严格按照表格格式的要求，认真填写索赔申请表；②客户一定要提供货物的美国运单号和中国配送转单号，③严格按照表格的要求提供所有可能对丢失或者损坏原因有利的图片、发票、签收记录等证据，④对于不按时支付运费的客户本公司有权拒绝理赔。
4，	客户在收件时未提出包裹有损坏或丢失，将被视为包裹在完好无缺的情况下签收, 超过30个 工作日才来挂失和索赔的，一律不予受理
5，	我司理赔部门在确定客户的包裹确实是丢失之后，即开始受理理赔。
       重要声明：本人认真阅读过，并同意运单背面的安全条款，承诺所寄包裹没有包含安全条款内禁止的货物，本人将会告知收件人，在收件当时，如发现包裹有丢失和破损，会当即让配送员签字证明，同时立即向我公司挂失。
					
					</textarea>
					

				</div>				
				
			</div>
			{include file="left_contact.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
		<script type="text/javascript">
		{literal}
		function register()
		{
			var empty_flag = false,
				params = {};
			if ($("#agreement:checked").val() != '1')
			{
				alert('请阅读注册协议并同意!');
				return false;
			}
			$("div.list-form input,select").each(function() {				
				if ($(this).val() == "") {
					if ($(this).attr('name') != 'Adress' && $(this).attr('name') != 'Qq') {
						empty_flag = true;
						return false;
					}					
				}
				params[$(this).attr('name')] = $(this).val();
			});
			if (empty_flag) {
				alert('请填写带*号注册字段!');
				return false;
			}

			var email = params['Email'];
			if (!/^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*(\.[a-zA-Z0-9]+[-a-zA-Z0-9]*)+[a-zA-Z0-9]+$/.test(email))
			{
				alert('请填写正确的Email');
				return false;
			}

			
			$.post('?do=reg', params, function(json) {
				if (json.status) {
					alert("注册成功");
					location = 'login.php';
				} else {
					alert(json.msg);
				}
			}, 'json');
			return false;
		}
		{/literal}
		</script>
	</body>
</html>
