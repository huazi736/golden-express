<?php
/**
 * CMS 密码修改
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: password.php 22 2009-07-23 02:21:41Z suning $
 */

$global_allow_group = array(1, 2, 3, 4);
require_once('../../common.inc.php');

class password extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$smarty = $this->app->page();
		$smarty->params['template'] = 'admin/password.tpl';
		$smarty->output();
	}
	
	/**
	 * 修改密码
	 *
	 */
	public function doChangePwd()
	{
		extract($_POST, EXTR_SKIP);
		if (empty($password) || empty($pwd1) || empty($pwd2))
		{
			$this->showMsg('原密码,新密码不能为空!');
		}
		if ($pwd1 != $pwd2)
		{
			$this->showMsg('两次密码不一致!');
		}
		$db = $this->app->orm()->query();
		$db->addTable('User');
		$db->addField('Password');
		$db->addWhere('UserId', $_SESSION['uid']);
		$pwd = $db->getValue();
		if ($pwd != md5($password))
		{
			$this->showMsg('原密码不正确!');
		}
		
		$db->clear();
		$db->addTable('User');
		$db->addValue('Password', md5($pwd1));
		$db->addWhere('UserId', $_SESSION['uid']);
		$db->update();
		
		$this->showMsg('密码修改成功!', '/index.php', '_top');
				
	}
}
$app->run();

?>