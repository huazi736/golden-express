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
		
		$count = $db->getValue("select count(*) from user");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$users = $db->getArray("select * from user order by CreateTime DESC", $offset, $pagesize);
		
		$sids = array();
		$server_table = array();
		foreach ((array) $users as $v)
		{
			$sids[$v['ServiceId']] = $v['ServiceId'];
		}
		if (count($sids) > 0)
		{
			$services = $db->getArray("select UserId,Name from sn_adminuser where GroupId=4");
			foreach ((array)$services as $v)
			{
				$server_table[$v['UserId']] = $v['Name'];
			}
		}
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('users', $users);
		$smarty->value('stable', $server_table);
		$smarty->value('pages', $pagehtml);

		$smarty->output();		
	}
	
	public function doEdit()
	{
		$uid = intval($_GET['uid']);
		
		$db = $this->app->orm()->query();
		
		$user = $db->getRow("select * from user where UserId='{$uid}'");
		$services = $db->getArray("select UserId,Name from sn_adminuser where GroupId=4");
		
		
		if ($user && $user['UserId'] > 0)
		{
			$smarty = $this->app->page();
			$smarty->params['template'] = 'mod/user/edit.tpl';
			$smarty->value('user', $user);
			$smarty->value('services', $services);
			$smarty->output();
			exit;
		}		
		$this->showMsg('用户不存在!');
		
	}
	
	public function doSave()
	{
		extract($_POST, EXTR_SKIP);
		$UserId = intval($UserId);
		$Vip = $Vip == 1 ? 1 : 0;
		$data = array(
			'Name' => $Name,
			'Email' => $Email,
			'Phone' => $Phone,
			'RealName' => $RealName,
			'Price' => $Price,
			'ServiceId' => $ServiceId,
			'Vip' => $Vip
		);
		if (!empty($Pass))
		{
			$data['Password'] = md5($Pass);
		}
		
		if ($UserId > 0)
		{
			$db = $this->app->orm()->query();
			$db->addTable('user');
			$db->addWhere('UserId', $UserId);
			$db->update($data);
		}
			
		$this->showMsg('用户修改成功');
	}
}

$app->run();
?>