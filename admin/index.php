<?php
/**
 * 管理入口
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: index.php 359 2009-12-02 03:11:50Z suning $
 */

define("NO_LOGIN", true);
require_once('./common.inc.php');

class index extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$smarty = $this->app->page();
		$smarty->output();
	}
	
	/**
	 * 检查账号密码
	 *
	 */
	public function doCheck()
	{
		$username = trim($_POST['username']);
		$pwd = md5(trim($_POST['password']));
		
		importModule("AdminUser.AdminUser");
		$adminuser = new AdminUser();
		$login = $adminuser->Login($username, $pwd);
		if ($login)
		{
			$this->app->redirect('admin.php');
		}		
		$smarty = $this->app->page();
		$smarty->value('notlogin', true);
		$smarty->output();
	}
	
	/**
	 * 退出登录
	 *
	 */
	public function dologout()
	{
		importModule("AdminUser.AdminUser");
		$adminuser = new AdminUser();
		$adminuser->Loginout();
		$this->app->redirect('index.php');
	}
}
$app->run();

?>