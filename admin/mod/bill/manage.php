<?php 
/**
 * 管理首页
 * 
 * 
 * @author 苏宁 <suning@126.com>
 * 
 * $Id$
 */


require_once('../../common.inc.php');

class manage extends Action
{
	public function doDefault()
	{
		
		$bill_file = $this->app->cfg['path']['root'] . '../config/bill.cfg.php';
		include $bill_file;
		
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from bill");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$bills = $db->getArray("select * from bill order by CreateTime DESC", $offset, $pagesize);
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('bills', $bills);
		$smarty->value('pages', $pagehtml);
		$smarty->value('bill_cfg', $bill_status_cfg);
		$smarty->output();

	}
	
	public function doCancel()
	{
		$bid = intval($_GET['bid']);
		if ($bid > 0)
		{
			$db = $this->app->orm()->query();
			$db->addTable('bill');
			$db->addWhere('BillId', $bid);
			$db->addValue('Status', 0);
			$db->update();
		}
		$this->showMsg('取消成功!');
	}
	
	public function doEdit()
	{
	    $bid = intval($_GET['bid']);
	    if ($bid < 1)
	    {
	        $this->showMsg("非法运单号!");
	    }
	    
	    // 状态配置
	    $bill_file = $this->app->cfg['path']['root'] . '../config/bill.cfg.php';
		include $bill_file;
	    
	    // 取运单信息
	    $page = $this->app->page();
	    $db = $this->app->orm()->query();
	    $billinfo = $db->getRow("select * from bill where BillId={$bid}");
	    
	    // 取货物信息
	    $goods = array();
	    if ($billinfo && $billinfo['BillId'] > 0)
	    {
	        $goods = $db->getRow("select * from goods where BillId='{$billinfo['BillId']}' and Type=0");
			if ($goods && $goods['GoodsId'] > 0)
			{
				$goods['Goods'] = unserialize($goods['Goods']);
			}
	    }
	    	    
	    $page->value('bill', $billinfo);
		$page->value('goods', $goods);
		$page->value('bill_cfg', $bill_status_cfg);
		$page->params['template'] = 'mod/bill/edit.tpl';
		$page->output();
	}
	
	public function doSave()
	{
        $billid = intval($_POST['BillId']);
        $goodsid = intval($_POST['GoodsId']);
        if (empty($billid))
        {
            $this->showMsg("订单不存在");
        }
        $fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 
			'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 
			'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 
			'ToCountry', 'SendSign', 'FromPos', 'ToPos', 'Status', 'Price', 'BillKey');
	    foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		// 更新订单
		$db = $this->app->orm()->query();
		$db->addTable('bill');
		$db->addWhere('BillId', $billid);
		$db->update($data);
		
		// 更新货物
		$box_data = array();
		if (!empty($goodsid))
		{
		    for($i = 1; $i < 100; $i++)
		    {
		        if (!isset($_POST["unit{$i}"]) || empty($_POST["unit{$i}"]))
		        {
		            break;
		        }
		        $box_data[$i] = array(
		            'pos' => $i,
    				'weight' => $_POST['weight' . $i],
    				'unit' => $_POST['unit' . $i],
    				'bulk' => $_POST['bulk' . $i],
    				'item' => array()
		        );
		        foreach ($_POST['key' . $i] as $k => $v)
    			{
    				$box_data[$i]['item'][] = array(
    					'key' => $_POST['key' . $i][$k],
    					'info' => $_POST['info' . $i][$k],
    					'money' => $_POST['money' . $i][$k]
    				);
    			}
		    }
		    $box_data = serialize($box_data);
		    
		    $db->clear();
		    $db->addTable('goods');
    		$db->addWhere('GoodsId', $goodsid);
    		$db->update(array('Goods' => $box_data));
		}
		
		$this->showMsg("恭喜您, 运单修改成功!");
		
	}
}

$app->run();
?>