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

class add extends Action
{
	public function doDefault()
	{
		$page = $this->app->page();
		$page->output();		
	}
	
	public function dosaveBill()
	{
		$db = $this->app->orm()->query();
		$fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 'ToCountry', 'SendSign', 'FromPos', 'ToPos');
		$count = count($_POST['boxcount']);
		
		$data = array();
		foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		$data['CreateTime'] = date("Y-m-d H:i:s");
		$data['GoodsNum'] = count($_POST['boxcount']);
		$data['Type'] = 1;
		$data['UserId'] = $_SESSION['admin_uid'];
		$data['Status'] = 1;
		$data['BillKey'] = '';
		
		$db->clear();
		$db->addTable('bill');
		$db->insert($data);
		
		$box_data = array();
		
		for ($i = 1; $i <= $count; $i++)
		{
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
		
		$bid = $db->getLastId();
		
		if ($bid > 0)
		{
			$data = array(
				'BillId' => $bid,
				'Type' => 0,
				'CreateTime' => date("Y-m-d H:i:s"),
				'GoodsKey' => '',
				'Goods' => $box_data
			);
			$db->clear();
			$db->addTable('goods');
			$db->insert($data);
		}
		
		$this->showMsg('添加成功!');
	}
}

$app->run();
?>