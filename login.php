<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class login extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$page = $this->app->page();
		$page->output();	
	}
	
	public function doLogin()
	{
		$email = mysql_escape_string(trim($_POST['email']));
		$pwd = md5(trim($_POST['pwd']));
		
		$db = $this->app->orm()->query();
		$user = $db->getRow("select * from user where Email='{$email}' and Password='{$pwd}'");
		if ($user && $user['UserId'] > 0)
		{
			$_SESSION['ep_uid'] = $user['UserId'];
			$_SESSION['ep_nick'] = $user['RealName'];
			$_SESSION['ep_name'] = $user['RealName'];
			$this->output(array('status' => true));
		}
				
		$this->output(array('status' => false, 'msg' => '用户Email或者密码错误!'));
	}
	
	public function doLogout()
	{
		unset($_SESSION['ep_uid'], $_SESSION['ep_nick'], $_SESSION['ep_name']);
		if ($_SERVER['HTTP_REFERER'])
		{
			$this->app->redirect($_SERVER['HTTP_REFERER']);
		}
		$this->app->redirect('index.php');
	}
}
$app->run();

?>