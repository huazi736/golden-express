<?php
/**
 * 管理用户
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id$
 */

class AdminUser
{
	public function Login($username, $pwd)
	{
		global $app;
		$db = $app->orm()->query();
		$db->addTable(TABLE_PREFIX . 'adminuser');
		$db->addWhere('Name', $username);
		$db->addWhere('Pass', $pwd);
		$userinfo = $db->getRow();
		if (isset($userinfo['UserId']) && $userinfo['UserId'] > 0)
		{
			$admininfo = array(
				'name' => $userinfo['Name'],
				'gid' => $userinfo['GroupId'],
			);
			if ($userinfo['GroupId'] > 0)
			{
				$db->clear();
				$db->addTable(TABLE_PREFIX . 'admingroup');
				$db->addWhere('GroupId', $userinfo['GroupId']);
				$groupinfo = $db->getRow();
				if (isset($groupinfo['GroupId']) && $groupinfo['GroupId'] > 0)
				{
					$groupdata = unserialize($groupinfo['Data']);
					$admininfo['gname'] = $groupinfo['Name'];
					if (is_array($groupdata) && count($groupdata) > 0)
					{
						$admininfo['group'] = $groupdata;
					}
					else 
					{
						$admininfo['group'] = false;
					}
					
				}
			}
			if ($admininfo['gid'] == 0)
			{
				$admininfo['gname'] = '创始人';
			}
			$_SESSION['admin_uid'] = $userinfo['UserId'];
			$_SESSION['admin_info'] = $admininfo;			
			return true;
		}
		return false;		
	}
	
	public function Loginout()
	{
		$_SESSION['admin_uid'] = NULL;
		$_SESSION['admin_info'] = NULL;
		return true;
	}
}
?>