<?php 
/**
 * 管理首页
 * 
 * 
 * @author 苏宁 <suning@126.com>
 * 
 * $Id: manage.php 6 2012-04-04 07:54:11Z suning $
 */


require_once('../../common.inc.php');

class manage extends Action
{
	public function doDefault()
	{
		
		$warehouse_file = $this->app->cfg['path']['root'] . '../config/warehouse.cfg.php';
		include $warehouse_file;
		
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from transport");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$transports = $db->getArray("select * from transport order by TransportId DESC", $offset, $pagesize);
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('transports', $transports);
		$smarty->value('pages', $pagehtml);
		$smarty->value('warehouse_cfg', $warehouse_cfg);
		$smarty->output();

	}	
		
	public function doEdit()
	{
	    $tid = intval($_GET['tid']);
	    if ($tid < 1)
	    {
	        $this->showMsg("非法货运号!");
	    }
	    
	    // 状态配置
	    $warehouse_file = $this->app->cfg['path']['root'] . '../config/warehouse.cfg.php';
		include $warehouse_file;
	    
	    // 取运单信息
	    $page = $this->app->page();
	    $db = $this->app->orm()->query();
	    $transportinfo = $db->getRow("select * from transport where TransportId={$tid}");
	    
	    // 取货物信息
	    $goods = array();
	    if ($transportinfo && $transportinfo['TransportId'] > 0)
	    {
	        $goods = $db->getRow("select * from goods where BillId='{$transportinfo['TransportId']}' and Type=1");
			if ($goods && $goods['GoodsId'] > 0)
			{
				$goods['Goods'] = unserialize($goods['Goods']);
			}
	    }
	    	    
	    $page->value('bill', $transportinfo);
		$page->value('goods', $goods);
		$page->value('warehouse_cfg', $warehouse_cfg);
		$page->params['template'] = 'mod/transport/edit.tpl';
		$page->output();
	}
	
	public function doSave()
	{
        $TransportId = intval($_POST['TransportId']);
        $goodsid = intval($_POST['GoodsId']);
        if (empty($TransportId))
        {
            $this->showMsg("订单不存在");
        }
        $fields = array('Status', 'WarehouseId', 'BillKey', 'BillName');
	    foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		// 更新订单
		$db = $this->app->orm()->query();
		$db->addTable('transport');
		$db->addWhere('TransportId', $TransportId);
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
		
		$this->showMsg("恭喜您, 货运单修改成功!");
		
	}
}

$app->run();
?>