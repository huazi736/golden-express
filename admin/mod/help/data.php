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

class data extends Action
{
	public function doDefault()
	{
		$sid = intval($_GET['sid']);
		
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from `data` where DataId='{$sid}'");
		if ($data && $data['DataId'] > 0)
		{
			$page = $this->app->page();
			$page->value('data', $data);
			$page->output();
			exit;	
		}		
		$this->showMsg('数据初始化错误, 请联系系统管理员!');
			
	}
	
	public function doSave()
	{
		extract($_POST, EXTR_SKIP);
		$DataId = intval($DataId);
		$data = array(
			'Content' => $Content,
			'UpdateTime' => date("Y-m-d H:i:s"),
		);
		$db = $this->app->orm()->query();
		$db->addTable('data');
		$db->addWhere('DataId', $DataId);
		$db->update($data);
		
		$this->showMsg('页面保存成功');
	}
}

$app->run();
?>