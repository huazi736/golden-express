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
		$db = $this->app->orm()->query();
		$groups = $db->getArray("select GroupId,Name from sn_admingroup", -1);
		$page = $this->app->page();
		$page->value('groups', $groups);
		$page->output();		
	}
	
	public function doAdd()
	{
		extract($_POST, EXTR_SKIP);
		
		$db = $this->app->orm()->query();
		$uid = $db->getValue("select UserId from sn_adminuser where Name='" . mysql_escape_string($Name) ."'");
		if ($uid > 0)
		{
			$this->showMsg('用户名已经被使用!');
		}
				
		$data = array(
			'GroupId' => $GroupId,
			'Name' => $Name,
			'Pass' => md5($Pass),
			'CreateTime' => date("Y-m-d H:i:s"),
			'Email' => $Email,
			'Phone' => $Phone
		);
		$db->clear();
		$db->addTable('sn_adminuser');
		$db->insert($data);
		
		$this->showMsg('用户添加成功');
		
		
	}
}

$app->run();
?>