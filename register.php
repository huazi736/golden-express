<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class register extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$db = $this->app->orm()->query();
		$cs = $db->getArray("select UserId,Name from sn_adminuser where GroupId=4", -1);
		
		$page = $this->app->page();
		$page->value("cs", $cs);
		$page->output();	
	}
	
	public function doReg()
	{
		extract($_POST, EXTR_SKIP);
		$Name = '';
		$Password1 = trim($Password1);
		$Password2 = trim($Password2);
		if ($Password1 != $Password2)
		{
			$this->output(array('status' => false, 'msg' => '两次输入密码不一致'));
		}
		$db = $this->app->orm()->query();
		$uid = $db->getValue("select UserId from user where Email='" . mysql_escape_string($Email) . "'");
		if ($uid > 0)
		{
			$this->output(array('status' => false, 'msg' => '用户Email已经被使用'));
		}
		
		$data = array(
			'Name' => $Name,
			'Password' => md5($Password1),
			'RealName' => $RealName,
			'Phone' => $Phone,
			'Email' => $Email,
		    'Adress' => $Adress,
		    'Qq' => $Qq,
			'CreateTime' => date("Y-m-d H:i:s"),
			'ServiceId' => $ServiceId
		);
		
		$db->clear();
		$db->addTable('user');
		$db->insert($data);
		
		$this->output(array('status' => true));
	}
	
}
$app->run();

?>