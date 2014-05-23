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

class password extends Action
{
	public function doDefault()
	{
		$page = $this->app->page();
		$page->output();		
	}
	
	public function doChange()
	{
		extract($_POST, EXTR_SKIP);
		if (!empty($_SESSION['admin_uid']))
		{
			$db = $this->app->orm()->query();
			$db->addTable('sn_adminuser');
			$db->addValue('Pass', md5($pwd1));
			$db->addWhere('UserId', $_SESSION['admin_uid']);
			$db->addWhere('Pass', md5($pwd));
			$db->update();
			
			$count = $db->getAffectRows();
			if ($count > 0)
			{
				$this->showMsg('密码修改成功!');
			}
		}
		$this->showMsg('密码修改失败, 原密码不正确!');
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