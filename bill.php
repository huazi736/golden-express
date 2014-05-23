<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class bill extends Action
{
	
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$bid = intval($_GET['bid']);
		$uid = $_SESSION['ep_uid'];
		$admin_uid = $_SESSION['admin_uid'];		
		$page = $this->app->page();
		
		if ($bid > 0 && (!empty($uid) || !empty($admin_uid)))
		{
			$db = $this->app->orm()->query();
			if (!empty($admin_uid))
			{
				$bill = $db->getRow("select * from bill where BillId={$bid}");
			}
			else if (!empty($uid))
			{
				$bill = $db->getRow("select * from bill where BillId='{$bid}' and UserId='{$uid}'");
			}

			if ($bill && $bill['BillId'] > 0)
			{
				$goods = $db->getRow("select * from goods where BillId='{$bill['BillId']}'");
				if ($goods && $goods['GoodsId'] > 0)
				{
					$goods['Goods'] = unserialize($goods['Goods']);
				}
				$page->value('bill', $bill);
				$page->value('goods', $goods);
				$page->output();
				exit;			
			}
		}
		$page->value('error', true);
		$page->output();
	}
	
	
	
	public function doBill()
	{
		$bill_file = $this->app->cfg['path']['conf'] . 'bill.cfg.php';
		include $bill_file;
		
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from bill where UserId='{$this->uid}' and Type=0");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$bills = $db->getArray("select * from bill where UserId='{$this->uid}' and Type=0 order by CreateTime DESC", $offset, $pagesize);
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?do=bill&page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('bills', $bills);
		$smarty->value('pages', $pagehtml);
		$smarty->value('bill_cfg', $bill_status_cfg);
		
		$smarty->params['template'] = 'user/bill.tpl';

		$smarty->output();
	}
	
}
$app->run();

?>