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
		$help_file =  dirname($this->app->cfg['path']['root']) . '/config/help.cfg.php';
		include $help_file;
		
		$id = trim($_GET['id']);
		list($key, $key2) = explode('-', $id);
		if (!$help_cfg[$key] || !$help_cfg[$key]['item'][$key2])
		{
			$id = '1-1';
			$key = 1;
			$key2 = 1;
		}
		
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from `data` where Type='{$id}'");
		if ($data && $data['DataId'] > 0)
		{
			// nothing to do
		}
		else 
		{
			// 初始化这条数据
			$data = array(
				'Name' => $help_cfg[$key]['item'][$key2]['name'],
				'Type' => $id,
				'Content' => '',
				'UpdateTime' => date("Y-m-d H:i:s")
			);
			$db->clear();
			$db->addTable('data');
			$db->insert($data);
			
		}
		
		$page = $this->app->page();
		$page->value('data', $data);
		$page->value('cate', $help_cfg);
		$page->value('item', $help_cfg[$key]['item'][$key2]);
		$page->output();
		exit;
			
	}
	
	public function doSave()
	{
		extract($_POST, EXTR_SKIP);
		$type = trim($Type);
		$data = array(
			'Content' => $Content,
			'UpdateTime' => date("Y-m-d H:i:s"),
		);
		$db = $this->app->orm()->query();
		$db->addTable('data');
		$db->addWhere('Type', $type);
		$db->update($data);
		
		$this->showMsg('页面保存成功');
	}
}

$app->run();
?>