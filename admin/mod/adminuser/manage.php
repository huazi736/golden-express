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

class manage extends Action
{
	public function doDefault()
	{
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		
		$groups = $db->getArray("select GroupId,Name from sn_admingroup", -1);
		$group_table = array();
		foreach ($groups as $v)
		{
			$group_table[$v['GroupId']] = $v['Name'];
		}
		
		$count = $db->getValue("select count(*) from sn_adminuser");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$users = $db->getArray("select* from sn_adminuser order by CreateTime DESC", $offset, $pagesize);		
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('users', $users);
		$smarty->value('group_table', $group_table);
		$smarty->value('pages', $pagehtml);

		$smarty->output();		
	}
	
	public function doDel()
	{
		$uid = intval($_GET['uid']);
		if ($uid == 1)
		{
			$this->showMsg('为了系统稳定, 超级管理员不能被删除!');
		}
		if ($uid > 0)
		{
			$db = $this->app->orm()->query();
			$db->exec("delete from sn_adminuser where UserId='{$uid}' limit 1");
		}
		$this->showMsg('用户已经删除成功');
	}
	
	public function doEdit()
	{
		$uid = intval($_GET['uid']);
		if ($uid == 1)
		{
			$this->showMsg('为了系统稳定, 超级管理员不能被编辑!');
		}
		
		$db = $this->app->orm()->query();
		$user = $db->getRow("select * from sn_adminuser where UserId='{$uid}'");
		$groups = $db->getArray("select GroupId,Name from sn_admingroup", -1);
		if ($user && $user['UserId'] > 0)
		{
			$smarty = $this->app->page();
			$smarty->params['template'] = 'mod/adminuser/edit.tpl';
			$smarty->value('user', $user);
			$smarty->value('groups', $groups);
			$smarty->output();
			exit;
		}		
		$this->showMsg('新闻不存在!');
		
	}
	
	public function doSave()
	{
		extract($_POST, EXTR_SKIP);
		$UserId = intval($UserId);		
		$data = array(
			'GroupId' => $GroupId,
			'Name' => $Name,
			'Email' => $Email,
			'Phone' => $Phone
		);
		if (!empty($Pass))
		{
			$data['Pass'] = md5($Pass);
		}
		if ($UserId > 0)
		{
			$db = $this->app->orm()->query();
			$db->addTable('sn_adminuser');
			$db->addWhere('UserId', $UserId);
			$db->update($data);
		}
			
		$this->showMsg('用户修改成功');
	}
}

$app->run();
?>