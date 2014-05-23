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
		#trans_explode {border:1px solid #E1E1E1;margin: 0 10px;padding:20px 0 0 20px;height:75px;}
		#trans_explode div {padding-bottom:5px}
		{/literal}
		</style>
	</head>
	<body>
		{include file="header.tpl"}
		<div class="body sub">
			<div class="content">
				<h2 class="title-common">历史货运</h2>
				<div class="uc_main clearfix">
                    <div class="table">
                        <table class="table_s1"  id="td_trans">
                            <colgroup>
                                <col width="150"></col>
                                <col width="120"></col>
                                <col width=""></col>
                                <col width="200"></col>
                                <col width="200"></col>
                            </colgroup>
                            <tr>
                                <th>美国运单编号</th>
                                <th>创建日期</th>
                                <th>状态</th>
                                <th>仓库</th>
                                <th>操作</th>
                            </tr>
							{foreach from=$trans item=list}
                            <tr align="center">
                                <td align="left"><label><input type="checkbox" name="transid[]" value="{$list.TransportId}" {if $list.Status != 0}disabled="disabled"{/if}/> {$list.BillKey}</label></td>
                                <td>{$list.CreateTime}</td>
                                <td>{if $list.Status == 0}入库{elseif $list.Status == 1}出库{elseif $list.Status == 2}已提交{/if}</td>
                                <td>{$list.WarehouseName}</td>
                                <td>
                                	{if $list.Status != 2}
									<a href="user.php?do=AddBillFromTransport&tid={$list.TransportId}" target="_blank">提交运单</a>
									<a href="javascript://" onclick="explode_bill('{$list.TransportId}', '{$list.BillKey}')">拆分运单</a>
									{else}
									已提交
									{/if}
								</td>
                            </tr>
							{/foreach}
							 <tr align="left">
								<td colspan="5">
									<label><input id="ipt_ck" type="checkbox" name="checkall" value="1"/> 全选</label> 
									<input type="button" value="合并提交运单" onclick="submit_bill()" />
								</td>
							 </td>
                          </table>

						  <div id="trans_explode" style="display:none">
							<div>运单编号: <span id="explode_bill_key"></span><input type="hidden" name="explode_id" value="" /></div>
							<div>
								拆分数目:
								<select name="explode_num">
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
								</select>
							</div>
							<div style="text-align:center">
								<a href="javascript://" onclick="start_explode()">开始拆分</a>  
								<a href="javascript://" onclick="location.reload()">取消拆分</a>
							</div>
						  </div>
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
				$("#td_trans").find("input[name='transid[]']").not("[disabled]").attr('checked', 'checked');
			} else {
				$("#td_trans").find("input[name='transid[]']").removeAttr('checked');
			}
		});
		function submit_bill()
		{
			var tids = [];
			$("#td_trans").find("input[name='transid[]']:checked").each(function() {
				tids.push($(this).val());
			});
			if (tids.length == 0) {
				alert('请选择要合并的货运单');
				return false;
			}
			location = 'user.php?do=AddBillFromTransport&tid=' + tids.join(",");
			return false;
		}
		function explode_bill(tid, billkey)
		{
			$("#td_trans").hide();
			$("#explode_bill_key").text(billkey);
			$("input[name=explode_id]").val(tid);
			$("#trans_explode").slideDown();

		}
		function start_explode()
		{
			var tid = $("input[name=explode_id]").val();
			var num = $("select[name=explode_num] option:selected").val();
			location = 'user.php?do=explodeBill&tid=' + tid + '&num=' + num;
			return false;
		}
		{/literal}
		</script>
	
	</body>
</html>
