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
		.pages {text-align:left;line-height:24px;color:#999;width:auto;float:right;margin-right:20px;margin-top:20px}
		.pages a{text-decoration:none;color:#439FD3;border:1px solid #E6F2FB;background-color:#F3F9FD;text-align:center;display:block;padding:0 8px;width:auto;float:left;margin-right:2px;}
		.pages a:hover{text-decoration:none;color:#439FD3;background-color:#D9ECF7;border:1px solid #439FD3;}
		.pages strong {text-decoration:none;color:#000;border:1px solid #E6F2FB;background-color:#F3F9FD;text-align:center;display:block;padding:0 8px;width:auto;float:left;margin-right:2px;}
		{/literal}
		</style>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2 class="title-common">历史运单</h2>
                <div class="search clearfix" style="background:#E5E5E5;text-align:center;padding:8px">金链接付款账号：jinlianjie@alipay.com</div>
                <div class="search clearfix" style="background:#E5E5E5;text-align:center;padding:8px">
                	运单编号: <input type="text" class="input-normal w-100" name="search_BillId" id="search_BillId" /> <input type="button" value="搜索" onclick="search_bill('search_BillId', 'BillId')" />
                	快递单号: <input type="text" class="input-normal w-100" name="search_Billkey" id="search_BillKey" /> <input type="button" value="搜索" onclick="search_bill('search_BillKey', 'BillKey')"  />
                </div>
				<div class="uc_main clearfix">
                    <div class="table">
                        <table class="table_s1" id="td_trans">
                            <colgroup>
                                <col width="100"></col>
                                <col width="120"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="100"></col>
								 <col width="100"></col>
                            </colgroup>
                            <tr>
                                <th>运单编号</th>
                                <th>创建日期</th>
                                <th>城市</th>
                                <th>收货人</th>
                                <th>状态</th>
                                <th>快递单号</th>
								<th>支付费用</th>
                                <th>操作</th>
                            </tr>
							{foreach from=$bills item=list}
                            <tr align="center">
                                <td><label><input type="checkbox" name="billsid[]" value="{$list.BillId}" price="{$list.Price}" /> {$list.BillId}</label></td>
                                <td>{$list.CreateTime|truncate:'10':''}</td>
                                <td>{$list.ToCity}</td>
                                <td>{$list.ToName}</td>
                                <td>{$bill_cfg[$list.Status]}</td>
                                <td>{if empty($list.BillKey)}未指定{else}{$list.BillKey}{/if}</td>
								 <td>{if $list.Price ==0 }等待定价{else}{$list.Price}{/if}</td>
                                <td>
									<a href="bill.php?bid={$list.BillId}" target="_blank">查看</a>
									<a href="javascript://" onclick="pay('{$list.Price}', '{$list.BillId}')">立即支付</a>
								</td>
                            </tr>
                            {foreachelse}
                            <tr align="center">
                            	<td colspan="8">
                            		{if !$searchmod}
                            			还未产生运单
                            		{else}
                            			未搜索到结果
                            		{/if}
                            	</td>
                            </tr>
							{/foreach}
							<tr align="left">
								<td colspan="8" style="padding-left:30px">
									{if !$searchmod}
									<label><input id="ipt_ck" type="checkbox" name="checkall" value="1"/> 全选</label> 
									<input type="button" value="合并付款" onclick="payall()" /></td>
									{else}
									<input type="button" value="返回查看全部运单" onclick="location='user.php?do=bill'" />
									{/if}
									
							 </td>
                          </table>
                     </div>
                     <!-- 分页 -->
                    <div class="pages">{$pages}</div>
                     <!-- 分页end -->
				</div>
				
			</div>
			{include file="user_left.tpl"}
			<div class="c"></div>
		</div>
		{include file="footer.tpl"}
		<script type="text/javascript">
		{literal}
		$("#ipt_ck").click(function() {
			if ($(this).is(":checked")) {
				$("#td_trans").find("input[name='billsid[]']").attr('checked', 'checked');
			} else {
				$("#td_trans").find("input[name='billsid[]']").removeAttr('checked');
			}
		});
		function pay(price, billid)
		{
			if (price == 0) {
				alert('等待定价中, 请定价完成后支付!');
				return false;
			}
			if (price > 0) {
				var str = "付款说明:\n 您要支付的订单ID为:" + billid + "\n 您要支付的金额是:" + price + "\n\n 点击[确定]转跳到支付页面";
				if (confirm(str)) {
					window.open('http://www.alipay.com/');
				}
			}
		}
		function payall()
		{
			var bill = {'count': 0, bills: [], price: 0};
			$("#td_trans").find("input[name='billsid[]']:checked").each(function() {
				var billid = $(this).val(),
					price = parseInt($(this).attr('price'), 10);
				if (price > 0) {
					bill.count ++;
					bill.bills.push(billid);
					bill.price += price
				}
			});

			if (bill.count == 0) {
				alert('请至少选择一个已经定价的订单!');
				return false;
			}
			if (bill.count > 0) {
				var str = "付款说明:\n 您要支付的订单ID有:" + bill.bills.join(",") + "\n 您要支付的总金额是:" + bill.price + "\n\n 点击[确定]转跳到支付页面";
				if (confirm(str)) {
					window.open('http://www.alipay.com/');
				}
			}

			console.log(bill);

		}
		function search_bill(id, type)
		{
			var search_txt = $.trim($('#' + id).val());
			if (search_txt.length > 0) {
				location = 'user.php?do=bill&search_type=' + type + '&id=' + search_txt;
				return false;
			}			
		}
		{/literal}
		</script>
	</body>
</html>
