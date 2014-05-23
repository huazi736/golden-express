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

class user extends Action
{
	public function doDefault()
	{
		echo 123;
		$page = 1;
		importModule("Admin.AdminMod");
		$admin = new AdminMod();
		$admin->showList($this->_getUserTableInfo(), $page);
		
	}
	
	public function doGroup()
	{
		// 
	}
	
	private function _getUserTableInfo()
	{
		return array(
			'UserId' => '用户ID',
			'Name' => '用户名',
			'GroupId' => '所属分组',			
			'Email' => '邮件地址',
			'Phone' => '联系方式',
			'_table' => 'AdminUser',
			'_pagesize' => PAGE_SIZE,
			'_control' => array(
				'1' => array(
					'name' => '编辑',
					'link' => ''
				),
				'2' => array(
					'name' => '删除',
					'link' => ''
				)
			)
		);
	}
}

$app->run();
?>